//
//  Group.h
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

// カテゴリに関する情報
@property int _id;
@property NSString* title;
@property int post_count;

// Archiveでのみ利用する
@property NSString* year;
@property NSString* month;

- (id) initWithJsonDictionary:(NSDictionary*) dictionary;
+ (NSMutableArray*) sortObjects: (NSMutableArray*) groups;
+ (NSMutableArray*) sortObjects: (NSMutableArray*) groups reverse: (BOOL) reverse;

@end
