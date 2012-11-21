//
//  MIHomeViewController.m
//  Map-India
//
//  Created by Avneesh minocha on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIHomeViewController.h"
#import "MIDataClass.h"
#import "MIGetLocationViewController.h"
#import "MIAppDelegate.h"

@interface MIHomeViewController (){

    MIGetLocationViewController *getLocation;

}
@property(nonatomic,strong) NSMutableArray *defaultArray;
@end

@implementation MIHomeViewController
@synthesize defaultArray;
@synthesize locationManager,geoCoder;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    miDelegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Get user location
    [locationManager startUpdatingLocation];
    [self performSelector:@selector(calculateAddress) withObject:nil afterDelay:2.0];
    //[self calculateAddress];
    
}
-(void)calculateAddress
{
    NSLog(@"came after 2 sec");
    //Geocoding Block
    [self.geoCoder reverseGeocodeLocation: locationManager.location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         
         NSLog(@"latitude==%f",locationManager.location.coordinate.latitude);
         double latt=locationManager.location.coordinate.latitude;
         double longt=locationManager.location.coordinate.longitude;
         //Get nearby address
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         //String to hold address
         miDelegate.locationTitle = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         //string to hold postal code....
         NSString *postalStr=placemark.postalCode;
         NSLog(@"here postalcode==%@",postalStr);
         //Print the location to console
         
         //NSLog(@"I am currently at %@",locatedAt);
         
         NSString *isoCountryCode=placemark.ISOcountryCode;
         NSLog(@"countrycode==%@",isoCountryCode);
         
         //setting location in globalvariables....
         miDelegate.globalLattitude = [NSString stringWithFormat:@"%f", latt];
         miDelegate.globalLongitude=[NSString stringWithFormat:@"%f",longt];
         NSLog(@"latitude==%@ and the longitude=%@",miDelegate.globalLattitude,miDelegate.globalLongitude);
         //reloading the data....
         [self.tableView reloadData];
         //Set the label text to current location
         //[locationLabel setText:locatedAt];
         
         //here setting the user location credentials to nsuser defaults so that
         //when it is needed in application can be retrived easily............
         
         //         NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
         //
         //         // saving an NSString
         //         [prefs setObject:locatedAt forKey:@"currentLocationOfuser"];
         //         [prefs setDouble:latt forKey:@"currentLattitude"];
         //         [prefs setDouble:longt forKey:@"currentLongitude"];
         //         [prefs synchronize];
         /*
          // saving an NSInteger
          [prefs setInteger:42 forKey:@"integerKey"];
          
          // saving a Double
          [prefs setDouble:3.1415 forKey:@"doubleKey"];
          
          // saving a Float
          [prefs setFloat:1.2345678 forKey:@"floatKey"];
          
          // This is suggested to synch prefs, but is not needed (I didn't put it in my tut)
          [prefs synchronize];
          */
         
         
     }];//closing the whole block.......
    //return nil;

    
}
-(void)viewWillAppear:(BOOL)animated{

    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *data=[userDefault objectForKey:@"selected"];
    defaultArray=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"array---%@",defaultArray);
    [self.tableView reloadData];

}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [self setGeoCoder:nil];
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
        return 0;
    }
   else if (section==1) {
        return 3;
    }
    else {
        if ([defaultArray count]>0) {
            return [defaultArray count];
        }
        else {
            return 1;
        }
        
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (section==0) {
        if (delegate.locationTitle!=nil) {
           
            return delegate.locationTitle;
            
        }
        else {
            
            return @"No Location";
        }
        
    }
   else if (section==1) {
        return @"All";
    }
    else {
        return @"Favorite Category";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([indexPath section]==0) {
        
    }
   else if ([indexPath section]==1) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"All Categories";
        }
        else if (indexPath.row==1) {
            cell.textLabel.text=@"History";
        }
        else if (indexPath.row==2) {
            cell.textLabel.text=@"Favorites";
        }
    }
    else if([indexPath section]==2) {
        if ([defaultArray count]>0) {
            MIDataClass *data=(MIDataClass *)[defaultArray objectAtIndex:indexPath.row];
            cell.textLabel.text=data.name;
        }
        else {
            cell.textLabel.text=@"No Value";
        }
        
    }
    

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self performSegueWithIdentifier:@"categoryView" sender:tableView]; 
    }
   else {
         NSLog(@"i am out of services");
   }
}

@end
