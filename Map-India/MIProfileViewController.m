//
//  MIProfileViewController.m
//  Map-India
//
//  Created by Sandeep Nasa on 1/24/13.
//
//

#import "MIProfileViewController.h"
#import <Parse/Parse.h>

@interface MIProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UITextView *userDetail;
@property (strong, nonatomic) NSMutableData *imageData;
@property (strong, nonatomic) IBOutlet UITextField *hometownField;
@property (strong, nonatomic) IBOutlet UITextField *dobField;
@property (strong, nonatomic) IBOutlet UITextField *statusField;
@property (strong, nonatomic) IBOutlet UITextField *currentemployerField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation MIProfileViewController
@synthesize profileImage, userDetail, imageData;


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
    
    ///////get user data from facebook//////
    NSString *requestPath = @"me/?fields=name,location,gender,birthday,relationship_status,work,about";
    /////send request to facebook
    PF_FBRequest *request=[PF_FBRequest requestForGraphPath:requestPath];
    [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error){
        
        NSLog(@"result---%@",result);
        
        if (!error) {
            
            NSDictionary *userData = (NSDictionary *)result; // The result is a dictionary
            
            NSString *facebookId = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *location = userData[@"location"][@"name"];
            //NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            NSDictionary *data=[[userData[@"work"] objectAtIndex:0] objectForKey:@"employer"];
            NSString *work=data[@"name"];
           
            [_nameField setText:name];
            [_hometownField setText:location];
            [_dobField setText:birthday];
            [_statusField setText:relationship];
            [_currentemployerField setText:work];
            
            imageData =[[NSMutableData alloc] init];
            
            // URL should point to https://graph.facebook.com/{facebookId}/picture?type=large&return_ssl_resources=1
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookId]];
            
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                  timeoutInterval:2.0f];
            // Run network request asynchronously
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            [urlConnection start];
        
         }
       }
     ];
}
// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    profileImage.image = [UIImage imageWithData:imageData];
}
- (IBAction)dismissProfileView:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setProfileImage:nil];
    [self setUserDetail:nil];
    [self setHometownField:nil];
    [self setDobField:nil];
    [self setStatusField:nil];
    [self setCurrentemployerField:nil];
    [self setNameField:nil];
    [super viewDidUnload];
}
@end
