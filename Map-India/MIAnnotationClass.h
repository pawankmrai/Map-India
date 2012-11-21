//
//  MIAnnotationClass.h
//  Map-India
//
//  Created by Avneesh minocha on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIAnnotationClass : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *phone_no;
@property(strong, nonatomic) NSURL *imageURL;
@property(strong, nonatomic) NSURL *detailURL;
@property(strong, nonatomic) NSString *website;
@end
