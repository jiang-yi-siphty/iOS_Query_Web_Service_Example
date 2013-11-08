//
//  ESFunctions.m
//  ExpertSystem
//
//  Created by Jingxi & Yi on 8/11/2013.
//  Copyright (c) 2013 Yi JIANG. All rights reserved.
//

#import "ESEngine.h"
#import "ESGlobal.h"

@implementation ESEngine
ESGlobal *esGlobalObj;
- (id)init{
    self = [super init];
    esGlobalObj=[ESGlobal getInstance];
    return self;
}

- (NSError *)requestScenarios
{
    NSError *error = nil;
    /*******************************************
     *Send Senarios Request
     *******************************************/
    //Create Request
    NSString *scenariosURL = [NSString stringWithFormat:@"%@%@",esGlobalObj.webServiceUrl, esGlobalObj.scenariosEndpoint];
	NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:scenariosURL]];
    NSLog(@"Web Service: Scenarios List URL : %@", scenariosURL);
	[urlRequest setHTTPMethod:@"GET"];
	[urlRequest addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //Send HTTP Get request
	NSURLResponse *response = nil;
	NSData * jsonResData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (error)  {
        //Need error handling code here!!! <-------------------<< Unfinished
        
    } else {
        NSLog(@"Retrieving Scenarios List successful.");
    }
    
    /*******************************************
     *Process JSON Response
     *******************************************/
    NSString *jsonResStr = [[NSString alloc] initWithData:jsonResData
                                                 encoding:NSUTF8StringEncoding];
	NSLog(@"Response string: %@", jsonResStr);
    if (jsonResData!=nil) {
        NSDictionary *jsonResObj = [NSJSONSerialization JSONObjectWithData:jsonResData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];
        
        esGlobalObj.scenariosArray = [jsonResObj objectForKey:@"scenarios"];
        if (error)  {
            //Need error handling code here!!! <-------------------<< Unfinished
            
        } else {
            NSLog(@"Parsing JSON successful.");
        }
    }
    
    return error;
}

- (NSError *)requestCase:(NSString *)caseId
{
    NSError *error = nil;
    /*******************************************
     *Send Senarios Request
     *******************************************/
    //Create Request
    NSString *caseURL = [NSString stringWithFormat:@"%@%@%@",esGlobalObj.webServiceUrl, esGlobalObj.casesEndpoint,caseId];
	NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:caseURL]];
    NSLog(@"Web Service: Case URL : %@", caseURL);
	[urlRequest setHTTPMethod:@"GET"];
	[urlRequest addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //Send HTTP Get request
	NSURLResponse *response = nil;
	NSData * jsonResData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (error)  {
        //Need error handling code here!!! <-------------------<< Unfinished
        
    } else {
        NSLog(@"Retrieving Case successful.");
    }
    
    /*******************************************
     *Process JSON Response
     *******************************************/
    NSString *jsonResStr = [[NSString alloc] initWithData:jsonResData
                                                 encoding:NSUTF8StringEncoding];
	NSLog(@"Response string: %@", jsonResStr);
    if (jsonResData!=nil) {
        NSDictionary *jsonResObj = [NSJSONSerialization JSONObjectWithData:jsonResData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];
        
        esGlobalObj.caseDictionary = [jsonResObj objectForKey:@"case"];
        if (error)  {
            //Need error handling code here!!! <-------------------<< Unfinished
            
        } else {
            NSLog(@"Parsing JSON successful.");
        }
    }
    
    return error;
}

@end
