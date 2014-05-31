//
//  MoreCell.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/09.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "MoreCell.h"

@implementation MoreCell

- (void) setBorder
{
    self.backgroundColor              = [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.000];
    self.borderView.layer.borderColor = [UIColor blackColor].CGColor;
    self.borderView.layer.borderWidth = 1.0f;
}

@end
