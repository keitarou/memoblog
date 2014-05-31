//
//  CategoryAndTagCell.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell

- (void) setGroup:(Group*) group
{
    self.titleLabel.text = group.title;
    self.badgeView.text  = [NSString stringWithFormat:@"%d", group.post_count];
    self.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
}

@end
