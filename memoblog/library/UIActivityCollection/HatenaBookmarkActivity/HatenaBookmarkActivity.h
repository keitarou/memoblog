//
//  HatenaBookmarkActivity.h
//
//  Created by keitarou on 14/01/11.
//  Copyright (c) 2014年 keitarou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HatenaBookmarkActivity : UIActivity

@property (strong, nonatomic) NSURL *backURL;

- (id)initWithBackURL:(NSURL *)backURL;
- (BOOL) canOpenAppURL:(NSURL*) appURL;

@end
