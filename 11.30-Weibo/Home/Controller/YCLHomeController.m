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

// 微博数据请求连接
#define kHome_timeline @"https://api.weibo.com/2/statuses/home_timeline.json"

@interface YCLHomeController ()<YCLPopMenuDelegate>
/** 微博数据 */
@property (strong, nonatomic) NSArray *statuses;
@end

@implementation YCLHomeController

- (NSArray *)statuses {
    if (!_statuses) {
        _statuses = [NSArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // 设置导航栏按钮
    [self setupNavigationBarItem];
    
    // 加载微博数据
    [self loadStatus];
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
- (void)loadStatus {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *requestParas = [NSMutableDictionary dictionary];
    YCLAccount *account = [YCLAccountTool readAccount];
    requestParas[@"access_token"] = account.access_token;
    requestParas[@"count"] = @10;
    [manager GET:kHome_timeline parameters:requestParas success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求成功  --- %@", responseObject);
        
        // 保存微博数据
        NSArray *statusesDict = responseObject[@"statuses"];
        NSMutableArray *statusesM = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *statusDict in statusesDict) {
            YCLStatus *status = [YCLStatus statusWithDictionary:statusDict];
            [statusesM addObject:status];
        }
        self.statuses = [statusesM copy];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败  --- %@", error);
    }];
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 异步并发获取头像
        NSURL *avatarURL = [NSURL URLWithString:user.profile_image_url];
        NSData *avatarData = [NSData dataWithContentsOfURL:avatarURL];
        UIImage *avatar = [UIImage imageWithData:avatarData];
        // 货到主线程设置头像
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.imageView.image = avatar;
        });
    });
    
    cell.textLabel.text = user.name;
//    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = status.text;
    
//    cell.textLabel.text = [NSString stringWithFormat:@"HomeCell-%2ld", indexPath.row];
    
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
