//
//  MIDataClass.m
//  Map-India
//
//  Created by Avneesh minocha on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIDataClass.h"

@implementation MIDataClass
@synthesize category;
@synthesize name;

+ (id)dataOfCategory:(NSString *)category name:(NSString *)name
{
    MIDataClass *newData = [[self alloc] init];
    newData.category = category;
    newData.name = name;
    return newData;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:name forKey:@"value1"];
    [aCoder encodeObject:category forKey:@"value2"];

}
-(id)initWithCoder:(NSCoder *)aDecoder{

    self.name=[aDecoder decodeObjectForKey:@"value1"];
    self.category=[aDecoder decodeObjectForKey:@"value2"];
    return self;
}

@end
