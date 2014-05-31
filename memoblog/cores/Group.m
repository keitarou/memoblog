//
//  Group.m
//  memoblog
//
//  Created by keitarou on 2014/05/31.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "Group.h"

@implementation Group

/**
 *  jsonからCateクラスを生成
 *
 *  @param dictionary
 *
 *  @return
 */
- (id) initWithJsonDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    
    self._id        = [[dictionary valueForKey:@"id"] intValue];
    self.title      = [dictionary valueForKey:@"title"];
    self.post_count = [[dictionary valueForKey:@"post_count" ] intValue];
    
    self.year  = nil;
    self.month = nil;
    
    return self;
}

/**
 *  投稿数の降順でソート
 *
 *  @param groups
 *
 *  @return
 */
+ (NSMutableArray*) sortObjects: (NSMutableArray*) groups
{
    NSUInteger groupsCount = [groups count];
    for (int i = 0; i < groupsCount -1; i++) {
        for (int j = 0; j < groupsCount -1; j++) {
            Group* left  = [groups objectAtIndex:j];
            Group* right = [groups objectAtIndex:j+1];
            if(left.post_count < right.post_count)
            {
                Group* tmp = left;
                [groups replaceObjectAtIndex:j   withObject:right];
                [groups replaceObjectAtIndex:j+1 withObject:tmp];
            }
        }
    }
    return groups;
}

/**
 *  逆順にソートする
 *
 *  @param groups
 *  @param reverse
 *
 *  @return
 */
+ (NSMutableArray*) sortObjects: (NSMutableArray*) groups reverse:(BOOL) reverse
{
    groups = [self sortObjects:groups];
    return !reverse? groups: [[groups reverseObjectEnumerator] allObjects];
}

@end
