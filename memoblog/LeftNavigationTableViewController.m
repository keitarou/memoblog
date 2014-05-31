//
//  LeftNavigationTableViewController.m
//  memoblog
//
//  Created by KEITAROU on 2014/01/08.
//  Copyright (c) 2014年 KEITAROU. All rights reserved.
//

#import "LeftNavigationTableViewController.h"

#import "SearchPostTableViewController.h"

@interface LeftNavigationTableViewController ()

@end

@implementation LeftNavigationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor      = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor  = [UIColor colorWithWhite:0.15f alpha:0.2f];

    // 検索バーの設定
    [self.searchBar setDelegate:self];
    [self.searchBar setPlaceholder:@"検索キーワード"];

}

/**
 *  画面遷移
 *
 *  @param segue
 *  @param sender
 */
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
    }
}

/**
 *  セルの数を返す
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"index";
            break;
            
        case 1:
            CellIdentifier = @"page";
            break;
            
        case 2:
            CellIdentifier = @"category";
            break;
            
        case 3:
            CellIdentifier = @"tag";
            break;

        case 4:
            CellIdentifier = @"archive";
            break;

        case 5:
            CellIdentifier = @"dialog";
            break;

        case 6:
            CellIdentifier = @"myapp";
            break;
}
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

/**
 *  検索バーのReturn押下時のイベント
 *
 *  @param searchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];

    SearchPostTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchPostTableViewController"];
    controller.searchWord = searchBar.text;
    
    SWRevealViewController *revealController = self.revealViewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [revealController setFrontViewController:navigationController animated:YES];

}


@end
