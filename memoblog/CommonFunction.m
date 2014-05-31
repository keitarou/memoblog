//
//  CommonFunction.m
//  pokemonmatome
//
//  Created by KEITAROU on 2013/12/22.
//  Copyright (c) 2013年 KEITAROU. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

/**
 *  実行中の環境がiOS7かどうかを判定する
 *
 *  @return
 */
+ (BOOL)isIOS7
{
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    return (iOsVersionMajor == 7);
}

/**
 *  単純にアラートする
 *
 *  @param title   タイトル
 *  @param message メッセージ
 */
+ (void)showAlertWithTitle :(NSString*)title message:(NSString*)message
{
    UIAlertView* alert = [
                          [UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles: @"OK", nil
                          ];
    [alert show];

}

/**
 *  appStoreのアプリページへ誘導する
 *  appidを引数に与える必要がある（itunes connectで確認できる）
 *
 *  @param appId
 */
+ (void) jumpAppStore:(NSString*)appId
{
    NSURL *reivewURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId]];
    NSLog(@"%@", reivewURL);
    [[UIApplication sharedApplication] openURL:reivewURL];
}

/**
 *  レビュー誘導アラートを表示する
 *  Appriraterライブラリを入れておく必要がある
 */
+ (void)initApprirater
{
    // レビューライブラリの設定
    // ja.lproj内のファイルを編集することで表示するメッセージを変えることができる（日本語のみ）
    [Appirater setAppId: SELF_APP_APP_ID];
    [Appirater appLaunched:YES];
    
    // インストール後、再びメッセージを表示するまでの日数。(デフォルト:30日)
    [Appirater setDaysUntilPrompt: 14];
    
    // 再びメッセージを表示するまでの起動回数。(デフォルト:20回)
    [Appirater setUsesUntilPrompt: 10];
    
    // ユーザーがアプリ内で何か特別な操作をしたときに意図的にメッセージを表示するか否か。(デフォルト:-1)
    // 値 : -1=無効, 1=有効
    // 表示する場合は、任意の箇所に [Appirater userDidSignificantEvent:YES] を呼ぶ。
    [Appirater setSignificantEventsUntilPrompt: -1];
    
    // 「後で見る」を選択したときにメッセージを再び表示するまでの日数。(デフォルト:1日)
    [Appirater setTimeBeforeReminding: 1];
    
    // デバッグモードの有無。YESにすると起動の度に表示される。(デフォルト:NO)
    [Appirater setDebug: NO];
}


/**
 *  効果音を再生する
 *
 *  @param resource
 *  @param ofType
 */
+ (void)soundPlayWithResource:(NSString*)resource ofType:(NSString*)ofType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:ofType];
    NSURL* url = [NSURL fileURLWithPath:path];
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.volume = 0.5f;
    [player play];
}

/**
 * 引数に与えたTwitterIDのユーザーをTwitterクライアントで表示する
 * Twitterアプリがインストールされていない場合はSafariでユーザーのページを開く
 * 優先度 TweetBot->Twitter->Safari
 *
 *  @param userId
 */
+ (void) openTwitterByScreenname: (NSString*) screenname
{
    // TODO: Tweetbot うまくいかない。アプリは開けるけど、フォローページにいけない
    NSURL *appURLTweetBot = [NSURL URLWithString:
                            [NSString stringWithFormat:@"tweetbot://%@/follow/%@", screenname, screenname]
                            ];
    NSURL *appURLTwitter = [NSURL URLWithString:
                            [NSString stringWithFormat:@"twitter://user?screen_name=%@", screenname]
                            ];
    NSURL *appURLSafari = [NSURL URLWithString:
                            [NSString stringWithFormat:@"https://twitter.com/%@", screenname]
                            ];
    
//    if ([self canOpenAppURL:appURLTweetBot])
    // Tweetbotで上手く動かないのでfalseにしている
    if (false)
        {
        [[UIApplication sharedApplication] openURL:appURLTweetBot];
        return;
    }
    if ([self canOpenAppURL:appURLTwitter])
    {
        [[UIApplication sharedApplication] openURL:appURLTwitter];
        return;
    }
    if ([self canOpenAppURL:appURLSafari])
    {
        [[UIApplication sharedApplication] openURL:appURLSafari];
        return;
    }
}

/**
 *
 * 引数に与えたRSSのURLをFeedlyアプリで開く
 * Feedlyアプリがインストールされていない場合は警告しておわる
 * SafariでRSSフィードを開くこと自動的にFeedlyが起動するのでそれを利用する
 *
 *  @param rssUrl
 */
+ (void) openFeedlyByRssUrl: (NSString*) rssUrl
{
    // Feedlyがインストールされているかをチェック
    NSURL *appURLFeedly = [NSURL URLWithString:
                            [NSString stringWithFormat:@"feedly://"]
                            ];
    if ([self canOpenAppURL:appURLFeedly])
    {
        // RSSのURLをSafariで起動する。
        // これによってFeedlyが自動的に立ち上がる
        NSURL *appURLSafari = [NSURL URLWithString: RSS_FEED_URL];
        [[UIApplication sharedApplication] openURL:appURLSafari];
        return;
    }
    else
    {
        NSString* title = @"アプリの起動に失敗しました。";
        NSString* message = @"Feedlyのアプリをインストールしておく必要があります。";
        [CommonFunction showAlertWithTitle:title message:message];
    }
    
}


/**
 *  渡されたURLスキームが有効かを返す
 *
 *  @param appURL
 *
 *  @return
 */
+ (BOOL) canOpenAppURL:(NSURL*) appURL
{
    return ([[UIApplication sharedApplication] canOpenURL:appURL]);
}

/**
 *  配列をシャッフルする
 *
 *  @param array
 *
 *  @return
 */
+ (NSArray*) shuffleArray:(NSMutableArray*)array
{
    for (uint i = 0; i < [array count]; ++i) {
        int m = [array count] - i;
        int n = arc4random_uniform(m) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return array;
}

/**
 * オーバーライドしろや、Exception発火
 */
+ (void) RaiseExceptionNotOverrideMethod
{
    [NSException raise:@"not override method" format:@"not override method"];
}
@end
