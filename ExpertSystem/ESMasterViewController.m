//
//  ESMasterViewController.m
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import "ESMasterViewController.h"
#import "ESDetailViewController.h"

@interface ESMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation ESMasterViewController
NSOperationQueue *_secondQueue;
MBProgressHUD *HUD;
ESGlobal *esGlobalObj;
ESEngine *engine;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (ESDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //initialing...
    esGlobalObj=[ESGlobal getInstance];
    engine = [[ESEngine alloc] init];
    
    
    //Prepare an new queue for update Scenarios list
    _secondQueue = [[NSOperationQueue alloc] init];
    
    //Configure Pull to Refresh
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    UIColor *skyBlue = [[UIColor alloc]initWithRed:135/255 green:206/255 blue:235/255 alpha:1];
    
    refresh.tintColor = skyBlue;
    NSString *firstRefreshString = @"Pull to Refresh";
    NSMutableAttributedString *firstRefreshAString = [[NSMutableAttributedString alloc] initWithString:firstRefreshString];
    [firstRefreshAString addAttribute:NSForegroundColorAttributeName value:skyBlue range:NSMakeRange(0, [firstRefreshString length])];
    refresh.attributedTitle = firstRefreshAString;
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;

    
}

-(void)viewDidAppear:(BOOL)animated{
    //Retrieve Scenarios List
    [self refreshTableViewController];
    [self.refreshControl addTarget:self
                            action:@selector(refreshInvoked:forState:)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView reloadData];
    [self.tableView setNeedsLayout];
    [self.tableView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -
#pragma mark - Refresh delegate

-(void) refreshInvoked:(id)sender forState:(UIControlState)state {
   
    [_secondQueue addOperationWithBlock:^{
        ESEngine *engine = [[ESEngine alloc] init];
        NSError *error = [engine requestScenarios];
        if (error)  {
            //Need error handling code here!!! <-------------------<< Unfinished
            
        } else {
            NSLog(@"Refresh Scenarios List successful.");
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self.tableView setNeedsLayout];
            [self.tableView setNeedsDisplay];
            [self.refreshControl endRefreshing];
            ////  reset icon badge and bar item badge
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            //[[[[[self tabBarController] tabBar] items] objectAtIndex:0] setBadgeValue:nil];
        }];
    }];
        
    
    
    
}


-(void)refreshView:(UIRefreshControl *)refresh {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM HH:mm:ss"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last update on %@",[formatter stringFromDate:[NSDate date]]];
    UIColor *skyBlue = [[UIColor alloc]initWithRed:135/255 green:206/255 blue:235/255 alpha:1];
    NSMutableAttributedString *LastUpdateAString = [[NSMutableAttributedString alloc] initWithString:lastUpdated];
    [LastUpdateAString addAttribute:NSForegroundColorAttributeName
                              value:skyBlue
                              range:NSMakeRange(0, [lastUpdated length])];
    refresh.attributedTitle = LastUpdateAString;
        

}


-(void)refreshTableViewController{
    HUD.progress = 0.0f;
    [_secondQueue addOperationWithBlock:^{
        ESEngine *engine = [[ESEngine alloc] init];
        NSError *error = [engine requestScenarios];
        if (error)  {
            //Need error handling code here!!! <-------------------<< Unfinished
            
        } else {
            NSLog(@"Refresh Scenarios List successful.");
            NSLog(@"Global Scenarios Array: %@",[esGlobalObj.scenariosArray description]);
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self.tableView setNeedsLayout];
            [self.tableView setNeedsDisplay];
            [self.refreshControl endRefreshing];
            HUD.progress = 1.0f;
        }];
    }];
    
    
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}



#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
    if (tableView.tag == 1) {
        //do something for selected cell
        
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if([segue.identifier isEqualToString:@"showCaseByTapCell"])
    {
//        ESDetailViewController *caseViewController = segue.destinationViewController;
        //Pre-configure Case View varibles
        //Need Code here!
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *caseIdString = [esGlobalObj.scenariosArray[indexPath.row] objectForKey:@"caseId"];
        
        NSLog(@"Case ID: %@",caseIdString);

        [[segue destinationViewController] setCaseId:caseIdString];
        
    }
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return esGlobalObj.scenariosArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScenariosCell" forIndexPath:indexPath];
    cell.textLabel.text = [esGlobalObj.scenariosArray[indexPath.row] objectForKey:@"text"];;
    return cell;
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



- (IBAction)refreshButtonSelected:(id)sender {
    
    ////  Draw HUD progress
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	
    HUD.delegate = self;
    HUD.labelText = @"Updating...";
	HUD.dimBackground = YES;
    HUD.minShowTime = 1;
    [self.navigationController.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(refreshTableViewController)
                   onTarget:self
                 withObject:nil
                   animated:YES];
}
@end
