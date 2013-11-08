//
//  ESMasterViewController.h
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ESGlobal.h"
#import "ESEngine.h"
#import "MBProgressHUD.h"

@class ESDetailViewController;

@interface ESMasterViewController : UITableViewController<UITableViewDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) ESDetailViewController *detailViewController;
- (IBAction)refreshButtonSelected:(id)sender;

@end
