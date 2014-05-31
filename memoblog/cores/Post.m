
//
//  Post.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "Post.h"

#import "Cate.h"

@implementation Post

/**
 *  jsonからPostクラスを生成
 *
 *  @param dictionary
 *
 *  @return
 */
+ (Post*) initWithJsonDictionary:(NSDictionary*) dictionary
{
    Post* post = [[Post alloc]init];
    
    // 画像はうまく取得できない場合があるようなので
    // 落ちないようにする
    // TODO: あと画像に関して、ブログのサムネイルと違う画像を持ってきているようなので、あとで見直す
    NSDictionary* images;
    @try{
        images = [[dictionary valueForKey:@"attachments"][0] valueForKey:@"images"];
    }
    @catch (NSException* e) {
        
    }
    
    post._id       = [[dictionary valueForKey:@"id"] intValue];
    post.title     = [dictionary valueForKey:@"title"];
    post.url       = [NSURL URLWithString:[dictionary valueForKey:@"url"]];
    post.status    = [dictionary valueForKey:@"status"];
    post.content   = [dictionary valueForKey:@"content"];
    post.excerpt   = [dictionary valueForKey:@"excerpt"];
    post.date      = [dictionary valueForKey:@"date"];
    post.image_url = [NSURL URLWithString:[[images valueForKey:@"thumb100"] valueForKey:@"url"]];

    return post;
}

@end
