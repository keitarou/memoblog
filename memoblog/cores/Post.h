//
//  Post.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

// カテゴリー・タグに関してはhas_manyでつながる
// TODO: アクセッサつけろよ
//@property NSArray* categories;
//@property NSArray* tags;

// 記事に関する情報
// 結構面倒なのでできるだけNSStringでやってる
@property(nonatomic) int _id;
@property(nonatomic, strong) NSURL* url;
@property(nonatomic, strong) NSString* status;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* content;
@property(nonatomic, strong) NSString* excerpt;
@property(nonatomic, strong) NSString* date;
@property(nonatomic, strong) NSURL* image_url;


// リクエストから帰ってきたjsonファイルからPostクラスを返すための関数
// TODO: あとでリファクタリング
+ (Post*) initWithJsonDictionary:(NSDictionary*) dictionary;


@end
