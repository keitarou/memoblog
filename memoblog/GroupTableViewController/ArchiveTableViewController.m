//
//  ArchiveTableViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/10.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "ArchiveTableViewController.h"

#import "ArchivePostTableViewController.h"
#import "Archive.h"

@interface ArchiveTableViewController ()

@end

@implementation ArchiveTableViewController

- (NSString *) getTitle
{
    return @"アーカイブ";
}

/**
 *  トグルボタン非表示
 */
- (void) initOrderToggleBtn
{
    return;
}

- (void)generateGroupsByJson:(id)json
{
     // archives配列にarchiveインスタンスを埋め込んでいく
     // treeの中はこんな感じ    "tree":{"2014":{"01":"4"},"2013":{"12":"34","11":"30","10":"24","09":"27","08":"54","07":"33","06":"12","05":"12","04":"4"}}}
     NSDictionary* tree = [json valueForKey:@"tree"];
     // 年をキーにしている配列をぶん回し
     for (NSString* year in [tree keyEnumerator]){
         NSDictionary* monthes = [tree valueForKey:year];
         // 月をキーにしている配列をぶん回し
         for (NSString* month in [monthes keyEnumerator]){
             int postCount = [[monthes valueForKey:month] intValue];
             
             Group* archive = [[Archive alloc] initWithYear:year month:month postCount:postCount];
             [self.groups addObject:archive];
         }
     }
     self.groups = [Archive sortArchives:self.groups];
}

- (NSDictionary *)getRequestParam
{
    return [
            NSDictionary dictionaryWithObjectsAndKeys:
            @"get_date_index", @"json",
            nil
            ];
}

/**
 *  セルがクリックされた時の処理
 *  アーカイブ一覧を表示する
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Archive* archive = [self.groups objectAtIndex:indexPath.row];
    
    ArchivePostTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ArchivePostTableViewController"];
    controller.archive = archive;
    [self.navigationController pushViewController:controller animated:YES];
}

@end