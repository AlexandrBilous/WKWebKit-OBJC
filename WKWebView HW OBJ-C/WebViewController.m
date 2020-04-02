//
//  WebViewController.m
//  WKWebView HW OBJ-C
//
//  Created by Marentilo on 01.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (instancetype)initWithURL:(NSString *)url {
    self = [super init];
    if (self) {
        self.searchUrl = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setupView {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.title = [self titleForNavigation];
    UIBarButtonItem * refresh = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refreshButtonPressed:)];
    _refresh = refresh;
    self.navigationItem.rightBarButtonItem = refresh;
    
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    indicator.color = UIColor.blueColor;
    [indicator setHidesWhenStopped:NO];
    [indicator startAnimating];
    _indicator = indicator;
    
    [self.view addSubview:indicator];
    indicator.translatesAutoresizingMaskIntoConstraints = false;
    
    
    WKWebView * webView = [[WKWebView alloc] init];
    webView.navigationDelegate = self;
    _webView = webView;
    
    webView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:webView];
    [self loadContent];
    [self setupToolbar];
    
    [self setupConstrains];
}

- (void) setupToolbar {
    UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 80)];
    
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    UIBarButtonItem * forward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonPressed:)];
    
    _back = back;
    _forward = forward;
    
    [toolbar setItems:@[back, forward]];
    
    
    [self.view addSubview: toolbar];
    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [[toolbar.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor] setActive:YES];
    [[toolbar.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor] setActive:YES];
    [[toolbar.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor] setActive:YES];
    
}

- (NSString*) titleForNavigation {
    
    NSRange start = [_searchUrl rangeOfString:@"www"];
    NSRange range = NSMakeRange(start.location + start.length + 1, _searchUrl.length - start.location - start.length - 1);    
    NSString * result = [_searchUrl hasPrefix:@"http"] ? [[_searchUrl substringWithRange:range] capitalizedString] : _searchUrl;
    
    return result;
}

- (void) loadContent {
    NSURL * url = [_searchUrl hasPrefix:@"http"] ? [NSURL URLWithString: _searchUrl] : [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:_searchUrl ofType:@"pdf"]];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void) setupConstrains {
    NSArray * constrains = [NSArray arrayWithObjects:
                            [_webView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                            [_webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                            [_webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                            [_webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                            
                            [_indicator.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                            [_indicator.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                            nil];
    [NSLayoutConstraint activateConstraints: constrains];
}

- (void) refreshButtons {
    _back.enabled = [_webView canGoBack];
    _forward.enabled = [_webView canGoForward];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    [_indicator startAnimating];
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self refreshButtons];
    [_indicator stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self refreshButtons];
    [_indicator stopAnimating];
}

#pragma mark - Actions

- (void) backButtonPressed: (UIBarButtonItem*) sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (void) forwardButtonPressed: (UIBarButtonItem*) sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (void) refreshButtonPressed: (UIBarButtonItem*) sender {
    [_webView reload];
}
    

@end
