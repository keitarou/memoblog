//
//  MyAppAdCell.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/12.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "MyAppAdCell.h"

@implementation MyAppAdCell

- (void) setMyAppAd:(MyAppAd*) myAppAd
{
    _titleLabel.text       = myAppAd.title;
    _descriptionLabel.text = myAppAd.description;
    
    // TODO: ImageViewを指定した場所にうまく配置できなかったのでコードで生成しているのでなんとかしたい
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 60.0, 60.0)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [imageView setImageWithURL:myAppAd.imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    [self.contentView addSubview:imageView];
}


@end
