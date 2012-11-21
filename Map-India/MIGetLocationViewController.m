//
//  MIGetLocationViewController.m
//  Map-India
//
//  Created by Avneesh minocha on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIGetLocationViewController.h"
#import "MILocationClass.h"
#import "MIAppDelegate.h"


@interface MIGetLocationViewController ()

@end

@implementation MIGetLocationViewController
//@synthesize locationManager;
@synthesize locationSearchBar;
@synthesize locationArray;
@synthesize filteredArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"Current Location: %@",miDelegate.locationTitle ];
    return theLocation;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    locationArray=[[NSMutableArray alloc] init];
    miDelegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
}
//-(void)updateLocation{
//
//    
//    ////get location  
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
//    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
//    [locationManager startUpdatingLocation];
//    NSString *location=[self deviceLocation];
//    NSLog(@"Location---%@",location);
//}

- (void)viewDidUnload
{
    [self setLocationSearchBar:nil];
    ///[self setLocationManager:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated{

    [self.tableView reloadData];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    if ([self.locationArray count]>0) {
        
        [self.locationArray removeAllObjects];
    }

}
////searcg delegate and display
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    [searchBar resignFirstResponder];
    //NSLog(@"search---%@",searchBar.text); 
    NSString *query=[searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];   
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&sensor=true&key=%@", query, kGOOGLE_API_KEY];
    
    NSLog(@"url---%@",url);
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
}

-(void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData 
                          
                          options:kNilOptions 
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"]; 
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", places);
    [self placeFilter:places];
}
-(void)placeFilter:(NSArray *)data{
    
    
    
    for (NSDictionary *tempDict in data) {
        MILocationClass *objAnn=[MILocationClass new];
        
        NSString *name=[tempDict objectForKey:@"name"];
        if (name!=nil) {
            objAnn.name=name;
        }
        else {
            objAnn.name=@"Unknown Name";
        }
        NSString *address=[tempDict objectForKey:@"formatted_address"];
        if (address!=nil) {
            objAnn.address=address;
        }
        else {
            objAnn.address=@"Unknown Address";
        }
        NSDictionary *geo = [tempDict objectForKey:@"geometry"];
        // Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];
        // 4 - Get your name and address info for adding to a pin.
        
        CLLocationCoordinate2D placeCoord;
        // Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        objAnn.lattitude=[NSString stringWithFormat:@"%f",placeCoord.latitude];
        objAnn.longitude=[NSString stringWithFormat:@"%f",placeCoord.longitude];
        /////get reference value
        NSLog(@"lat=%f and long=%f",placeCoord.latitude,placeCoord.longitude);
        NSLog(@"adress=%@",address);
        [locationArray addObject:objAnn];
        
    }

    [self.searchDisplayController setActive:NO];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) {
        return 1;
    }
    else {
        return [locationArray count];
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
    // Configure the cell...
    if ([indexPath section]==0) {
        cell.textLabel.numberOfLines=2;
        cell.textLabel.text=[self deviceLocation];
    }
    else {
        MILocationClass *obj=(MILocationClass *)[locationArray objectAtIndex:indexPath.row];
        NSLog(@"obj.address=%@",obj.address);
        cell.textLabel.text=obj.address;
    }
        
    
return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([indexPath section]==0) {
        
        self.title=@"Current Location";
        //delegate.locationTitle=@"Current Location";
    }
    else {
        MILocationClass *obj=(MILocationClass *)[locationArray objectAtIndex:indexPath.row];
        
        NSMutableString *title=[NSMutableString stringWithString:obj.name];
        [title appendString:obj.address];
        if (title!=nil) {
            
            self.title=title;
            miDelegate.locationTitle=title;
            miDelegate.globalLattitude=obj.lattitude;
            miDelegate.globalLongitude=obj.longitude;
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
