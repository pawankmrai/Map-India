//
//  MISettingViewController.m
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MISettingViewController.h"
#import "PAWActivityView.h"
#import <Parse/Parse.h>

@interface MISettingViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;


@end

@implementation MISettingViewController

@synthesize userField,passwordField,loginButton;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:userField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:passwordField];
    
	loginButton.enabled = NO;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    //[userField becomeFirstResponder];

}
- (IBAction)signIN:(id)sender {
    
    [userField resignFirstResponder];
	[passwordField resignFirstResponder];
    
	[self processFieldEntries];
}
#pragma mark - UITextField text field change notifications and helper methods

- (BOOL)shouldEnableDoneButton {
	BOOL enableDoneButton = NO;
	if (userField.text != nil &&
		userField.text.length > 0 &&
		passwordField.text != nil &&
		passwordField.text.length > 0) {
		enableDoneButton = YES;
	}
	return enableDoneButton;
}

- (void)textInputChanged:(NSNotification *)note {
	loginButton.enabled = [self shouldEnableDoneButton];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == userField) {
		[passwordField becomeFirstResponder];
	}
	if (textField == passwordField) {
		[passwordField resignFirstResponder];
		[self processFieldEntries];
	}
    
	return YES;
}
#pragma mark - Private methods:

#pragma mark Field validation

- (void)processFieldEntries {
    
    
	// Get the username text, store it in the app delegate for now
	NSString *username = userField.text;
	NSString *password = passwordField.text;
	NSString *noUsernameText = @"username";
	NSString *noPasswordText = @"password";
	NSString *errorText = @"No ";
	NSString *errorTextJoin = @" or ";
	NSString *errorTextEnding = @" entered";
	BOOL textError = NO;
    
	// Messaging nil will return 0, so these checks implicitly check for nil text.
	if (username.length == 0 || password.length == 0) {
		textError = YES;
        
		// Set up the keyboard for the first field missing input:
		if (password.length == 0) {
			[passwordField becomeFirstResponder];
		}
		if (username.length == 0) {
			[userField becomeFirstResponder];
		}
	}
    
	if (username.length == 0) {
		textError = YES;
		errorText = [errorText stringByAppendingString:noUsernameText];
	}
    
	if (password.length == 0) {
		textError = YES;
		if (username.length == 0) {
			errorText = [errorText stringByAppendingString:errorTextJoin];
		}
		errorText = [errorText stringByAppendingString:noPasswordText];
	}
    
	if (textError) {
		errorText = [errorText stringByAppendingString:errorTextEnding];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
	}
    
	// Everything looks good; try to log in.
	// Disable the done button for now.
	loginButton.enabled = NO;
    
	PAWActivityView *activityView = [[PAWActivityView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel *label = activityView.label;
	label.text = @"Logging in";
	label.font = [UIFont boldSystemFontOfSize:20.f];
	[activityView.activityIndicator startAnimating];
	[activityView layoutSubviews];
    
	[self.view addSubview:activityView];
    
    NSLog(@"email varified detail----%@",[[PFUser currentUser] objectForKey:@"emailVerified"]);
    
    
        
       
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            // Tear down the activity view in all cases.
            [activityView.activityIndicator stopAnimating];
            [activityView removeFromSuperview];
            
            if (user) {
                if ([[user objectForKey:@"emailVerified"] boolValue]==1) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Waring" message:@"Please verify email first" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [userField becomeFirstResponder];
                }
                
            } else {
                // Didn't get a user.
                NSLog(@"%s didn't get a user!", __PRETTY_FUNCTION__);
                
                // Re-enable the done button if we're tossing them back into the form.
                loginButton.enabled = [self shouldEnableDoneButton];
                UIAlertView *alertView = nil;
                
                if (error == nil) {
                    // the username or password is probably wrong.
                    alertView = [[UIAlertView alloc] initWithTitle:@"Couldn’t log in:\nThe username or password were wrong." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                } else {
                    // Something else went horribly wrong:
                    alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                }
                [alertView show];
                // Bring the keyboard back up, because they'll probably need to change something.
                [userField becomeFirstResponder];
            }
        }];        
    
    
	}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:userField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordField];
    [self setUserField:nil];
    [self setPasswordField:nil];
    [self setLoginButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
