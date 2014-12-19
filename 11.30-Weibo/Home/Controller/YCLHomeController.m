//
//  HomeController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/11/30.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

// 控制器相关
#import "YCLHomeController.h"
#import "UIBarButtonItem+ItemByImage.h"
#import "UIImage+YCLImage.h"
#import "UIView+YCLGeometry.h"
#import "YCLHomeTitleButton.h"
#import "YCLPopMenu.h"
#import "UIImageView+WebCache.h"
#import "YCLRefreshView.h"
// 微博、用户数据相关
#import "YCLAccount.h"
#import "YCLAccountTool.h"
#import "YCLStatus.h"
#import "YCLUser.h"
// 微博数据获取
#import "YCLStatusTool.h"
#import "YCLStatusRequestParameter.h"
#import "YCLStatusResponseResult.h"
// 用户数据获取
#import "YCLUserRequestTool.h"
#import "YCLUserRequestParameter.h"
#import "YCLUserResponseResult.h"
// 微博cell相关
#import "YCLStatusFrame.h"
#import "YCLStatusCell.h"
#import "YCLStatusStyle.h"


@interface YCLHomeController ()<YCLPopMenuDelegate>
/** statusFrame数据 */
@property (strong, nonatomic) NSMutableArray *statusFrames;

/** 标题按钮 */
@property (weak, nonatomic) YCLHomeTitleButton *titleButton;
@end

@implementation YCLHomeController

- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray arrayWithCapacity:0];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏按钮
    [self setupNavigationBarItem];
    
    // 获取用户信息
    [self requestUserInfo];

    // 添加下拉刷新
    [self addRefreshControl];
    
    // 添加footerView, 提示上拉可加载微博
    [self addFooterView];
    
    // 先加载一次微博数据
    [self loadMoreNewerStatus:nil];
    
    // 去掉分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = kBackgroudColor;
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
 *    获取授权用户信息
 */
- (void)requestUserInfo {
    YCLUserRequestParameter *requestParas = [[YCLUserRequestParameter alloc] init];
    YCLAccount *account = [YCLAccountTool readAccount];
    requestParas.access_token = account.access_token;
    requestParas.uid = @([account.uid longLongValue]);
    
    [YCLUserRequestTool userWithParameters:requestParas success:^(YCLUserResponseResult *responseResult) {
        YCLUser *user = responseResult;
        // 保存用户名
        YCLAccount *account = [YCLAccountTool readAccount];
        if (![account.name isEqualToString:user.name]) {
            // 保存用户信息
            account.name = user.name;
            [YCLAccountTool saveAccount:account];
        }
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        NSLog(@"请求用户信息失败 - %@", error);
    }];
}

/**
 *    加载新微博数据
 */
- (void)loadMoreNewerStatus:(UIRefreshControl *)refreshControl {
    NSLog(@"加载新微博");
    YCLStatusRequestParameter *requestParas = [[YCLStatusRequestParameter alloc] init];
    requestParas.access_token = [YCLAccountTool readAccount].access_token;
    YCLStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    if (firstStatusFrame.status) {
        // 只获取比上一条微博 id 大的微博
        requestParas.since_id = @([firstStatusFrame.status.idstr longLongValue]);
    }
    requestParas.count = @20;

    [YCLStatusTool statusWithParameters:requestParas success:^(YCLStatusResponseResult *responseResult) {
        NSLog(@"微博请求成功");
        NSArray *addedNewStatusFrames = [self statusFramesWithStatuses:responseResult.statuses];
        // 新微博应该添加到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, addedNewStatusFrames.count)];
        [self.statusFrames insertObjects:addedNewStatusFrames atIndexes:indexSet];
        [self.tableView reloadData];
        // 停止刷新
        [refreshControl endRefreshing];
        [self showNewStatusCount:(int)addedNewStatusFrames.count];
    } failure:^(NSError *error) {
        NSLog(@"微博请求失败  --- %@", error);
        // 停止刷新
        [refreshControl endRefreshing];
    }];
}

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses {
    NSMutableArray *statusFramesM = [NSMutableArray arrayWithCapacity:0];
    for (YCLStatus *status in statuses) {
        YCLStatusFrame *statusFrame = [[YCLStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFramesM addObject:statusFrame];
    }
    return [statusFramesM copy];
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
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1;
        label.frameY += 22;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
    YCLStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    if (lastStatusFrame) {
        // 只获取比上一条微博的 id 大的微博
        requestParas.max_id = @([lastStatusFrame.status.idstr longLongValue] - 1);
    }
    requestParas.count = @10;
    
    [YCLStatusTool statusWithParameters:requestParas success:^(YCLStatusResponseResult *responseResult) {
        NSLog(@"微博请求成功");
        NSArray *addedOldStatusFrames = [self statusFramesWithStatuses:responseResult.statuses];
        // 旧微博应该添加到最后面
        [self.statusFrames addObjectsFromArray:addedOldStatusFrames];
        [self.tableView reloadData];
        // 停止刷新
        [refreshControl endRefreshing];
        [self showOldStatusCount:(int)addedOldStatusFrames.count];
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
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1;
        label.frameY -= 22;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"%s", __func__);
    
    CGFloat y1 = scrollView.contentOffset.y + scrollView.frame.size.height;
    CGFloat y2 = scrollView.contentSize.height + 49;
    
    if (y1 - y2 >= 100) {
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
    self.tableView.tableFooterView.hidden = (self.statusFrames.count == 0);
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCLStatusCell *cell = [YCLStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCLStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    // push 时，隐藏底部bar
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
