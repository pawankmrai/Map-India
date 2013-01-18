//
//  MIAnnotationDetailViewController.m
//  Map-India
//
//  Created by Avneesh minocha on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIAnnotationDetailViewController.h"
#import "MIAnnotationClass.h"
#import "MIAppDelegate.h"


@interface MIAnnotationDetailViewController ()
@property(weak,nonatomic) NSString *referance;
@property(strong,nonatomic) NSMutableArray *detailArray;
@end

@implementation MIAnnotationDetailViewController
@synthesize referance=_referance;
@synthesize detailArray=_detailArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *urlString=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=true&key=%@",delegate.refKeyGB,kGOOGLE_API_KEY1];
    NSURL *refURL=[NSURL URLWithString:urlString];
    //NSLog(@"url---%@",refURL);
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: refURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}
-(void)fetchedData:(NSData *)responseData{

    NSError *error;
    
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData 
                          
                          options:kNilOptions 
                          error:&error];
    NSDictionary *detail=[json objectForKey:@"result"];
    [self placeData:detail];
    NSLog(@"detail---%@",detail);

}
-(void)placeData:(NSDictionary *)data{

    _detailArray =[[NSMutableArray alloc] init];
    MIAnnotationClass *objAnn=[MIAnnotationClass new];
    NSString *name=[data objectForKey:@"name"];
    if (name!=nil) {
        objAnn.name=name;
    }
    else {
        objAnn.name=@"Unknown Name";
    }
    NSString *address=[data objectForKey:@"formatted_address"];
    if (address!=nil) {
        objAnn.address=address;
    }
    else {
        objAnn.address=@"Unknown Address";
    }
    NSString *phone_no=[data objectForKey:@"formatted_phone_number"];
    if (phone_no!=nil) {
        objAnn.phone_no=phone_no;
    }
    else {
        objAnn.phone_no=@"Unknown Number";
    }
    NSString *website=[data objectForKey:@"website"];
    if (website!=nil) {
        objAnn.website=website;
    }
    else {
        objAnn.phone_no=@"Unknown Website";
    }

    [_detailArray addObject:objAnn];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    else {
        return 4;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return @"Detail Information";
    }
    if (section==1) {
        return @"Contact Information";
    }
    else {
        return @"Social";
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    float cellHeight;
    if ([indexPath section]==0) {
        
        cellHeight=100.0f;
    }
    else {
        cellHeight=44.0f;
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    MIAnnotationClass *obj=nil;
    // Configure the cell..
    if ([indexPath section]==0) {
        
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
        cell.textLabel.text=obj.name;
        cell.detailTextLabel.lineBreakMode=UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines=2;
        cell.detailTextLabel.text=obj.address;
    }
    else if ([indexPath section]==1) {
        obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
        cell.textLabel.text=obj.phone_no;
        cell.imageView.image=[UIImage imageNamed:@"phone.png"];
    }  
    else if ([indexPath section]==2) {
        obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
        if (indexPath.row==0) {
            cell.textLabel.text=@"Tweet";
            cell.imageView.image=[UIImage imageNamed:@"tweet.png"];
        }
        else if (indexPath.row==1) {
            cell.textLabel.text=obj.website;
            cell.imageView.image=[UIImage imageNamed:@"website.png"];
            cell.selectionStyle=UITableViewCellEditingStyleNone;
        }
        else if (indexPath.row==2) {
            cell.textLabel.text=@"Send Via Email";
            cell.imageView.image=[UIImage imageNamed:@"email.png"];
            
        }
        else if (indexPath.row==3) {
            cell.textLabel.text=@"Send Via SMS";
            cell.imageView.image=[UIImage imageNamed:@"sms.png"];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==1) {
        MIAnnotationClass *obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
        NSLog(@"tel:%@",obj.phone_no);
       // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",obj.phone_no]]];
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",obj.phone_no]]];
        } else {
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [Notpermitted show];
        }
    }
    else if ([indexPath section]==2) {
          
           if (indexPath.row==1) {
              MIAnnotationClass *obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
              NSLog(@"website---%@",obj.website);
              if (obj.website!=nil) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.website]]];
             }
             else {
                [[[UIAlertView alloc] initWithTitle:@"Message" message:@"Link is Not Valid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        }
    else if (indexPath.row==2) {
               if ([MFMailComposeViewController canSendMail])
               {
                   MIAnnotationClass *obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
                   MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                   mailer.mailComposeDelegate = self;
                   [mailer setSubject:@"Hello"];
                   NSArray *toRecipients = [NSArray arrayWithObjects:@"ghz.rai@gmail.com", @"secondMail@example.com", nil];
                   [mailer setToRecipients:toRecipients];
//                   UIImage *myImage = [UIImage imageNamed:@"Airport2.png"];
//                   NSData *imageData = UIImagePNGRepresentation(myImage);
//                   [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"image"];
                   
                   NSMutableString *emailBody=[NSMutableString stringWithFormat:@"Hello \n i am at%@",obj.name];
                   [emailBody appendFormat:@"\n%@",obj.address];
                   [mailer setMessageBody:emailBody isHTML:NO];
                   [self presentModalViewController:mailer animated:YES];
               }
               else
               {
             [[[UIAlertView alloc] initWithTitle:@"Failure"
                                  message:@"Your device doesn't support the composer sheet"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];                  
               }
               
           }
    else if (indexPath.row==3) {
        
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {   MIAnnotationClass *obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
            NSMutableString *smsBody=[NSMutableString stringWithFormat:@"Hello \n i am at%@",obj.name];
            [smsBody appendFormat:@"\n%@",obj.address];
            controller.body = smsBody;    
            controller.recipients = [NSArray arrayWithObjects:@"+91-8802971411", nil];
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
            }   
         }
     else if (indexPath.row==0) {
    
         if ([TWTweetComposeViewController canSendTweet])
         {   
             MIAnnotationClass *obj=(MIAnnotationClass *)[_detailArray objectAtIndex:0];
             NSMutableString *tweetBody=[NSMutableString stringWithFormat:@"Hello \n i am at%@",obj.name];
             [tweetBody appendFormat:@"\n%@",obj.address];
             TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
             [tweetSheet setInitialText:tweetBody];
             [self presentModalViewController:tweetSheet animated:YES];
         }
         else
         {
            [[[UIAlertView alloc] initWithTitle:@"Sorry"                                                             
                                  message:@"You can't send a tweet right now, make sure                                        your device has an internet connection and you have                                       at least one Twitter account setup"                                                          
                                  delegate:self                                              
                                  cancelButtonTitle:@"OK"                                                   
                                  otherButtonTitles:nil] show];       
         }
      }
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
        else if (result == MessageComposeResultSent)
            NSLog(@"Message sent") ; 
            else 
            NSLog(@"Message failed") ; 
 }

@end
