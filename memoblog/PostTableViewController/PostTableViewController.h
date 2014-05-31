//
//  PostsTableViewController.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/09.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Cate.h"
#import "Tag.h"
#import "Archive.h"
#import "Post.h"
#import "StaticPage.h"
#import "PostCell.h"
#import "MoreCell.h"

@interface PostTableViewController : UITableViewController

//==================================================================//
// property
//==================================================================//
@property NSMutableArray* posts;
@property int page;
@property BOOL isPageMax;
@property MoreCell* moreCell;

//==================================================================//
// methods
//==================================================================//
- (void) initTableView;
- (void) initMenuBtn;
- (void) getPostsRequest;
- (NSDictionary*) getRequestParamWithPageStr:(NSString*) pageStr andPageCount:(NSString*) pageCountStr;
- (NSString*) getTitle;


@end
