//
//  MyAppAdCell.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/12.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyAppAd.h"
#import "UIImageView+WebCache.h"

@interface MyAppAdCell : UITableViewCell

//==================================================================//
// UI property
//==================================================================//
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

//==================================================================//
// methods
//==================================================================//
- (void) setMyAppAd:(MyAppAd*) myAppAd;

@end
