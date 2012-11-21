//
//  MIGetLocationViewController.h
//  Map-India
//
//  Created by Avneesh minocha on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define kGOOGLE_API_KEY @"AIzaSyDa9tkUwbFqU6q15t-W0q50kFSdzURvrF0"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@class MIAppDelegate;
@interface MIGetLocationViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>
{
    MIAppDelegate *miDelegate;
}

//@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property(strong, nonatomic) NSMutableArray *locationArray;
@property(strong, nonatomic) IBOutlet UISearchBar *locationSearchBar;
@property(strong, nonatomic) NSMutableArray *filteredArray;

@end
