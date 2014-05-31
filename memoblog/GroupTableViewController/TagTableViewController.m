//
//  TagTableViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "TagTableViewController.h"

#import "TagPostTableViewController.h"
#import "Tag.h"

@interface TagTableViewController ()

@end

@implementation TagTableViewController

- (NSString *) getTitle
{
    return @"タグ";
}

- (void)generateGroupsByJson:(id)json
{
    for (NSDictionary* group in [json valueForKey:@"tags"]){
        [self.groups addObject:[[Group alloc] initWithJsonDictionary:group]];
    }
    self.groups = [Group sortObjects:self.groups];
}

- (NSDictionary *)getRequestParam
{
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
            @"get_tag_index", @"json",
            nil
            ];
}

/**
 *  セルがクリックされた時の処理
 *  タグの記事一覧を表示する
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Tag* tag = [self.groups objectAtIndex:indexPath.row];
    
    TagPostTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TagPostTableViewController"];
    controller.backGestureEnabled = YES;
    controller.tag = tag;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
