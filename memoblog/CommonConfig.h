//
//  CommonConfig.h
//
//  Created by KEITAROU on 2013/12/05.
//  Copyright (c) 2013年 KEITAROU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonConfig : NSObject

// Developer
extern NSString* const DEVELOPER_MAIL_ADDRESS;

// APP ID(iTunes Connectで確認できる)
extern NSString* const SELF_APP_APP_ID;

// APIリクエスト関係
extern NSString* const BASE_URL;
extern int const REQUEST_PAGE_COUNT;
extern int const PAGE_MAX;

// MyAppAdのリクエストURL
extern NSString* const MY_APP_AD_URL;

// TwitterID
extern NSString* const TWITTER_SCREENNAME;

// RSSFEED URL
extern NSString* const RSS_FEED_URL;

// Parseに関する設定文字列
extern NSString* const PARSE_APPLICATION_ID;
extern NSString* const PARSE_CLIENT_KEY;


// 色に関する設定を返すクラス変数
// Objective-cでは特定の型でないと定数として扱えないよう??
// TODO: あとでググっておくほうが良さそう
+(UIColor*) BASE_BAR_COLOR;

@end
