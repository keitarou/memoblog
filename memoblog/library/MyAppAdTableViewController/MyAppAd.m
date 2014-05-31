//
//  MyAppAd.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/12.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "MyAppAd.h"

@implementation MyAppAd

- (id) initWithDictionary:(NSDictionary*) dictionary;
{
    self = [super init];
    
    __id         = [dictionary valueForKey:@"trackId"];
    _title       = [dictionary valueForKey:@"trackName"];
    _description = [dictionary valueForKey:@"description"];
    _imageURL    = [NSURL URLWithString:[dictionary valueForKey:@"artworkUrl100"]];
    
    return self;
}

@end
