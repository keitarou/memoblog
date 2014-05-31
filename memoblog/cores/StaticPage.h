//
//  Page.h
//  memoblog
//
//  Created by KEITAROU on 2014/01/10.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticPage : NSObject

//==================================================================//
// property
//==================================================================//
@property int _id;
@property NSURL* url;
@property NSString* status;
@property NSString* title;
@property NSString* content;
@property NSString* excerpt;
@property NSString* date;
@property NSURL* image_url;

//==================================================================//
// methods
//==================================================================//
// リクエストから帰ってきたjsonファイルからPageクラスを返すための関数
- (id) initWithJsonDictionary:(NSDictionary*) dictionary;




@end
