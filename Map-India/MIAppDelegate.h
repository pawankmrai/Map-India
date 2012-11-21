//
//  MIAppDelegate.h
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *globalLattitude;
    NSString *globalLongitude;
}


@property(strong,nonatomic) NSString *globalLattitude;
@property(strong,nonatomic) NSString *globalLongitude;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *filteredArray;
@property (strong, nonatomic) NSString *refKeyGB;
@property (strong, nonatomic) NSString *rowTitle;
@property (strong, nonatomic) NSString *locationTitle;
@end
