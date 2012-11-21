//
//  MIMapPoint.h
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MIMapPoint : NSObject<MKAnnotation>
{

    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *gbID;

-(id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D )coordinate;

@end
