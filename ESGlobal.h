//
//  ESGlobal.h
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESGlobal : NSObject{
    
    NSString *webServiceUrl;
    NSString *scenariosEndpoint;
    NSString *casesEndpoint;
    
    NSArray *scenariosArray;
    NSDictionary *caseDictionary;
}


@property (nonatomic,retain)NSString *webServiceUrl;
@property (nonatomic,retain)NSString *scenariosEndpoint;
@property (nonatomic,retain)NSString *casesEndpoint;
@property (atomic, retain)NSArray *scenariosArray;
@property (atomic, retain)NSDictionary *caseDictionary;

+(ESGlobal *)getInstance;
@end
