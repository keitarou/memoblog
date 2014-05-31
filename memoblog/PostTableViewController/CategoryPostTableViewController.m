//
//  CategoryPostViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "CategoryPostTableViewController.h"

@interface CategoryPostTableViewController ()

@end

@implementation CategoryPostTableViewController

- (void) initMenuBtn
{
    return;
}

- (NSString*) getTitle
{
    return self.category.title;
}

/**
 *  jsonのリクエストに使うパラメータを返す
 *
 *  @return
 */
- (NSDictionary*) getRequestParamWithPageStr:(NSString*) pageStr andPageCount:(NSString*) pageCountStr
{
    NSString* idStr = [NSString stringWithFormat:@"%d", self.category._id];
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
                @"get_category_posts", @"json",
                idStr,                 @"id",
                pageCountStr,          @"count",
                pageStr,               @"page",
                nil
            ];
}
@end
