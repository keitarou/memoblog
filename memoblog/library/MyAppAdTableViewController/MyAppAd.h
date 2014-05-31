//
//  MyAppAd.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/12.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAppAd : NSObject

//==================================================================//
// property
//==================================================================//
@property NSString* _id;
@property NSString* title;
@property NSString* description;
@property NSURL* imageURL;


//==================================================================//
// methods
//==================================================================//
- (id) initWithDictionary:(NSDictionary*) dictionary;


@end
