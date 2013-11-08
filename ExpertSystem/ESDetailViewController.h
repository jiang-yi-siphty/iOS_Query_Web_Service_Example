//
//  ESDetailViewController.h
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESGlobal.h"
#import "ESEngine.h"


@interface ESDetailViewController : UIViewController <UISplitViewControllerDelegate>{
    
    NSString *caseId;
    NSDictionary *caseDictionary;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) NSString *caseId;
@property (strong, nonatomic) NSDictionary *caseDictionary;

@property (weak, nonatomic) IBOutlet UITextView *caseTextView;
@property (weak, nonatomic) IBOutlet UIImageView *caseImageView;
@property (weak, nonatomic) IBOutlet UIButton *case1stButton;
@property (weak, nonatomic) IBOutlet UIButton *case2ndButton;
@property (weak, nonatomic) IBOutlet UIButton *caseFinalButton;

- (IBAction)button1TouchUpInside:(id)sender;
- (IBAction)button2TouchUpInside:(id)sender;
- (IBAction)scenariosButtonSelected:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
