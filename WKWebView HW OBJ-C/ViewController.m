//
//  ViewController.m
//  WKWebView HW OBJ-C
//
//  Created by Marentilo on 01.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray * pdfs;
@property (strong, nonatomic) NSArray * sites;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void) setupView {
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"id"];
    self.navigationItem.searchController = [[UISearchController alloc] init];
    self.navigationItem.searchController.searchBar.delegate = self;
    self.navigationItem.searchController.searchBar.placeholder = @"Google it";
    self.navigationItem.title = @"Safari (Demo)";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self createArrays];
}

- (void) createArrays {
    _pdfs = [NSArray arrayWithObjects: @"AppleDesign",
                                       @"ObjectiveC",
                                       @"SwiftCheatsheet",
                                       @"UIPresentationController",
                                       @"GCD",
                                       @"GCD_Swift4_1",
                                       @"GCD_Swift4_2",
                                       @"OperationQueue",
                                       nil];
    
    _sites = [NSArray arrayWithObjects: @"https://www.flaticon.com",
                                        @"https://www.facebook.com",
                                        @"https://www.apple.com",
                                        @"https://www.youtube.com",
                                        @"https://www.google.com",
                                        @"https://www.twitch.tv",
                                        @"https://www.instagram.com",
                                        @"https://www.forbes.com",
                                        @"https://www.aliexpress.com",
                                        nil];
}


- (void) pushWebView: (NSString*) url {
    WebViewController * controller = [[WebViewController alloc] initWithURL: url];
    [self.navigationController pushViewController:controller animated:true];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? _pdfs.count : _sites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    cell.imageView.image = indexPath.section == 0 ? [UIImage imageNamed:@"pdf"] : [UIImage imageNamed:@"www"];
    cell.textLabel.text = indexPath.section == 0 ? [_pdfs objectAtIndex:indexPath.row] : [_sites objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString * url = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    [self pushWebView:url];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString * searchResult = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString * defaultUrl = [NSString stringWithFormat:@"https://www.google.com/search?q=%@", searchResult];
    [self pushWebView: defaultUrl];
}


@end
