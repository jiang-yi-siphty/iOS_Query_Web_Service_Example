//
//  ESEngine.h
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSJSONSerialization.h>

@interface ESEngine: NSObject

- (NSError *)requestScenarios;
- (NSError *)requestCase:(NSString *)caseId;

@end
