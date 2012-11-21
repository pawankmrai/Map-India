//
//  MIHomeViewController.h
//  Map-India
//
//  Created by Avneesh minocha on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class MIAppDelegate;
@interface MIHomeViewController : UITableViewController<CLLocationManagerDelegate>
{
    MIAppDelegate *miDelegate;
    //NSString *myCurrentLocation;
}

@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet CLGeocoder *geoCoder;
@end
