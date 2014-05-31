//
//  DFPocketActivityLite.m
//  DFPocketActivityLiteDemo
//
//  Created by Toshihiro Morimoto on 13/03/27.
//  Copyright (c) 2013年 Toshihiro Morimoto. All rights reserved.
//

#import "DFPocketActivityLite.h"

#define URL_SCHEME_POCKET    @"pocket://"
#define APP_STORE_URL_POCKET @"https://itunes.apple.com/jp/app/pocket-formerly-read-it-later/id309601447?l=en&mt=8"

@implementation DFPocketActivityLite

- (NSString *)activityType {
    return @"net.dealforest.DFPocketActivityLite";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"DFPocketActivityLite.bundle/icon_pocket"];
}

- (NSString *)activityTitle
{
    return @"Save to Pocket";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
            return YES;
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            if (![self isAvailablePocket]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_URL_POCKET]];
                return;
            }
            
            NSString *url    = [(NSURL *)activityItem absoluteString];
            UIPasteboard *pb = [UIPasteboard generalPasteboard];
            [pb setString:url];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_SCHEME_POCKET]];

            break;
        }
    }
}

#pragma mark - private

- (BOOL)isAvailablePocket
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URL_SCHEME_POCKET]];
}

@end
