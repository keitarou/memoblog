//
//  WebViewController.h
//  pokemonmatome
//
//  Created by KEITAROU on 2013/12/06.
//  Copyright (c) 2013年 KEITAROU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BackGesture.h"
#import "Post.h"

@interface WebViewController : UIViewController
    <UIWebViewDelegate>

//==================================================================//
// UI property
//==================================================================//
@property(nonatomic, strong) UIWebView *webview;

//==================================================================//
// property
//==================================================================//
@property(nonatomic, strong) Post* post;


@end
