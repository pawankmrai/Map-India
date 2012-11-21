//
//  MISearchViewController.h
//  Map-India
//
//  Created by Avneesh minocha on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define kGOOGLE_API_KEY @"AIzaSyDa9tkUwbFqU6q15t-W0q50kFSdzURvrF0"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface MISearchViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{

}
@property (strong, nonatomic) NSMutableArray *infoArray;
@end
