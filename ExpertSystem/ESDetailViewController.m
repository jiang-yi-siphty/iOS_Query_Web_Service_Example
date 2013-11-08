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
@synthesize caseFinalButton;
@synthesize caseImageView;
@synthesize caseTextView;
ESGlobal *esGlobalObj;
ESEngine *engine;
NSOperationQueue *_secondQueue;

#pragma mark - Managing the Case 

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
            if ([esGlobalObj.caseDictionary objectForKey:@"answers"]) {
                case1stButton.hidden = NO;
                case2ndButton.hidden = NO;
                caseFinalButton.hidden = YES;
                NSString *buttonText;
                buttonText = [[esGlobalObj.caseDictionary objectForKey:@"answers"][0] objectForKey:@"text"];
                [case1stButton setTitle:buttonText forState:UIControlStateNormal];
                case1stButton.tag = [[[esGlobalObj.caseDictionary objectForKey:@"answers"][0] objectForKey:@"caseId"] integerValue];
                
                buttonText = [[esGlobalObj.caseDictionary objectForKey:@"answers"][1] objectForKey:@"text"];
                [case2ndButton setTitle:buttonText forState:UIControlStateNormal];
                case2ndButton.tag = [[[esGlobalObj.caseDictionary objectForKey:@"answers"][1] objectForKey:@"caseId"] integerValue];
            } else {
                case1stButton.hidden = YES;
                case2ndButton.hidden = YES;
                caseFinalButton.hidden = NO;
            }
            caseTextView.text = [NSString stringWithFormat:@"\n\n\n%@",[esGlobalObj.caseDictionary objectForKey:@"text"]];
            
                [_secondQueue addOperationWithBlock:^{
                    UIImage *image;
                    @try {
                        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[esGlobalObj.caseDictionary objectForKey:@"image"]]]];
                    }
                    @catch (NSException *exception) {
                        image = [UIImage imageNamed: @"images.jpeg"];
                    }
                    @finally {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        caseImageView.image = image;
                    }];
                        
                    }
                }];
            [self reloadInputViews];

        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.navigationItem.hidesBackButton = YES;
    //initialing...
    esGlobalObj=[ESGlobal getInstance];
    engine = [[ESEngine alloc] init];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1TouchUpInside:(id)sender {
    NSLog(@"Button 1 Tag: %d", case1stButton.tag);
    [self performSegueWithIdentifier: @"button1" sender: self];
}

- (IBAction)button2TouchUpInside:(id)sender {
    NSLog(@"Button 2 Tag: %d", case2ndButton.tag);
    [self performSegueWithIdentifier: @"button2" sender: self];
}

- (IBAction)scenariosButtonSelected:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"button1"])
    {
        NSString *caseIdString = [NSString  stringWithFormat:@"%d",case1stButton.tag];
        
        NSLog(@"Case ID: %@",caseIdString);
        
        [[segue destinationViewController] setCaseId:caseIdString];
    }else if ([[segue identifier] isEqualToString:@"button2"])
    {
        NSString *caseIdString = [NSString  stringWithFormat:@"%d",case2ndButton.tag];
        
        NSLog(@"Case ID: %@",caseIdString);
        
        [[segue destinationViewController] setCaseId:caseIdString];
    }
}
@end
