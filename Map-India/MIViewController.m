//
//  MIViewController.m
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIViewController.h"
#import "MIMapPoint.h"
#import "MISearchViewController.h"
#import "MIAppDelegate.h"
#import "MIDataClass.h"
#import "MIAnnotationDetailViewController.h"

@interface MIViewController ()

@end

@implementation MIViewController
@synthesize mapView;
@synthesize scrollView;
@synthesize searchBar=_searchBar;
@synthesize dirBar=_dirBar;
@synthesize fromField=_fromField;
@synthesize toField=_toField;
@synthesize query=_query; 
@synthesize refDictionary=_refDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Make this controller the delegate for the map view.
    self.mapView.delegate = self;     
    
    // Ensure that you can view your own location in the map view.
    [self.mapView setShowsUserLocation:YES];
    
    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    firstLaunch=YES;
    
    ///scroll view
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite; 
    
   
    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
     /////pass filter data for button creation
    [self createButton:scrollView withData:delegate.filteredArray];
    
}
-(void)createButton:(UIScrollView *)scroll withData:(NSArray *)array{

   // NSLog(@"button data---%@",array);
    MIDataClass *tempData=nil;
    float x=scroll.frame.origin.x;
    for (int i=0; i<[array count]; i++) {
        
        tempData=(MIDataClass *)[array objectAtIndex:i];
        NSString *title=tempData.name;
       // NSLog(@"name--%@",tempData.name);
        UIButton *scrollButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [scrollButton setBackgroundImage:[UIImage imageNamed:@"btn_title.png"] forState:UIControlStateNormal];
        [scrollButton.titleLabel setTextColor:[UIColor whiteColor]];
        [scrollButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        //[scrollButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -10, -25.0, 0.0)];
        [scrollButton setTitle:title forState:UIControlStateNormal];
        [scrollButton setFrame:CGRectMake(x+5, 9, 150, 31)];
        [scrollButton addTarget:self action:@selector(scrollButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:scrollButton];
        x+=160;
        [scroll setContentSize:CGSizeMake(x, 40)];
    }
    
}
- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view
}
#pragma mark - MKMapViewDelegate methods. 
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {    
    CLLocationCoordinate2D centre=[mv centerCoordinate];
    MKCoordinateRegion region;
    if (firstLaunch) {
        region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,10000,10000);
        firstLaunch=NO;
    }else {
        //Set the center point to the visible region of the map and change the radius to match the search radius passed to the Google query string.
        region = MKCoordinateRegionMakeWithDistance(centre,currenDist,currenDist);
    }
    
    [mv setRegion:region animated:YES];
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

    //Get the east and west points on the map so you can calculate the distance (zoom level) of the current map view.
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    //Set your current distance instance variable.
    currenDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    
    //Set your current center point on the map instance variable.
    currentCentre = self.mapView.centerCoordinate;
   
}
-(void)showPlaceFromRowSelect{

    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *placeTitle=[delegate.rowTitle lowercaseString];
    
    [self queryGooglePlaces:placeTitle];


}
//////////bar button methods
- (void)scrollButtonPress:(id)sender {
    UIButton *button=(UIButton *)sender;
    NSString *buttonTitle=[button.titleLabel.text lowercaseString];
    
    if ([buttonTitle isEqualToString:@"amusement park"]) {
        buttonTitle=@"amusement_park";
    }
    if ([buttonTitle isEqualToString:@"art gallery"]) {
        buttonTitle=@"art_gallery";
    }
    if ([buttonTitle isEqualToString:@"book store"]) {
        buttonTitle=@"book_store";
    }
    if ([buttonTitle isEqualToString:@"bowling alley"]) {
        buttonTitle=@"art_gallery";
    }
    if ([buttonTitle isEqualToString:@"bus station"]) {
        buttonTitle=@"bus_station";
    }
    if ([buttonTitle isEqualToString:@"bycycle store"]) {
        buttonTitle=@"bycycle_store";
    }
    if ([buttonTitle isEqualToString:@"car dealer"]) {
        buttonTitle=@"car_dealer";
    }
    if ([buttonTitle isEqualToString:@"car rental"]) {
        buttonTitle=@"car_rental";
    }
    if ([buttonTitle isEqualToString:@"car repair"]) {
        buttonTitle=@"car_repair";
    }
    if ([buttonTitle isEqualToString:@"car wash"]) {
        buttonTitle=@"car_wash";
    }
    if ([buttonTitle isEqualToString:@"city hall"]) {
        buttonTitle=@"city_hall";
    }
    if ([buttonTitle isEqualToString:@"clothing store"]) {
        buttonTitle=@"clothing_store";
    }
    if ([buttonTitle isEqualToString:@"convenience store"]) {
        buttonTitle=@"convenience_store";
    }
    if ([buttonTitle isEqualToString:@"court house"]) {
        buttonTitle=@"court_house";
    }
    if ([buttonTitle isEqualToString:@"departmental store"]) {
        buttonTitle=@"departmental_store";
    }
    if ([buttonTitle isEqualToString:@"electronic store"]) {
        buttonTitle=@"electronic_store";
    }
    if ([buttonTitle isEqualToString:@"estate agency"]) {
        buttonTitle=@"estate_agency";
    }
    if ([buttonTitle isEqualToString:@"fire station"]) {
        buttonTitle=@"fire_station";
    }
    if ([buttonTitle isEqualToString:@"funeral home"]) {
        buttonTitle=@"funeral_home";
    }
    if ([buttonTitle isEqualToString:@"gas station"]) {
        buttonTitle=@"gas_station";
    }
    if ([buttonTitle isEqualToString:@"general contractor"]) {
        buttonTitle=@"general_contractor";
    }
    if ([buttonTitle isEqualToString:@"goverment office"]) {
        buttonTitle=@"goverment_office";
    }
    if ([buttonTitle isEqualToString:@"hair care"]) {
        buttonTitle=@"hair_care";
    }
    if ([buttonTitle isEqualToString:@"hair salon"]) {
        buttonTitle=@"hair_salon";
    }
    if ([buttonTitle isEqualToString:@"hardware store"]) {
        buttonTitle=@"hardware_store";
    }
    if ([buttonTitle isEqualToString:@"hindu temple"]) {
        buttonTitle=@"hindu_temple";
    }
    if ([buttonTitle isEqualToString:@"home good store"]) {
        buttonTitle=@"home_good_store";
    }
    if ([buttonTitle isEqualToString:@"insurance agency"]) {
        buttonTitle=@"insurance_agency";
    }
    if ([buttonTitle isEqualToString:@"jewelry store"]) {
        buttonTitle=@"jewelry_store";
    }
    if ([buttonTitle isEqualToString:@"liquor store"]) {
        buttonTitle=@"liquor_store";
    }
    if ([buttonTitle isEqualToString:@"lock smith"]) {
        buttonTitle=@"lock_smith";
    }
    if ([buttonTitle isEqualToString:@"moving company"]) {
        buttonTitle=@"moving_company";
    }
    if ([buttonTitle isEqualToString:@"movie theater"]) {
        buttonTitle=@"movie_theater";
    }
    if ([buttonTitle isEqualToString:@"night club"]) {
        buttonTitle=@"night_club";
    }
    if ([buttonTitle isEqualToString:@"pet store"]) {
        buttonTitle=@"pet_store";
    }
    if ([buttonTitle isEqualToString:@"post office"]) {
        buttonTitle=@"post_office";
    }
    if ([buttonTitle isEqualToString:@"roofing contractor"]) {
        buttonTitle=@"roofing_contractor";
    }
    if ([buttonTitle isEqualToString:@"rv park"]) {
        buttonTitle=@"rv_park";
    }
    if ([buttonTitle isEqualToString:@"shoe store"]) {
        buttonTitle=@"shoe_store";
    }
    if ([buttonTitle isEqualToString:@"shopping store"]) {
        buttonTitle=@"shopping_store";
    }
    if ([buttonTitle isEqualToString:@"supermarket"]) {
        buttonTitle=@"grocery_or_supermarket";
    }
    if ([buttonTitle isEqualToString:@"taxi stand"]) {
        buttonTitle=@"taxi_stand";
    }
    if ([buttonTitle isEqualToString:@"train station"]) {
        buttonTitle=@"train_station";
    }
    if ([buttonTitle isEqualToString:@"travel agency"]) {
        buttonTitle=@"travel_agency";
    }
    if ([buttonTitle isEqualToString:@"veterinory care"]) {
        buttonTitle=@"veterinory_care";
    }
    if ([buttonTitle isEqualToString:@"worshship place"]) {
        buttonTitle=@"worshship_place";
    }
   // NSLog(@"title--%@",buttonTitle);
    
    [self queryGooglePlaces:buttonTitle];
}

-(void)queryGooglePlaces:(NSString *)googleType{

    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", [delegate.globalLattitude floatValue], [delegate.globalLongitude floatValue], [NSString stringWithFormat:@"%i", currenDist], googleType, kGOOGLE_API_KEY];
    
    NSLog(@"url---%@",url);
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL
    dispatch_async(kBgQueue, ^{
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
    if ([places count]!=0) {
        [self ploatPositions:places];
    }
    else {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Nothing Found Near You" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //Write out the data to the console.
   // NSLog(@"Google Data: %@", places);
    
}

///ploting positions
-(void)ploatPositions:(NSArray *)data{

    // 1 - Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in mapView.annotations) {
        if ([annotation isKindOfClass:[MIMapPoint class]]) {
            [mapView removeAnnotation:annotation];
        }
    }
    NSMutableArray *nameArray=[[NSMutableArray alloc] init];
    NSMutableArray *refArray=[[NSMutableArray alloc] init];
    // 2 - Loop through the array of places returned from the Google API.
    for (int i=0; i<[data count]; i++) {
        //Retrieve the NSDictionary object in each index of the array.
        NSDictionary* place = [data objectAtIndex:i];
        // 3 - There is a specific NSDictionary object that gives us the location info.
        NSDictionary *geo = [place objectForKey:@"geometry"];
        // Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];
        // 4 - Get your name and address info for adding to a pin.
        NSString *name=[place objectForKey:@"name"];// add to dictionary
        [nameArray addObject:name];
        
        NSString *vicinity=[place objectForKey:@"vicinity"];
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        // Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        /////get reference value
        
        NSString *referance=[place objectForKey:@"reference"];//add to dictionary
        [refArray addObject:referance];
        
        // 5 - Create a new annotation.
        MIMapPoint *placeObject = [[MIMapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        [mapView addAnnotation:placeObject];
    }
_refDictionary=[NSMutableDictionary dictionaryWithObjects:refArray forKeys:nameArray];
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Define your reuse identifier.
    static NSString *identifier = @"MIMapPoint";   
    
    if ([annotation isKindOfClass:[MIMapPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button setImage:[UIImage imageNamed:@"detail.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"detail.png"] forState:UIControlStateHighlighted];
        [button setTitle:annotation.title forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView=button;
        return annotationView;
    }
    return nil;    
}

//pin on map
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    // Define your reuse identifier.
//    static NSString *identifier = @"MIMapPoint";   
//    
//    if ([annotation isKindOfClass:[MIMapPoint class]]) {
//        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (annotationView == nil) {
//            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        } else {
//            annotationView.annotation = annotation;
//        }
//        annotationView.enabled = YES;
//        annotationView.canShowCallout = YES;
//        annotationView.animatesDrop = YES;
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [button setTitle:annotation.title forState:UIControlStateNormal];
//        annotationView.rightCalloutAccessoryView=button;
//        return annotationView;
//    }
//    return nil;    
//}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{

    NSString *title=[view.annotation title];
    //NSLog(@"title---%@",title);
   // NSLog(@"dictionary---%@",_refDictionary);
    
   // NSLog(@"ref----%@",[_refDictionary objectForKey:title]);
    NSString *ref=[_refDictionary objectForKey:title];
        
    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    delegate.refKeyGB=ref;
    
    
    [self performSegueWithIdentifier:@"detailView" sender:control];

}


////interface for direction api
- (IBAction)directionInterface:(id)sender {
    
    UISegmentedControl *button=(UISegmentedControl *)sender;
    //NSLog(@"index---%i",button.selectedSegmentIndex);
    if (button.selectedSegmentIndex==0) {
        [_dirBar removeFromSuperview];
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, 320, 40)];
        [_searchBar setDelegate:self];
        [_searchBar showsCancelButton];
        _searchBar.searchResultsButtonSelected=YES;
        [self.view addSubview:_searchBar];
    }
    else{
        [_searchBar removeFromSuperview];
       _dirBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 44, 320, 40)];
        
        _fromField=[[UITextField alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
        [_fromField setPlaceholder:@"From"];
        [_fromField setDelegate:self];
        [_fromField setBorderStyle:UITextBorderStyleRoundedRect];  
        [_fromField setReturnKeyType:UIReturnKeySearch];
        [_dirBar addSubview:_fromField];
        
        _toField=[[UITextField alloc] initWithFrame:CGRectMake(190, 5, 120, 30)];
        [_toField setPlaceholder:@"To"];
        [_toField setDelegate:self];
        [_toField setBorderStyle:UITextBorderStyleRoundedRect];
        [_toField setReturnKeyType:UIReturnKeySearch];
        [_dirBar addSubview:_toField];
        
        [self.view addSubview:_dirBar];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
    NSLog(@"search---%@",searchBar.text);
    UIViewController *search=[[MISearchViewController alloc] initWithNibName:@"MISearchViewController" bundle:nil];
    [self presentModalViewController:search animated:YES];
    
}
///////text field delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     
    [textField resignFirstResponder];
    
    if (_toField.text!=nil  &&  _fromField.text!=nil) {
        NSString *urlString=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true",_fromField.text,_toField.text];
        NSURL *url=[NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Enter Both Value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } 
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
