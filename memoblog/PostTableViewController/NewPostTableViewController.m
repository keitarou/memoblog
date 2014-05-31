//
//  NewPostTableViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "NewPostTableViewController.h"

@interface NewPostTableViewController ()

@end

@implementation NewPostTableViewController

- (NSString*) getTitle
{
    return @"新着記事";
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
                @"get_recent_posts", @"json",
                pageCountStr,        @"count",
                pageStr,             @"page",
                nil
            ];
}

@end
