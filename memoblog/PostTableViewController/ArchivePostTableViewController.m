//
//  ArchivePostViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "ArchivePostTableViewController.h"

@interface ArchivePostTableViewController ()

@end

@implementation ArchivePostTableViewController

- (void) initMenuBtn
{
    return;
}

- (NSString*) getTitle
{
    return self.archive.title;
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
                @"get_date_posts",          @"json",
                [self.archive requestDate], @"date",
                pageCountStr,               @"count",
                pageStr,                    @"page",
                nil
            ];
}

@end
