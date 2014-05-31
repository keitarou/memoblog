//
//  PostCell.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostCell : UITableViewCell

//==================================================================//
// UI property
//==================================================================//
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerptLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

//==================================================================//
// UI events
//==================================================================//

//==================================================================//
// property
//==================================================================//

//==================================================================//
// methods
//==================================================================//
- (void) setPost:(Post*) post;

//==================================================================//
// timee task methods
//==================================================================//

@end
