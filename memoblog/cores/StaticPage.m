//
//  Page.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/10.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "StaticPage.h"

@implementation StaticPage

- (id) initWithJsonDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    
    // 画像はうまく取得できない場合があるようなので
    // 落ちないようにする
    // TODO: あと画像に関して、ブログのサムネイルと違う画像を持ってきているようなので、あとで見直す
    NSDictionary* images;
    @try{
        images = [[dictionary valueForKey:@"attachments"][0] valueForKey:@"images"];
    }
    @catch (NSException* e) {
        
    }
    
    self._id       = [[dictionary valueForKey:@"id"] intValue];
    self.title     = [dictionary valueForKey:@"title"];
    self.url       = [NSURL URLWithString:[dictionary valueForKey:@"url"]];
    self.status    = [dictionary valueForKey:@"status"];
    self.content   = [dictionary valueForKey:@"content"];
    self.excerpt   = [dictionary valueForKey:@"excerpt"];
    self.date      = [dictionary valueForKey:@"date"];
    self.image_url = [NSURL URLWithString:[[images valueForKey:@"thumb100"] valueForKey:@"url"]];

    return self;
}


@end
