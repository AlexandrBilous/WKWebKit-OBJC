//
//  WebViewController.h
//  WKWebView HW OBJ-C
//
//  Created by Marentilo on 01.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController <WKNavigationDelegate>


@property (weak, nonatomic) WKWebView * webView;
@property (strong, nonatomic) NSString * searchUrl;
@property (strong, nonatomic) UIActivityIndicatorView * indicator;

@property (weak, nonatomic) UIBarButtonItem * back;
@property (weak, nonatomic) UIBarButtonItem * forward;
@property (weak, nonatomic) UIBarButtonItem * refresh;

- (instancetype)initWithURL: (NSString*) url;


@end

NS_ASSUME_NONNULL_END
