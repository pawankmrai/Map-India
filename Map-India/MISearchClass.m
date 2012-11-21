//
//  MISearchClass.m
//  Map-India
//
//  Created by Avneesh minocha on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MISearchClass.h"

@implementation MISearchClass
@synthesize address=_address;
@synthesize coordinate=_coordinate;


-(NSString *)title{

    if ([_address isKindOfClass:[NSNull class]]){
    
        return @"Unknow Change";
    }
    return _address;
}

@end
