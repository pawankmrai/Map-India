//
//  MIScrollView.m
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIScrollView.h"

@implementation MIScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        barButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [barButton setTitle:@"Bar" forState:UIControlStateNormal];
//        [self addSubview:barButton];        
    }
    return self;
}
-(void)layoutSubviews{

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //NSLog(@"%s", __FUNCTION__);
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
