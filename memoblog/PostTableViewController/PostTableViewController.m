//
//  PostsTableViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/09.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "PostTableViewController.h"

@interface PostTableViewController ()

@end

@implementation PostTableViewController

- (id) init
{
    self = [super init];
    return self;
}


/**
 *  jsonのリクエストに使うパラメータを返す
 *  ※ 各継承クラスでオーバーライドさせる
 *
 *  @return
 */
- (NSDictionary*) getRequestParamWithPageStr:(NSString*) pageStr andPageCount:(NSString*) pageCountStr
{
    [CommonFunction RaiseExceptionNotOverrideMethod];
    return nil;
}

/**
 *  タイトルを定義する
 *  ※ 各継承クラスでオーバーライドさせる
 *
 *  @return
 */
- (NSString*) getTitle
{
    [CommonFunction RaiseExceptionNotOverrideMethod];
    return nil;
}



/**
 * テーブルビューの初期設定
 */
- (void)initTableView
{
    // タイトルを表示する
    self.title = [self getTitle];
    
    // 利用するセルの登録
    [self.tableView registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellReuseIdentifier:@"PostCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:@"MoreCell"];
    
    // 色の設定
    self.tableView.separatorColor  = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.000];
    
    // 続きをみるのセルを準備しておく
    self.moreCell = [self.tableView dequeueReusableCellWithIdentifier:@"MoreCell"];
    [self.moreCell setBorder];
    
     // リフレッシュアクションを設定
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl setTintColor:[UIColor colorWithRed:0.451 green:0.698 blue:0.878 alpha:1.000]];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.moreCell setHidden:YES];
}
/**
 * 新着記事・検索・固定ページの場合、メニューを開くボタンの作成と、メニューを開くジェスチャーの設定
 * 他の場合はオーバーライドして処理を書き換える
 */
- (void)initMenuBtn
{
    // TODO: ジェスチャーがうまくいっていない。。
    UIBarButtonItem* sidebarButton = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
    [sidebarButton setTarget: self.revealViewController];
    [sidebarButton setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initTableView];
    [self initMenuBtn];
    
    // リフレッシュしてセルを読み込む
    self.posts = [NSMutableArray array];
    [self onRefresh:nil];
    
}


/**
 *  リフレッシュ処理
 *
 *  @param sender
 */
- (void)onRefresh:(id)sender
{
    self.page = 0;
    self.isPageMax = NO;
    [self.posts removeAllObjects];
    [self.tableView reloadData];
    
    // 更新開始
    [self.refreshControl beginRefreshing];
    [self getPostsRequest];
    
    // 更新終了
    [self.refreshControl endRefreshing];
}

/**
 *  記事取得のリクエスト
 */
- (void)getPostsRequest
{
    // 最大ページまで読み込んでいる場合は何も処理しない
    if(self.isPageMax) return;
    
    // ユーザー操作無効でローディング表示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 続きを見るのも隠す。これをしないとロード中にセルが映っていて不細工
    self.moreCell.hidden = YES;
    
    self.page++;
    NSString* pageStr      = [NSString stringWithFormat:@"%d", self.page];
    NSString* pageCountStr = [NSString stringWithFormat:@"%d", REQUEST_PAGE_COUNT];
    
    NSString* url = [NSString stringWithFormat:@"%@", BASE_URL];
    NSDictionary* params = [self getRequestParamWithPageStr:pageStr andPageCount:pageCountStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id json) {
             // posts配列にpostインスタンスを埋め込んでいく
             for (NSDictionary* post in [json valueForKey:@"posts"]){
                 [self.posts addObject:[Post initWithJsonDictionary:post]];
             }
             
             // 最大ページはjsonの"pages"でわかる
             if([[json valueForKey:@"pages"] intValue] <= self.page){
                 self.isPageMax = YES;
             }
             
             [self.tableView reloadData];
             
             [SVProgressHUD dismiss];
             self.moreCell.hidden = NO;
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD dismiss];
             self.moreCell.hidden = NO;
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
    return self.isPageMax? [self.posts count]: [self.posts count]+1;
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
    return indexPath.row == self.posts.count? 80: 210;
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
    UITableViewCell* returnCell;
    
    // 続きのセルを返す
    if(indexPath.row == self.posts.count)
    {
        returnCell = self.moreCell;
    }
    // 記事のセルを返す
    else
    {
        PostCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        [cell setPost:[self.posts objectAtIndex:indexPath.row]];
        returnCell = cell;
    }
    return returnCell;
}

/**
 *  セルがクリックされた時の処理
 *  WEBビューを開く
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 続きをロードする
    if(indexPath.row == self.posts.count)
    {
        [self getPostsRequest];
    }
    // 記事の詳細を開く
    else
    {
        Post* post = [self.posts objectAtIndex:indexPath.row];
        
        WebViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        controller.post = post;
        controller.backGestureEnabled = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

@end
