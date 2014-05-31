//
//  HatenaBookmarkActivity.m
//
//  Created by keitarou on 14/01/11.
//  Copyright (c) 2014年 keitarou. All rights reserved.
//

#import "HatenaBookmarkActivity.h"

#define URL_SCHEME_HATENA_BOOKMARK    @"hatenabookmark:/entry?url=%@&backurl=%@&backtitle=%@"

@implementation HatenaBookmarkActivity

- (id) initWithBackURL:(NSURL*)backURL
{
    self = [super init];

    self.backURL = backURL;
    
    return self;
}

- (NSString *) activityType
{
    return @"net.absolute-keitarou.HatenaBookmarkActivity";
}

- (UIImage *) activityImage
{
    return [UIImage imageNamed:@"HatenaBookmarkActivity.bundle/uiactivity-bookmark-icon"];
}

- (NSString *) activityTitle
{
    return @"hatena bookmark";
}

- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            NSURL *appURL = [NSURL URLWithString:
                                [NSString stringWithFormat:URL_SCHEME_HATENA_BOOKMARK,
                                 nil,
                                 nil,
                                 nil
                                 ]
                             ];
            return [self canOpenAppURL:appURL];
        }
    }
    return NO;
}

- (void) prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            NSString *url     = [activityItem absoluteString];
            NSString *backurl = [self.backURL absoluteString];

            url = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)url,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?",
                                                                                        kCFStringEncodingUTF8 );
            backurl = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)backurl,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?",
                                                                                        kCFStringEncodingUTF8 );
            
            NSString* backtitle = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

            NSURL *appURL = [NSURL URLWithString:
                                [NSString stringWithFormat:URL_SCHEME_HATENA_BOOKMARK,
                                    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                    [backurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                    [backtitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                 ]
                            ];

            if ([self canOpenAppURL:appURL])
            {
                [[UIApplication sharedApplication] openURL:appURL];
            }

            break;
        }
    }
}

- (BOOL) canOpenAppURL:(NSURL*) appURL
{
    return ([[UIApplication sharedApplication] canOpenURL:appURL]);
}

@end
