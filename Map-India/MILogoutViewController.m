//
//  MILogoutViewController.m
//  Map-India
//
//  Created by Sandeep Nasa on 1/22/13.
//
//

#import "MILogoutViewController.h"
#import <Parse/Parse.h>

@interface MILogoutViewController ()

@end

@implementation MILogoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
