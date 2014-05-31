//
//  SearchPostTableViewController.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "SearchPostTableViewController.h"

@interface SearchPostTableViewController ()

@end

@implementation SearchPostTableViewController

- (NSString*) getTitle
{
    return self.searchWord;
}

/**
 *  jsonのリクエストに使うパラメータを返す
 *
 *  @return
 */
- (NSDictionary*) getRequestParamWithPageStr:(NSString*) pageStr andPageCount:(NSString*) pageCountStr
{
    NSLog(@"%@", self.searchWord);
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
                @"get_search_results", @"json",
                self.searchWord,       @"search",
                pageCountStr,          @"count",
                pageStr,               @"page",
                nil
            ];
}

@end
