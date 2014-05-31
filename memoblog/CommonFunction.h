//
//  CommonFunction.h
//  pokemonmatome
//
//  Created by KEITAROU on 2013/12/22.
//  Copyright (c) 2013年 KEITAROU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Appirater.h"

@interface CommonFunction : NSObject

// iOS7端末かどうか
+ (BOOL)isIOS7;

// 単純にアラートする
+ (void)showAlertWithTitle :(NSString*)title message:(NSString*)message;

// 効果音を再生する
// AVFoundation.framework が必要
// #import <AVFoundation/AVFoundation.h> が必要
// 何故かならない。。。
+ (void)soundPlayWithResource:(NSString*)resource ofType:(NSString*)ofType;

// appStoreのアプリページへ誘導する
// appidを引数に与える必要がある（itunes connectで確認できる）
+ (void) jumpAppStore:(NSString*)appId;

// レビュー誘導アラートを表示する
// Appriraterライブラリを入れておく必要がある
// CFNetwork framework追加
// SystemConfiguration framework追加
// StoreKit framework追加
+ (void)initApprirater;


// 引数に与えたTwitterIDのユーザーをTwitterクライアントで表示する
// Twitterアプリがインストールされていない場合はSafariでユーザーのページを開く
// 優先度 TweetBot->Twitter->Safari
+ (void) openTwitterByScreenname: (NSString*) screenname;

// 引数に与えたRSSのURLをFeedlyアプリで開く
// Feedlyアプリがインストールされていない場合は警告しておわる
+ (void) openFeedlyByRssUrl: (NSString*) rssUrl;

// 引数に与えたURLスキームが開けるかどうかを返す
+ (BOOL) canOpenAppURL:(NSURL*) appURL;




//==========================================================//
// ios開発じゃなくても使える関数
//==========================================================//
+ (NSArray*) shuffleArray:(NSMutableArray*)array;

// ログを吐き出すマクロ
// 実行メソッドとラインを表示する
#define MYLog(fmt,...) NSLog((@"%s  LINE %d: "fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// オーバーライドしろ、Exceptionを発火
+ (void) RaiseExceptionNotOverrideMethod;

@end
