//
//  Archive.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/10.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "Archive.h"

@implementation Archive


- (id) initWithYear:(NSString*) year month:(NSString*) month postCount:(int) postCount
{
    self = [super init];
    
    self._id        = 0;
    self.year       = year;
    self.month      = month;
    self.title      = [NSString stringWithFormat:@"%@年 %@月", self.year, self.month];
    self.post_count = postCount;
    
    return self;
}

/**
 *  リクエストパラメータのdateオプションの文字列を作成する
 *  yyyy-mm　の形にすればいい
 *
 *  @return
 */
- (NSString*) requestDate
{
    return [NSString stringWithFormat:@"%@-%@", self.year, self.month];
}


- (NSDictionary*) requestParam
{
    return [NSDictionary dictionary];
}

/**
 * Archiveではとトグルソートは利用しないので潰しておく
 */
+ (NSMutableArray*) sortObjects: (NSMutableArray*) groups
{
    return groups;
}

/**
 * Archiveではとトグルソートは利用しないので潰しておく
 */
+ (NSMutableArray*) sortObjects: (NSMutableArray*) groups reverse:(BOOL) reverse
{
    return groups;
}

/**
 *  arhiveオブジェクトが格納されたArchives配列をソートする
 *
 *  @param archives
 *
 *  @return
 */
+ (NSMutableArray*) sortArchives: (NSMutableArray*) archives
{
    NSInteger archivesCount = [archives count];
    for (int i = 0; i < archivesCount -1; i++) {
        for (int j = 0; j < archivesCount -1; j++) {
            Archive* archiveLeft  = (Archive*)[archives objectAtIndex:j];
            Archive* archiveRight = (Archive*)[archives objectAtIndex:j+1];
            if(
               (
                [archiveLeft.year integerValue] < [archiveRight.year intValue]
               )
               ||
               (
                [archiveLeft.year intValue] == [archiveRight.year intValue] &&
                [archiveLeft.month intValue] < [archiveRight.month intValue]
               )
           )
            {
                Archive* archiveTmp = archiveLeft;
                [archives replaceObjectAtIndex:j   withObject:archiveRight];
                [archives replaceObjectAtIndex:j+1 withObject:archiveTmp];
            }
        }
    }
    return archives;
}

@end
