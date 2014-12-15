//
//  HomeController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/11/30.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLHomeController.h"
#import "UIBarButtonItem+ItemByImage.h"
#import "UIImage+YCLImage.h"
#import "UIView+YCLGeometry.h"
#import "YCLHomeTitleButton.h"
#import "YCLPopMenu.h"
//#import "AFNetworking.h"
#import "YCLHttpTool.h"
#import "YCLAccount.h"
#import "YCLAccountTool.h"
#import "YCLStatus.h"
#import "YCLUser.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "YCLRefreshView.h"

#import "YCLStatusRequestParameter.h"
#import "YCLStatusTool.h"
#import "YCLStatusResponseResult.h"

// 微博数据请求连接
//#define kHome_timeline @"https://api.weibo.com/2/statuses/home_timeline.json"

#define kUser_show @"https://api.weibo.com/2/users/show.json"

@interface YCLHomeController ()<YCLPopMenuDelegate>
/** 微博数据 */
@property (strong, nonatomic) NSMutableArray *statuses;
/** 标题按钮 */
@property (weak, nonatomic) YCLHomeTitleButton *titleButton;
@end

@implementation YCLHomeController

- (NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [NSMutableArray arrayWithCapacity:0];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self requestUserInfo];
    
    // 设置导航栏按钮
    [self setupNavigationBarItem];

    // 添加下拉刷新
    [self addRefreshControl];
    
    // 添加footerView, 提示上拉可加载微博
    [self addFooterView];
}

/**
 *    设置导航栏按钮
 */
- (void)setupNavigationBarItem {
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" hightedImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsSearch)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" hightedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间标题按钮
    YCLHomeTitleButton *titleButton = [[YCLHomeTitleButton alloc] init];
//    titleButton.frameW = 150;
    titleButton.frameH = 35;
    NSString *titleName = [YCLAccountTool readAccount].name ? [YCLAccountTool readAccount].name : @"首页";
    [titleButton setTitle:titleName forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setBackgroundImage:[UIImage resizableImageNamed:@"navigationbar_title_highlighted"] forState:UIControlStateHighlighted];
    
    [titleButton addTarget:self action:@selector(titleButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}

/**
 *    监听标题按钮点击
 *
 *    @param sender 标题按钮
 */
- (void)titleButtonOnClicked:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 创建弹出菜单
    UISwitch *sw = [[UISwitch alloc] init];
    YCLPopMenu *popMenu = [YCLPopMenu popMenuWithContentView:sw];
    [popMenu showInRect:CGRectMake(200, 55, 100, 200)];
    popMenu.dimBackground = NO;
    popMenu.popMenuType = YCLPopMenuTypeLeft;
    popMenu.delegate = self;
}

/**
 *    access_token  false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *    uid           false	int64	需要查询的用户ID。
 *    screen_name   false	string	需要查询的用户昵称。
 */
- (void)requestUserInfo {
    NSMutableDictionary *requestParas = [NSMutableDictionary dictionary];
    YCLAccount *account = [YCLAccountTool readAccount];
    requestParas[@"access_token"] = account.access_token;
    requestParas[@"uid"] = account.uid;
    
    [YCLHttpTool GET:kUser_show parameters:requestParas success:^(id responseObject) {
        YCLUser *user = [YCLUser objectWithKeyValues:responseObject];
        NSLog(@"%@", user.name);
        // 保存用户名
        YCLAccount *account = [YCLAccountTool readAccount];
        if (![account.name isEqualToString:user.name]) {
            // 保存用户信息
            account.name = user.name;
            [YCLAccountTool saveAccount:account];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

/**
 *    加载新微博数据
 */
- (void)loadMoreNewerStatus:(UIRefreshControl *)refreshControl {
    NSLog(@"加载新微博");
    YCLStatusRequestParameter *requestParas = [[YCLStatusRequestParameter alloc] init];
    requestParas.access_token = [YCLAccountTool readAccount].access_token;
    YCLStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // 只获取比上一条微博 id 大的微博
        requestParas.since_id = @([firstStatus.idstr longLongValue]);
    }
    requestParas.count = @20;

    [YCLStatusTool statusWithParameters:requestParas success:^(YCLStatusResponseResult *responseResult) {
        NSLog(@"微博请求成功");
        NSArray *addedNewStatus = responseResult.statuses;
        // 新微博应该添加到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, addedNewStatus.count)];
        [self.statuses insertObjects:addedNewStatus atIndexes:indexSet];
        [self.tableView reloadData];
        // 停止刷新
        [refreshControl endRefreshing];
        [self showNewStatusCount:(int)addedNewStatus.count];
    } failure:^(NSError *error) {
        NSLog(@"微博请求失败  --- %@", error);
        // 停止刷新
        [refreshControl endRefreshing];
    }];
}


/**
 *    添加刷新控件
 */
- (void)addRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(loadMoreNewerStatus:) forControlEvents:UIControlEventValueChanged];
}

/**
 *    显示新微博数
 *
 *    @param count 微博数
 */
- (void)showNewStatusCount:(int)count {
    UILabel *label = [[UILabel alloc] init];
    label.frameX = 0;
    label.frameY = self.navigationController.navigationBar.frameH;
    label.frameW = self.tableView.frameW;
    label.frameH = 22;
    if (count) {
        label.text = [NSString stringWithFormat:@"新增了%d条新微博",count];
    } else {
        label.text = @"目前还没有新微薄，再来一次？";
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor orangeColor];
    label.alpha = 0;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1 animations:^{
        label.alpha = 1;
        label.frameY += 22;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            label.frameY -= 22;
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];

    }];
}

/**
 *    加载旧微博数据
 */
- (void)loadMoreOlderStatus:(UIRefreshControl *)refreshControl {
    NSLog(@"加载旧微博");
    YCLStatusRequestParameter *requestParas = [[YCLStatusRequestParameter alloc] init];
    requestParas.access_token = [YCLAccountTool readAccount].access_token;
    YCLStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        // 只获取比上一条微博的 id 大的微博
        requestParas.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    requestParas.count = @1;
    
    [YCLStatusTool statusWithParameters:requestParas success:^(YCLStatusResponseResult *responseResult) {
        NSLog(@"微博请求成功");
        NSArray *addedOldStatuses = responseResult.statuses;
        // 旧微博应该添加到最后面
        [self.statuses addObjectsFromArray:addedOldStatuses];
        [self.tableView reloadData];
        // 停止刷新
        [refreshControl endRefreshing];
        [self showOldStatusCount:(int)addedOldStatuses.count];
    } failure:^(NSError *error) {
        NSLog(@"微博请求失败  --- %@", error);
        // 停止刷新
        [refreshControl endRefreshing];
    }];
}

/**
 *    显示旧微博数
 *
 *    @param count 微博数
 */
- (void)showOldStatusCount:(int)count {
    UILabel *label = [[UILabel alloc] init];
    label.frameX = 0;
    label.frameY = self.tabBarController.tabBar.frameY;
    label.frameW = self.tableView.frameW;
    label.frameH = 22;
    if (count) {
        label.text = [NSString stringWithFormat:@"新增了%d条旧微博",count];
    } else {
        label.text = @"貌似没刷出来啊，再来一次？";
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor orangeColor];
    label.alpha = 0;
    [self.tabBarController.view insertSubview:label belowSubview:self.tabBarController.tabBar];
    [UIView animateWithDuration:1 animations:^{
        label.alpha = 1;
        label.frameY -= 22;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            label.frameY += 22;
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
}

// 添加footerView, 提示上拉可加载微博
- (void)addFooterView {
    self.tableView.tableFooterView = [YCLRefreshView refreshView];
}

#pragma mark - UITableViewS
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat currentY = scrollView.contentOffset.y;scrollView.contentSize.height + RefreshViewHight
//    if (currentY >= 64) {
//        [self loadMoreOlderStatus:nil];
//    }
    
    CGFloat y1 = scrollView.contentOffset.y + scrollView.frame.size.height;
    CGFloat y2 = scrollView.contentSize.height + 49;

    NSLog(@"%.0f", y1 - y2);
    
    if (y1 - y2 == 0) {
        [self loadMoreOlderStatus:nil];
    }
}

#pragma mark - YCLPopMenuDelegate
- (void)popMenuDidDismiss:(YCLPopMenu *)popMenu {
    // 获取 标题按钮
    YCLHomeTitleButton *titleButton = (YCLHomeTitleButton *)self.navigationItem.titleView;
    // 设置箭头向下
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)friendsSearch {
    NSLog(@"索索好友");
}

- (void)pop {
    NSLog(@"pop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 当微博数据为空的时候，隐藏；有数据的时候，显示
    self.tableView.tableFooterView.hidden = (self.statuses.count == 0);
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    YCLStatus *status = self.statuses[indexPath.row];
    YCLUser *user = status.user;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"navigationbar_account_check"]];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    // push 时，隐藏底部bar
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
