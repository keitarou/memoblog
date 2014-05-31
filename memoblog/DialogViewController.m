//
//  DialogViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/09.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "DialogViewController.h"

#import "AAMFeedbackViewController.h"

@interface DialogViewController ()

@end

@implementation DialogViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // セクションのグループ化
    // これをやらんとちゃんと表示されない
    self.root = [[QRootElement alloc] init];
    self.root.grouped = YES;
    self.root.title = @"その他";
    
    
    // メニューを開くボタンの作成と、メニューを開くジェスチャーの設定
    // TODO: ジェスチャーがうまくいっていない。。
    UIBarButtonItem* sidebarButton = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
    [sidebarButton setTarget: self.revealViewController];
    [sidebarButton setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];

    

    // ===============================================================
    // ソーシャルアカウント・フィード登録への誘導
    // ===============================================================
    QSection* sectionSocial = [[QSection alloc]initWithTitle:@"アカウントフォロー"];
    [self.root addSection:sectionSocial];
    
    // Twitter
    QButtonElement *twitterButton = [[QButtonElement alloc] initWithTitle:@"Twitterでフォローする"];
    twitterButton.onSelected = ^{
        [CommonFunction openTwitterByScreenname:TWITTER_SCREENNAME];
    };
    
    // Feedlyで購読
    QButtonElement *feedlyButton = [[QButtonElement alloc] initWithTitle:@"Feedlyで購読する"];
    feedlyButton.onSelected = ^{
        [CommonFunction openFeedlyByRssUrl:RSS_FEED_URL];
    };
    

    // RSSコピー
    QButtonElement *feedUrlCopyButton = [[QButtonElement alloc] initWithTitle:@"RSS Feedをコピー"];
    feedUrlCopyButton.onSelected = ^{
        UIPasteboard *pastebd = [UIPasteboard generalPasteboard];
        [pastebd setValue:RSS_FEED_URL forPasteboardType: @"public.utf8-plain-text"];
        NSString* title = @"コピー完了";
        NSString* message = @"クリップボードにRSSのアドレスをコピーしました。";
        [CommonFunction showAlertWithTitle:title message:message];
    };
    
    [sectionSocial addElement:twitterButton];
    [sectionSocial addElement:feedlyButton];
    [sectionSocial addElement:feedUrlCopyButton];
    
    
    // ===============================================================
    // 問い合わせ・レビューのボタンを設置する
    // ===============================================================
    QSection* sectionExt = [[QSection alloc]initWithTitle:@"その他"];
    [self.root addSection:sectionExt];
    
    // 問い合わせボタン
    QButtonElement *helpButton = [[QButtonElement alloc] initWithTitle:@"お問い合わせ"];
    helpButton.onSelected = ^{
        AAMFeedbackViewController* feedbackViewController = [[AAMFeedbackViewController alloc]init];
        NSArray* toMailAddresses = [NSArray arrayWithObjects:DEVELOPER_MAIL_ADDRESS, nil];
        [feedbackViewController setToRecipients:toMailAddresses];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
        [self presentModalViewController:navigation animated:YES];
    };
    
    // レビューボタン
    QButtonElement *reviewButton = [[QButtonElement alloc] initWithTitle:@"レビューを書く"];
    reviewButton.onSelected = ^{
        [CommonFunction jumpAppStore:SELF_APP_APP_ID];
    };
    
    [sectionExt addElement:helpButton];
    [sectionExt addElement:reviewButton];
    
}


@end