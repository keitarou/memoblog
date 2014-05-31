//
//  MyAppAdTableViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/12.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "MyAppAdTableViewController.h"

@interface MyAppAdTableViewController ()

@end

@implementation MyAppAdTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"おすすめアプリ";
    
    // tableviewの設定
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAppAdCell" bundle:nil] forCellReuseIdentifier:@"MyAppAdCell"];
//    self.tableView.separatorColor  = [UIColor clearColor];
//    self.tableView.backgroundColor = [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.000];
    

    // サイドバーを開くボタンと・スライドで戻れるようにする
    // TODO: スライドが効かない
    UIBarButtonItem* sidebarButton = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
    [sidebarButton setTarget: self.revealViewController];
    [sidebarButton setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    
    [self refleshTableView];
}


- (void) refleshTableView;
{
    self.apps = [NSMutableArray array];

    // ユーザー操作無効でローディング表示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString* url        = MY_APP_AD_URL;
    NSDictionary* params = [NSDictionary dictionary];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id json) {
             // Jsonをぶん回して_apps配列にインスタンスを登録していく
             // "trackId"とSELF_APP_APP_IDが同じなら表示しない
             // TODO: ソートに関してもここのタイミングで実装する必要がある
             for(NSDictionary* dictionary in json){
                 if([[dictionary objectForKey:@"trackId"] intValue] != [SELF_APP_APP_ID intValue]){
                     MyAppAd* myAppAd = [[MyAppAd alloc] initWithDictionary:dictionary];
                     [self.apps addObject:myAppAd];
                 }
             }

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
    return [self.apps count];
}

/**
 *  セルの高さを返す（もっとみるの場合は50,記事の場合は100）
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/**
 *  表示するセルの情報を返す
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAppAdCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyAppAdCell"];
    MyAppAd* myAppAd = [self.apps objectAtIndex:indexPath.row];
    
    // 奇数インデックスの場合はcellの背景色を変更する
    UIColor* cellOddColor = [UIColor colorWithRed:0.859 green:0.898 blue:0.949 alpha:1.000];
    if(indexPath.row % 2 == 1){
        cell.backgroundColor = cellOddColor;
    }

    [cell setMyAppAd:myAppAd];
    return cell;
}

/**
 *  セルがクリックされた時の処理
 *  AppStoreをURLスキームを利用して開く
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyAppAd* myAppAd = [self.apps objectAtIndex:indexPath.row];
    [CommonFunction jumpAppStore:myAppAd._id];
}

@end