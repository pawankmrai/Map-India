//
//  MIMapDataViewController.m
//  Map-India
//
//  Created by Avneesh minocha on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMapDataViewController.h"
#import "MIDataClass.h"
#import "MIViewController.h"
#import "MIAppDelegate.h"

@interface MIMapDataViewController ()

@property(strong, nonatomic) NSMutableArray *seletedArray;
@end

@implementation MIMapDataViewController
@synthesize dataSearchBar = _dataSearchBar;
@synthesize dataArray=_dataArray;
@synthesize filteredDataArray=_filteredDataArray;
@synthesize sectionArray=_sectionArray;
@synthesize seletedArray;

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
    self.tableView.allowsSelectionDuringEditing=YES;
    
    seletedArray =[[NSMutableArray alloc] init];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _dataArray=[NSArray arrayWithObjects:
                [MIDataClass dataOfCategory:@"Travel"         name:@"Airport"],
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Amusement Park"],
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Art Gallery"],
                [MIDataClass dataOfCategory:@"Bank"           name:@"ATM"],
                
                
                [MIDataClass dataOfCategory:@"Food"           name:@"Bakery"],
                [MIDataClass dataOfCategory:@"Bank"           name:@"Bank"],
                [MIDataClass dataOfCategory:@"Food"           name:@"Bar"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Book Store"],
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Bowling Alley"],
                [MIDataClass dataOfCategory:@"Travel"         name:@"Bus Station"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Bycycle Store"],
                
                
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Cafe"],
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Casino"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Car Dealer"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Car Rental"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Car Repair"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Car Wash"],
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Cemetery"],
                [MIDataClass dataOfCategory:@"Place"          name:@"City Hall"],
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Church"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Clothing Store"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Convenience Store"],
                [MIDataClass dataOfCategory:@"Place"          name:@"Court House"],
                
                [MIDataClass dataOfCategory:@"Health"         name:@"Dentist"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Departmental Store"],
                [MIDataClass dataOfCategory:@"Health"         name:@"Doctor"],
                
                [MIDataClass dataOfCategory:@"Service"        name:@"Electrician"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Electronic Store"],
                [MIDataClass dataOfCategory:@"Place"          name:@"Embassy"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Estate Agency"],
                
                [MIDataClass dataOfCategory:@"Food"           name:@"Food"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Finance"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Fire Station"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Florist"],
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Funeral Home"],
                
                [MIDataClass dataOfCategory:@"Service"        name:@"Gas Station"],
                [MIDataClass dataOfCategory:@"Business"       name:@"General Contractor"],
                [MIDataClass dataOfCategory:@"Place"          name:@"Goverment Office"],
                [MIDataClass dataOfCategory:@"Health"         name:@"Gym"],
                
                [MIDataClass dataOfCategory:@"MakeUp"         name:@"Hair Care"],
                [MIDataClass dataOfCategory:@"MakeUp"         name:@"Hair Salon"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Hardware Store"],
                [MIDataClass dataOfCategory:@"Health"         name:@"Health"],
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Hindu Temple"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Home Good Store"],
                
                
                
                [MIDataClass dataOfCategory:@"Business"       name:@"Insurance Agency"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Jewelry Store"],
                
                [MIDataClass dataOfCategory:@"Service"        name:@"Laundry"],
                [MIDataClass dataOfCategory:@"Business"       name:@"Laywer"],
                [MIDataClass dataOfCategory:@"Place"          name:@"Library"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Liquor Store"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Lock Smith"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Lodging"],
                
                
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Masque"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Moving Company"],
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Movie Theater"],                
                [MIDataClass dataOfCategory:@"Place"          name:@"Museum"],
                
                [MIDataClass dataOfCategory:@"Entertainment"  name:@"Night Club"],
                
                [MIDataClass dataOfCategory:@"Service"        name:@"Painter"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Parking"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Pet Store"],
                [MIDataClass dataOfCategory:@"Health"         name:@"Pharmacy"],
                [MIDataClass dataOfCategory:@"Health"         name:@"Physiotherapist"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Plumber"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Police"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Post Office"],
                
                [MIDataClass dataOfCategory:@"Food"           name:@"Restaurant"],
                [MIDataClass dataOfCategory:@"Service"        name:@"Roofing Contractor"],
                [MIDataClass dataOfCategory:@"Service"        name:@"RV Park"],
                
                [MIDataClass dataOfCategory:@"Place"          name:@"School"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Shoe Store"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Shopping Store"],
                [MIDataClass dataOfCategory:@"MakeUp"         name:@"Spa"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Storage"],
                [MIDataClass dataOfCategory:@"Travel"         name:@"Subway"],
                [MIDataClass dataOfCategory:@"Store"          name:@"Supermarket"],
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Synagogue"],       
                
                [MIDataClass dataOfCategory:@"Travel"         name:@"Taxi Stand"],
                [MIDataClass dataOfCategory:@"Travel"         name:@"Train Station"],
                [MIDataClass dataOfCategory:@"Travel"         name:@"Travel Agency"],
                
                [MIDataClass dataOfCategory:@"Place"          name:@"University"],
                
                
                [MIDataClass dataOfCategory:@"Health"         name:@"Veterinory Care"],                
                
                [MIDataClass dataOfCategory:@"Devotional"     name:@"Worshship Place"],           
                
                [MIDataClass dataOfCategory:@"Place"          name:@"Zoo"],                
                             
                nil];
    ///initialize filtered data array    
    self.filteredDataArray = [NSMutableArray arrayWithCapacity:[_dataArray count]]; 
    
    [self filterSection];
    [self.tableView reloadData];
}

-(void)filterSection{

    BOOL found;
   _sectionArray =[[NSMutableArray alloc] init];
    
    // Loop through the books and create our keys
    for (MIDataClass *data in _dataArray)
    {
        NSString *c=[data.name substringToIndex:1];
        found=NO;
        
        for (int i=0;i<[_sectionArray count];i++)
        {
            NSString *str=[_sectionArray objectAtIndex:i];
            
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        
        if (!found)
        {
            [_sectionArray addObject:c];
        }
           
    }
    
   // NSLog(@"sections---%@",_sectionArray);

}
- (void)viewDidUnload
{
    [self setDataSearchBar:nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredDataArray count];
    }
    else         
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell==nil) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //create a data object
    MIDataClass *data=nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        data = [_filteredDataArray objectAtIndex:indexPath.row];
    }
    else {
        data=[_dataArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text=data.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return UITableViewCellEditingStyleDelete;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    // Return NO if you do not want the specified item to be editable.
//    
////    if (indexPath.section == 0) {
////        
////        if (indexPath.row == 0) {
////            
////            return NO;
////            
////        }
////        
////    }
//    
//    return  YES;
//}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.sectionArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {

    
    return index % 2;
}   

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     

    ///filter predicate   
    MIDataClass *data=nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        data = [_filteredDataArray objectAtIndex:indexPath.row];
    }
    else {
        data = [_dataArray objectAtIndex:indexPath.row];
    }
    NSString *title=data.category;
    [self filterData:title];    
    
    // Navigation logic may go here. Create and push another view controller.
    if (!self.editing) {
       
        NSLog(@" not editing");
        [self performSegueWithIdentifier:@"mapDetail" sender:tableView];
        MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.rowTitle=data.name;
        NSLog(@"title row selected---%@",delegate.rowTitle);
        
    }else {
         NSLog(@"editing");
        
        [seletedArray addObject:[_dataArray objectAtIndex:indexPath.row]];
    }
    
     
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    if(editing)
    {
        NSLog(@"editMode on");
    }
    else
    {
        NSLog(@"Done editing");
        NSLog(@"selected array---%@",seletedArray);
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:seletedArray];
        [userDefault setObject:data forKey:@"selected"];
        [userDefault synchronize];
    }
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

    return indexPath;
}

/////for filtering data


-(void)filterData:(NSString *)text{

    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.category contains[c]%@",text];
    NSArray *array = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
   // NSLog(@"list---%@",array);    
    MIAppDelegate *delegate=(MIAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.filteredArray=array;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([[segue identifier] isEqualToString:@"mapDetail"]) {
        
        MIViewController *mapController=[segue destinationViewController];
        if (sender==self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *string=[[_filteredDataArray objectAtIndex:[indexPath row]] name];
            [mapController setQuery:string];
        }
        else {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *string=[[_dataArray objectAtIndex:[indexPath row]] name];
            [mapController setQuery:string];           
        }
    }
}

//// filter text with search bar

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{

    
    [self.filteredDataArray removeAllObjects];
    ///filter array with NSPredicate
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.name contains[c]%@",searchText];
    _filteredDataArray = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
}
#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{

    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
