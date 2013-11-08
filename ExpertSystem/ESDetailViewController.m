//
//  ESDetailViewController.m
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import "ESDetailViewController.h"

@interface ESDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation ESDetailViewController
@synthesize caseId;
@synthesize caseDictionary;
@synthesize case1stButton;
@synthesize case2ndButton;
@synthesize caseImageView;
@synthesize caseTextView;
ESGlobal *esGlobalObj;
ESEngine *engine;
NSOperationQueue *_secondQueue;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.caseId) {
        NSLog(@"Case ID: %@",caseId);
        NSError *error = [engine requestCase:caseId];
        if (error)  {
            //Need error handling code here!!! <-------------------<< Unfinished
            
        } else {
            NSLog(@"Retrieving Case successful.");
            NSLog(@"Global Scenarios Array: %@",[esGlobalObj.caseDictionary description]);
            caseDictionary = esGlobalObj.caseDictionary;
            if ([caseDictionary objectForKey:@"answers"]) {
                NSString *buttonText;
                buttonText = [[caseDictionary objectForKey:@"answers"][0] objectForKey:@"text"];
                [case1stButton setTitle:buttonText forState:UIControlStateNormal];
                case1stButton.tag = [[[caseDictionary objectForKey:@"answers"][0] objectForKey:@"caseId"] integerValue];
                
                buttonText = [[caseDictionary objectForKey:@"answers"][1] objectForKey:@"text"];
                [case2ndButton setTitle:buttonText forState:UIControlStateNormal];
                case2ndButton.tag = [[[caseDictionary objectForKey:@"answers"][1] objectForKey:@"caseId"] integerValue];
                
                caseTextView.text = [NSString stringWithFormat:@"\n\n\n%@",[caseDictionary objectForKey:@"text"]];
                
                [_secondQueue addOperationWithBlock:^{
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[caseDictionary objectForKey:@"image"]]]];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        caseImageView.image = image;
                    }];
                }];
                
                
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    //initialing...
    esGlobalObj=[ESGlobal getInstance];
    engine = [[ESEngine alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
