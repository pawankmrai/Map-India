//
//  MIMapPoint.m
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMapPoint.h"

@implementation MIMapPoint
@synthesize name=_name;
@synthesize address=_address;
@synthesize coordinate=_coordinate;
@synthesize gbID=_gbID;

-(id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate{

    if (self = [super init]) {
        
        _name=[name copy];
        _address=[address copy];
        _coordinate=coordinate;
    }
    return self;
}

-(NSString *)title{

    if ([_name isKindOfClass:[NSNull class]]) {
        
        return @"Unknown Change";
    }
    else 
        return _name;
}
-(NSString *)subtitle{

    return _address;

}

@end
