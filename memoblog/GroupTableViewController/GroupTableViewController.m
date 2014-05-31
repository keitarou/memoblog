//
//  GroupTableViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "GroupTableViewController.h"

#import "Group.h"
#import "GroupCell.h"

@interface GroupTableViewController ()

@end

@implementation GroupTableViewController

/**
 * 利用するセルを設定する
 */
- (void)initTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupCell" bundle:nil] forCellReuseIdentifier:@"GroupCell"];
    self.title = [self getTitle];
}

/**
 * メニューを開くボタンの作成と、メニューを開くジェスチャーの設定
 * TODO: ジェスチャーがうまくいっていない。。
 */
- (void)initMenuBtn
{
    UIBarButtonItem* sidebarButton = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
    [sidebarButton setTarget: self.revealViewController];
    [sidebarButton setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

/**
 * 表示順をトグル変更するボタンの表示
 */
- (void)initOrderToggleBtn
{
    self.isReverse = false;
    UIBarButtonItem* orderToggleButton = [[UIBarButtonItem alloc]initWithTitle:@"↓↑" style:UIBarButtonItemStylePlain target:self action:@selector(orderToggle)];
    [self.navigationItem setRightBarButtonItem:orderToggleButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    [self initMenuBtn];
    [self initOrderToggleBtn];
    
    self.groups = [NSMutableArray array];
    [self getGroupsRequest];
}

/**
 *  取得リクエスト
 */
- (void)getGroupsRequest
{
    // ユーザー操作無効でローディング表示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString* url = [NSString stringWithFormat:@"%@", BASE_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:[self getRequestParam]
         success:^(AFHTTPRequestOperation *operation, id json) {
             
             // json取得後はそれぞれの継承先のクラスで独自に実装させる
             [self generateGroupsByJson:json];
             [self.tableView reloadData];
             [SVProgressHUD dismiss];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD dismiss];
         }
     ];
}

/**
 *  セルの数を返す
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groups count];
}

/**
 *  セルの情報を返す
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Group* group    = [self.groups objectAtIndex:indexPath.row];
    GroupCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    [cell setGroup:group];
    
    return cell;
}

/**
 *  表示されているタグでの表示順を変更する
 */
- (void) orderToggle
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    self.isReverse = !self.isReverse;
    self.groups = [Group sortObjects:self.groups reverse:self.isReverse];
    [self.tableView reloadData];
    
    [SVProgressHUD dismiss];
}

/**
 *  セルがクリックされた時の処理
 *  オーバーライドさせる
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return;
}

/**
 *  ビューのタイトルを取得する
 *  オーバーライドさせる
 *
 */
- (NSString*) getTitle
{
    return nil;
}

/**
 *  取得したjsonをパースしてループしたりでアイテムを格納する
 *  オーバーライドさせる
 *
 *  @param json
 */
- (void)generateGroupsByJson:(id)json
{
    return;
}

/**
 *  json取得用のパラメータを返す
 *  オーバーライドさせる
 *
 */
- (NSDictionary *) getRequestParam
{
    return nil;
}

@end
