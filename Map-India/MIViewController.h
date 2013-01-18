//
//  MIViewController.h
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MIScrollView.h"

#define kGOOGLE_API_KEY @"AIzaSyBYFfuwSFS_9XP5KD9tK9Z2H8evbaTJTO8"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface MIViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate,UISearchBarDelegate,UITextFieldDelegate>
{

    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentCentre;
    int currenDist;
    BOOL firstLaunch;
}
@property (strong, nonatomic) UITextField *toField;
@property (strong, nonatomic) UITextField *fromField;
@property (strong, nonatomic) UIToolbar *dirBar;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet MIScrollView *scrollView;
@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSMutableDictionary *refDictionary;
@end
