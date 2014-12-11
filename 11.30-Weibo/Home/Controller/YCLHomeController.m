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
#import "AFNetworking.h"
#import "YCLAccount.h"
#import "YCLAccountTool.h"
#import "YCLStatus.h"
#import "YCLUser.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

// 微博数据请求连接
#define kHome_timeline @"https://api.weibo.com/2/statuses/home_timeline.json"

@interface YCLHomeController ()<YCLPopMenuDelegate>
/** 微博数据 */
@property (strong, nonatomic) NSMutableArray *statuses;
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
    
    // 设置导航栏按钮
    [self setupNavigationBarItem];

    // 添加下拉刷新
    [self addRefreshControl];
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
    titleButton.frameW = 100;
    titleButton.frameH = 44;
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setBackgroundImage:[UIImage resizableImageNamed:@"navigationbar_title_highlighted"] forState:UIControlStateHighlighted];
    
    [titleButton addTarget:self action:@selector(titleButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
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
 *    加载微博数据
 */
- (void)loadMoreStatus:(UIRefreshControl *)refreshControl {
    NSLog(@"刷新微博");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *requestParas = [NSMutableDictionary dictionary];
    YCLAccount *account = [YCLAccountTool readAccount];
    requestParas[@"access_token"] = account.access_token;
    YCLStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // 只获取比上一条微博的 id 大的微博
        requestParas[@"since_id"] = firstStatus.idstr;
    }
    requestParas[@"count"] = @10;
    
    [manager GET:kHome_timeline parameters:requestParas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 字典数组转换成模型数组
        NSArray *addedNewStatus = [YCLStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 新微博应该添加到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, addedNewStatus.count)];
        [self.statuses insertObjects:addedNewStatus atIndexes:indexSet];
        [self.tableView reloadData];
        // 停止刷新
        [refreshControl endRefreshing];
        NSLog(@"新增%lu条微博", addedNewStatus.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败  --- %@", error);
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
    [refreshControl addTarget:self action:@selector(loadMoreStatus:) forControlEvents:UIControlEventValueChanged];
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
