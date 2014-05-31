//
//  CommonConfig.m
//
//  Created by KEITAROU on 2013/12/05.
//  Copyright (c) 2013年 KEITAROU. All rights reserved.
//

#import "CommonConfig.h"

@implementation CommonConfig

NSString* const DEVELOPER_MAIL_ADDRESS = @"keitarou.oonishi@gmail.com";

NSString* const SELF_APP_APP_ID = @"820370584";

NSString* const BASE_URL = @"http://www.absolute-keitarou.net/blog";
int const REQUEST_PAGE_COUNT = 20;



NSString* const MY_APP_AD_URL = @"http://api-my-app-ad.herokuapp.com/ios.json";

NSString* const TWITTER_SCREENNAME = @"Dollhyn_kei";

NSString* const RSS_FEED_URL = @"http://www.absolute-keitarou.net/blog/?feed=rss2";

+(UIColor*) BASE_BAR_COLOR
{
    // ColorChooserというMacのアプリを使うと簡単に色コードを作れて便利
    return [UIColor colorWithRed:0.384 green:0.663 blue:0.863 alpha:1.000];
}


@end
