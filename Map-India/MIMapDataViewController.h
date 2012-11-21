//
//  MIMapDataViewController.h
//  Map-India
//
//  Created by Avneesh minocha on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIMapDataViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *filteredDataArray;
@property (strong, nonatomic) IBOutlet UISearchBar *dataSearchBar;
@property (strong, nonatomic) NSMutableArray *sectionArray;

@end
