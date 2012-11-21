//
//  MIAnnotationDetailViewController.h
//  Map-India
//
//  Created by Avneesh minocha on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>
#define kGOOGLE_API_KEY @"AIzaSyDa9tkUwbFqU6q15t-W0q50kFSdzURvrF0"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MIAnnotationDetailViewController : UITableViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>



@end
