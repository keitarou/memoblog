//
//  StaticPagePostTableViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "StaticPagePostTableViewController.h"

@interface StaticPagePostTableViewController ()

@end

@implementation StaticPagePostTableViewController

- (NSString*) getTitle
{
    return @"固定記事";
}

/**
 *  jsonのリクエストに使うパラメータを返す
 *
 *  @return
 */
- (NSDictionary*) getRequestParamWithPageStr:(NSString*) pageStr andPageCount:(NSString*) pageCountStr
{
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
                @"get_page_index", @"json",
                nil
            ];
}

/**
 *  記事取得のリクエスト
 *  固定ページの場合はjsonの添字が変わったり、ページが設定できないのでオーバーライド
 */
- (void)getPostsRequest
{
    // 最大ページまで読み込んでいる場合は何も処理しない
    if(self.isPageMax) return;
    
    // １回処理したら最大ページフラグをつける
    self.isPageMax = YES;
    self.moreCell.hidden = YES;
    
    // ユーザー操作無効でローディング表示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString* url = [NSString stringWithFormat:@"%@", BASE_URL];
    NSDictionary* params = [self getRequestParamWithPageStr:nil andPageCount:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id json) {
             // posts配列にpostインスタンスを埋め込んでいく
             for (NSDictionary* post in [json valueForKey:@"pages"]){
                 [self.posts addObject:[Post initWithJsonDictionary:post]];
             }
             self.posts = [[self.posts reverseObjectEnumerator] allObjects];
             
             [self.tableView reloadData];
             [SVProgressHUD dismiss];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD dismiss];
         }
     ];
}

@end