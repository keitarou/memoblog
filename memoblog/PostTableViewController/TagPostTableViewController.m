//
//  TagPostViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "TagPostTableViewController.h"

@interface TagPostTableViewController ()

@end

@implementation TagPostTableViewController

- (void) initMenuBtn
{
    return;
}

- (NSString*) getTitle
{
    return self.tag.title;
}

/**
 *  jsonのリクエストに使うパラメータを返す
 *
 *  @return
 */
- (NSDictionary*) getRequestParamWithPageStr:(NSString*) pageStr andPageCount:(NSString*) pageCountStr
{
    NSString* idStr = [NSString stringWithFormat:@"%d", self.tag._id];
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
                @"get_tag_posts", @"json",
                idStr,            @"id",
                pageCountStr,     @"count",
                pageStr,          @"page",
                nil
            ];
}

@end
