//
//  SleipnirActivity.m
//
//  Created by keitarou on 14/01/11.
//  Copyright (c) 2014年 keitarou. All rights reserved.
//

#import "SleipnirActivity.h"

@implementation SleipnirActivity

- (NSString *) activityType
{
    return @"net.absolute-keitarou.SleipnirActivity";
}

- (UIImage *) activityImage
{
    return [UIImage imageNamed:@"SleipnirActivity.bundle/sleipnir"];
}

- (NSString *) activityTitle
{
    return @"Open to Sleipnir";
}

- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            NSURL *appURL_s = [NSURL URLWithString: @"shttp://"];
            NSURL *appURL_b = [NSURL URLWithString: @"bhttp://"];
            
            // open black edition?
            if([self canOpenAppURL:appURL_b])
            {
                return YES;
            }
            else
            {
                return [self canOpenAppURL:appURL_s];
            }
        }
    }
    return NO;
}

- (void) prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            NSString *url = [activityItem absoluteString];
            NSURL *appURL_s = [NSURL URLWithString:
                               [NSString stringWithFormat:@"s%@", url]
                               ];
            NSURL *appURL_b = [NSURL URLWithString:
                               [NSString stringWithFormat:@"b%@", url]
                               ];

            if ([self canOpenAppURL:appURL_b])
            {
                [[UIApplication sharedApplication] openURL:appURL_b];
            }
            else if ([self canOpenAppURL:appURL_s])
            {
                [[UIApplication sharedApplication] openURL:appURL_s];
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
