//
//  GroupTableViewController.h
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableViewController : UITableViewController

//==================================================================//
// UI property
//==================================================================//
@property BOOL isReverse;
@property NSString* title;

//==================================================================//
// UI events
//==================================================================//

//==================================================================//
// property
//==================================================================//
@property NSMutableArray* groups;

//==================================================================//
// methods
//==================================================================//
- (void) initTableView;
- (void) initMenuBtn;
- (void) initOrderToggleBtn;

- (void) getGroupsRequest;
- (void) orderToggle;
- (NSString*) getTitle;
- (NSDictionary*) getRequestParam;
- (void) generateGroupsByJson:(id)json;

//==================================================================//
// timee task methods
//==================================================================//

@end
