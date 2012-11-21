//
//  MIDataClass.h
//  Map-India
//
//  Created by Avneesh minocha on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIDataClass : NSObject<NSCoding>
{

    NSString *category;
    NSString *name;
}
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)dataOfCategory:(NSString*)category name:(NSString*)name;

@end
