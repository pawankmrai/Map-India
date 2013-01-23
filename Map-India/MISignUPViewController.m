//
//  MISignUPViewController.m
//  Map-India
//
//  Created by Sandeep Nasa on 1/18/13.
//
//

#import "MISignUPViewController.h"
#import "PAWActivityView.h"
#import <Parse/Parse.h>
@interface MISignUPViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *repasswordField;

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation MISignUPViewController

@synthesize userField,passwordField,repasswordField, emailField, doneButton;

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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:userField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:repasswordField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:emailField];
    
	doneButton.enabled = NO;
}


- (void)viewWillAppear:(BOOL)animated {
	//[userField becomeFirstResponder];
	[super viewWillAppear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == userField) {
		[passwordField becomeFirstResponder];
	}
	if (textField == passwordField) {
		[repasswordField becomeFirstResponder];
	}
	if (textField == repasswordField) {
		[repasswordField resignFirstResponder];
		[self processFieldEntries];
	}
    if (textField == emailField) {
		[emailField resignFirstResponder];
		[self processFieldEntries];
	}
    
	return YES;
}

- (IBAction)signUP:(id)sender {
    
    [userField resignFirstResponder];
	[passwordField resignFirstResponder];
	[repasswordField resignFirstResponder];
    [emailField resignFirstResponder];
	[self processFieldEntries];
    
}

- (void)processFieldEntries {
	// Check that we have a non-zero username and passwords.
	// Compare password and passwordAgain for equality
	// Throw up a dialog that tells them what they did wrong if they did it wrong.
    
	NSString *username = userField.text;
	NSString *password = passwordField.text;
	NSString *passwordAgain = repasswordField.text;
    NSString *email = emailField.text;
	NSString *errorText = @"Please ";
	NSString *usernameBlankText = @"enter a username";
	NSString *passwordBlankText = @"enter a password";
	NSString *joinText = @", and ";
	NSString *passwordMismatchText = @"enter the same password twice";
    
	BOOL textError = NO;
    
	// Messaging nil will return 0, so these checks implicitly check for nil text.
	if (username.length == 0 || password.length == 0 || passwordAgain.length == 0 || email.length == 0) {
		textError = YES;
        
		// Set up the keyboard for the first field missing input:
		if (passwordAgain.length == 0) {
			[repasswordField becomeFirstResponder];
		}
		if (password.length == 0) {
			[passwordField becomeFirstResponder];
		}
		if (username.length == 0) {
			[userField becomeFirstResponder];
		}
        
		if (username.length == 0) {
			errorText = [errorText stringByAppendingString:usernameBlankText];
		}
        
		if (password.length == 0 || passwordAgain.length == 0) {
			if (username.length == 0) { // We need some joining text in the error:
				errorText = [errorText stringByAppendingString:joinText];
			}
			errorText = [errorText stringByAppendingString:passwordBlankText];
		}
		goto showDialog;
	}
	
	// We have non-zero strings.
	// Check for equal password strings.
	if ([password compare:passwordAgain] != NSOrderedSame) {
		textError = YES;
		errorText = [errorText stringByAppendingString:passwordMismatchText];
		[passwordField becomeFirstResponder];
		goto showDialog;
	}
    
showDialog:
	if (textError) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
	}
    
	// Everything looks good; try to log in.
	// Disable the done button for now.
	doneButton.enabled = NO;
	PAWActivityView *activityView = [[PAWActivityView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel *label = activityView.label;
	label.text = @"Signing You Up";
	label.font = [UIFont boldSystemFontOfSize:20.f];
	[activityView.activityIndicator startAnimating];
	[activityView layoutSubviews];
    
	[self.view addSubview:activityView];
    
	// Call into an object somewhere that has code for setting up a user.
	// The app delegate cares about this, but so do a lot of other objects.
	// For now, do this inline.
    
	PFUser *user = [PFUser user];
	user.username = username;
	user.password = password;
    user.email  = email;
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error) {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
			[alertView show];
			doneButton.enabled = [self shouldEnableDoneButton];
			[activityView.activityIndicator stopAnimating];
			[activityView removeFromSuperview];
			// Bring the keyboard back up, because they'll probably need to change something.
			[userField becomeFirstResponder];
			return;
		}
        
		// Success!
		[activityView.activityIndicator stopAnimating];
		[activityView removeFromSuperview];
        
		[self performSegueWithIdentifier:@"signupsuccessfull" sender:user];
		//[self.navigationController popViewControllerAnimated:YES];
	}];
}
#pragma mark - UITextField text field change notifications and helper methods

- (BOOL)shouldEnableDoneButton {
	BOOL enableDoneButton = NO;
	if (userField.text != nil &&
		userField.text.length > 0 &&
		passwordField.text != nil &&
		passwordField.text.length > 0 &&
		passwordField.text != nil &&
		repasswordField.text.length > 0 &&
        emailField.text !=nil &&
        emailField.text.length > 0) {
		enableDoneButton = YES;
	}
	return enableDoneButton;
}

- (void)textInputChanged:(NSNotification *)note {
	doneButton.enabled = [self shouldEnableDoneButton];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:userField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:repasswordField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:emailField];
    // Release any retained subviews of the main view.

    [self setUserField:nil];
    [self setPasswordField:nil];
    [self setRepasswordField:nil];
    [self setEmailField:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
}
@end
