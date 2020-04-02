//
//  ViewController.h
//  WKWebView HW OBJ-C
//
//  Created by Marentilo on 01.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewController.h"

@interface ViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) WKWebView * webView;

@property (weak, nonatomic) UIBarButtonItem * back;
@property (weak, nonatomic) UIBarButtonItem * forward;
@property (weak, nonatomic) UIBarButtonItem * refresh;
@property (weak, nonatomic) UIBarButtonItem * history;

@end

