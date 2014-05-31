//
//  MyAppAdTableViewController.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/12.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyAppAdCell.h"

@interface MyAppAdTableViewController : UITableViewController

//==================================================================//
// property
//==================================================================//
@property NSMutableArray* apps;

//==================================================================//
// methods
//==================================================================//
- (void) refleshTableView;

@end
