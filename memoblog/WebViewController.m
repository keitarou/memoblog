//
//  WebViewController.m
//  pokemonmatome
//
//  Created by KEITAROU on 2013/12/06.
//  Copyright (c) 2013年 KEITAROU. All rights reserved.
//

#import "WebViewController.h"

// UIActivityをカスタムするためのライブラリ達
#import "ARChromeActivity.h"
#import "TUSafariActivity.h"
#import "ReadabilityActivity.h"
#import "ZYInstapaperActivity.h"
#import "DFPocketActivityLite.h"
#import "HatenaBookmarkActivity.h"
#import "SleipnirActivity.h"

@interface WebViewController ()
@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if(![CommonFunction isIOS7]){
        self.backGestureEnabled = YES;
    }

    // windowのサイズ取得
    CGSize winSize = self.view.frame.size;
    
    // navigation bar のタイトル変更
    [self setTitle:self.post.title];

    
    // 右上にシェア用ボタンを表示
    UIBarButtonItem *rightBtn = [
                            [UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                 target:self
                                 action:@selector(rightBtnClick)
     ];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    // webviewでページを表示する
    // ツールバーの高さ分をWebViewの大きさを引いている
    // TODO: delegateの指定で警告でてまっせ
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0.f, 0.f, winSize.width, winSize.height)];
    [self.webview setDelegate:self];
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSMutableURLRequest requestWithURL:self.post.url]];
    
    
}

/**
 *  右のButtonをクリックした時の処理
 */
-(void) rightBtnClick
{

    NSArray* activityItems = [NSArray arrayWithObjects:
                              self.post.title,
                              self.post.url,
                              nil];
//    NSArray* activityItems = [NSArray arrayWithObjects:
//                                [NSString stringWithFormat:@"Google"],
//                                [NSURL URLWithString:@"http://google.com"],
//                                nil
//                              ];
    
    
    // 追加のアクティビティ
    TUSafariActivity* safariActivity               = [[TUSafariActivity alloc] init];
    SleipnirActivity* sleipnirActivity             = [[SleipnirActivity alloc] init];
    HatenaBookmarkActivity* hatenaBookmarkActivity = [[HatenaBookmarkActivity alloc] initWithBackURL:[NSURL URLWithString:@"memoblog://"]];
    DFPocketActivityLite* pocketActivity           = [[DFPocketActivityLite alloc] init];
    ReadabilityActivity* readabilityActivity       = [[ReadabilityActivity alloc] init];
    ZYInstapaperActivity* instapaperActivity       = [[ZYInstapaperActivity alloc] init];
    ARChromeActivity* chromeActivity               = [[ARChromeActivity alloc] init];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc]
                                               initWithActivityItems:activityItems
                                               applicationActivities:@[
                                                                       safariActivity,
                                                                       sleipnirActivity,
                                                                       hatenaBookmarkActivity,
                                                                       pocketActivity,
                                                                       readabilityActivity,
                                                                       instapaperActivity,
                                                                       chromeActivity,
                                                                       ]
                                              ];
    
    [self presentViewController:activityView animated:YES completion:^{
        
    }];
    
}

/**
 *  ページ読み込み時にインジケータを表示
 *
 *  @param webView
 */
-(void)webViewDidStartLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


/**
 *  ページ読み込み時にインジケータを非表示にする
 *
 *  @param webView
 */
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
