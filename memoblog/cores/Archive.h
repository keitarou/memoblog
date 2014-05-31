//
//  Archive.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/10.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "Group.h"

@interface Archive : Group

//==================================================================//
// property
//==================================================================//

//==================================================================//
// methods
//==================================================================//
- (id) initWithYear:(NSString*) year month:(NSString*) month postCount:(int) postCount;
+ (NSMutableArray*) sortArchives: (NSMutableArray*) archives;
- (NSString*) requestDate;
- (NSDictionary*) requestParam;




@end
