//
//  CategoryTableViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "CategoryTableViewController.h"

#import "Cate.h"
#import "CategoryPostTableViewController.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController


- (NSString *) getTitle
{
    return @"カテゴリー";
}

- (void)generateGroupsByJson:(id)json
{
    for (NSDictionary* group in [json valueForKey:@"categories"]){
        [self.groups addObject:[[Group alloc] initWithJsonDictionary:group]];
    }
    self.groups = [Group sortObjects:self.groups];
}

- (NSDictionary *)getRequestParam
{
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
                            @"get_category_index", @"json",
                            nil
            ];
}

/**
 *  セルがクリックされた時の処理
 *  カテゴリの記事一覧を表示する
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Cate* category = [self.groups objectAtIndex:indexPath.row];
    
    CategoryPostTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryPostTableViewController"];
    controller.category = category;
    controller.backGestureEnabled = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
