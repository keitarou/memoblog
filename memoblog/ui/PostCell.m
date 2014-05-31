//
//  PostCell.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "PostCell.h"

#import "UIImageView+WebCache.h"

@implementation PostCell

- (void) setPost:(Post*) post
{
    self.backgroundColor              = [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.000];
    self.borderView.layer.borderColor = [UIColor blackColor].CGColor;
    self.borderView.layer.borderWidth = 1.0f;

    self.titleLabel.text   = post.title;
    self.excerptLabel.text = post.excerpt;
    self.dateLabel.text    = post.date;

    // TODO: ImageViewを指定した場所にうまく配置できなかったのでコードで生成しているのでなんとかしたい
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(210.0, 84.0, 88.0, 88.0)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [imageView setImageWithURL:post.image_url placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    [self.contentView addSubview:imageView];
}

@end
