//
//  ESGlobal.m
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import "ESGlobal.h"

@implementation ESGlobal
@synthesize webServiceUrl;
@synthesize scenariosEndpoint;
@synthesize casesEndpoint;
@synthesize scenariosArray;
@synthesize caseDictionary;


static ESGlobal *instance = nil;


#pragma mark - Singleton Design Pattern
+(ESGlobal *)getInstance
{
    if(instance ==nil)
    {
        instance = [ESGlobal new];
        // Get initial value from Preferences and Settings.
        // Use <<Preferences and Settings>> http://developer.apple.com/library/ios/#documentation/cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i-CH1-SW1
        
    }
    return instance;
}

@end
