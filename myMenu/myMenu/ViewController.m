//
//  ViewController.m
//  myMenu
//
//  Created by Judge Man on 10/23/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//
#import "SplashScreenViewController.h"
#import "ViewController.h"
#import "RestaurantDetailViewController.h"
#import "MySearchViewController.h"
#import "AFSearchLocation.h"
#import "MyMenuAppController.h"
#import "LocationDataController.h"
#import "LocationObject.h"
#import "UIView+FrameAdditions.h"
#import "RestaurantTableCell.h"
#import "MyMenuView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
    UISearchBar *searchBar;
    NSMutableArray *locationNearMe;
    NSArray *subviewArray;
    BOOL isDragging_msg, isDecliring_msg;
}
@property (nonatomic,strong)  UIBarButtonItem *leftButton;
@property (nonatomic,strong)  UIBarButtonItem *rightButton;
@property (nonatomic,strong)  UIBarButtonItem *cancelButton;
@property (nonatomic, strong) NSArray *locations;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) IBOutlet UITableView *tableRestaurant;
@property (nonatomic, retain) MyMenuView *myMenu;
@property (nonatomic, assign) BOOL mapViewExpanded;
@property (nonatomic, assign) BOOL menuOpen;
@end

@implementation ViewController
@synthesize loginView;
- (void)LoginViewControllerDidFinish:(ViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) returnInfoToHomeViewController:(NSDictionary*) JSON
{
    _jsonResult = JSON;
    [self searchNearMyCurrentLocation];
    NSDictionary *info= [_jsonResult objectForKey:@"user"];
    self.myMenu.userName.text = [info objectForKey:@"email"];
    self.myMenu.status.text =  @"Status: Gold";
    if([info objectForKey:@"points"]!=[NSNull null])
        self.myMenu.points.text = [@"Points: " stringByAppendingFormat:@"%@",[info objectForKey:@"points"]];
    else
        self.myMenu.points.text = @"Points: 0";
}
- (void)viewDidLoad
{
    locationNearMe =  [[NSMutableArray alloc]init];
    [super viewDidLoad];
    [[MyMenuAppController sharedController] setBackgroundImageForViewController:self];
    searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    [searchBar setBackgroundColor:[UIColor clearColor]];
	self.navigationItem.titleView = searchBar;
    self.leftButton = [[UIBarButtonItem alloc] initWithTitle:@"MyMenu" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed)];
    self.navigationItem.leftBarButtonItem = self.leftButton;
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"MySearch" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed)];
    self.navigationItem.rightBarButtonItem = self.rightButton;
    self.cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 170,44);
    loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    loginView.delegate = self;
    loginView.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //[self presentViewController:loginView animated:NO completion:nil];
    SplashScreenViewController *splashView = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil];
    splashView.loginView = loginView;
    splashView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:splashView animated:NO completion:nil];
    self.mapViewExpanded = YES;
    self.menuOpen = NO;
}
-(void) viewWillAppear:(BOOL)animated
{
    [self loadMapView];
    subviewArray = [[NSBundle mainBundle] loadNibNamed:@"MyMenuView" owner:self options:nil];
    self.myMenu = [subviewArray objectAtIndex:0];
    [self.myMenu viewDidLoad];
    self.myMenu.frame = CGRectMake(0,-100, 0,0);
    self.myMenu.backgroundColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:52/255.0 alpha:1];
    [self.view addSubview:self.myMenu];
}

-(void) loadMapView
{
    LocationDataController *model = [[LocationDataController alloc] init];
    NSArray *location = [model getMinAndMaxLatitueAndLogitude:self.locations];
    MKCoordinateRegion region;
    Location *min = [location objectAtIndex:0];
    Location *max = [location objectAtIndex:1];
    region.center.latitude = (min.latitude + max.latitude) / 2;
    region.center.longitude = (min.longitude + max.longitude) / 2;
    @try {
        region.span.latitudeDelta = (max.latitude - min.latitude) * 1.1;
        
        region.span.latitudeDelta = (region.span.latitudeDelta < 0.01)
        ? 0.01
        : region.span.latitudeDelta;
        
        region.span.longitudeDelta = (max.longitude - min.longitude) * 1.1;
        
        MKCoordinateRegion scaledRegion = [self.mapView regionThatFits:region];
        [self.mapView setRegion:scaledRegion animated:YES];
    }
    @catch (NSException *exception) {
        return;
    }
}
- (void) reloadMapView
{
    MKCoordinateRegion region;
    LocationObject *min = [self.locations objectAtIndex:0];
    LocationObject *max = [self.locations objectAtIndex:0];
    region.center.latitude = (min.latitude + max.latitude) / 2;
    region.center.longitude = (min.longitude + max.longitude) / 2;
    region.span.latitudeDelta = (max.latitude - min.latitude) * 1.1;
    region.span.latitudeDelta = (region.span.latitudeDelta < 0.01)
    ? 0.01
    : region.span.latitudeDelta;
    region.span.longitudeDelta = (max.longitude - min.longitude) * 1.1;
    MKCoordinateRegion scaledRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:scaledRegion animated:YES];  
}
- (IBAction)relocateMapView:(id)sender {
    [self searchNearMyCurrentLocation];
}
- (IBAction)pressedExpand:(id)sender {
    self.tableRestaurant.hidden = YES;
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.mapViewExpanded) {
            [self.tableRestaurant setFrameYOffset:181.];
            self.tableViewHeight.constant = 300.;
        } else {
            [self.tableRestaurant setFrameYOffset:344.];
            self.tableViewHeight.constant = 160.;
        }
        [self.view layoutIfNeeded];
    } completion: ^(BOOL finished)  {
        self.tableRestaurant.hidden = NO;
    }];
    self.mapViewExpanded = !self.mapViewExpanded;
}
#pragma mark MapView Delegate Methods
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.locations];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[LocationObject class]]) {
        LocationObject *locAnnotation = (LocationObject *)annotation;
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            UIButton *callout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [callout addTarget:self action:@selector(callOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            callout.tag = locAnnotation.locationID;
            annotationView.rightCalloutAccessoryView = callout;
            annotationView.pinColor = MKPinAnnotationColorGreen;
            annotationView.animatesDrop = YES;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    return nil;
}

-(void) searchNearMyCurrentLocation
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[_jsonResult objectForKey:@"access_token"], @"access_token", @"", @"search",Nil];
    [AFOptionText getTextWithBlock:^(NSString *result, NSArray *items, NSError *error) {
        if(error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Failed to Retrieve Data" message:@"Please try again." delegate:nil cancelButtonTitle:@"Okey, I'll try later" otherButtonTitles:nil] show];
        }
        else
        {
            if([result isEqualToString:@"ok"])
            {
                if(self.locations)
                {
                    self.locations = nil;
                }
                NSLog(@"ok baby");
                self.locations = [[MyMenuAppController sharedController] sortArrayBasedOnDistance:items];
                for(LocationObject *obj in self.locations)
                {
                    if(obj.distance<20)
                        [locationNearMe addObject:obj];
                }
                if([locationNearMe count])
                {
                    self.locations = locationNearMe;
                    [self loadMapView];
                    [self.mapView addAnnotations:self.locations];
                    [self.tableRestaurant reloadData];
                    //self.locations = [[NSMutableArray alloc] initWithArray:items];
                }
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Notice" message:result delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
            }
        }
        
    } pushParam:params pushPath:kAPISearchName];
}
-(void)leftButtonPressed
{
    if(!self.menuOpen)
        //
    {
        CGRect navframe = [[self.navigationController navigationBar] frame];
        NSTimeInterval animationDuration = 0.4;
        CGRect newFrameSize = CGRectMake(0,0, 280,460-navframe.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.myMenu.frame = newFrameSize;
        [UIView commitAnimations];
        self.menuOpen = YES;
    }
    else
    {
        NSTimeInterval animationDuration = 0.4;
        CGRect newFrameSize = CGRectMake(0,-100, 0,0);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.myMenu.frame = newFrameSize;
        [UIView commitAnimations];
        self.menuOpen = NO;
    }
}
-(void)rightButtonPressed
{
    MySearchViewController *mysearch = [[MySearchViewController alloc]initWithNibName:@"MySearchViewController" bundle:nil];
    mysearch.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
   // mysearch.modalPresentationStyle = UIModalPresentationFullScreen;
    mysearch.restaurantObjects = locationNearMe;
    [self presentViewController:mysearch animated:YES completion:nil];
}
-(void)cancelButtonPressed
{
    self.navigationItem.leftBarButtonItem = self.leftButton;
    self.navigationItem.rightBarButtonItem = self.rightButton;
    [searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = self.cancelButton;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)search
{
    [searchBar resignFirstResponder];
    [self.mapView removeAnnotations:self.mapView.annotations];
    NSString *access_token = [_jsonResult objectForKey:@"access_token"];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:access_token, @"access_token", searchBar.text, @"search",Nil];
    [AFOptionText getTextWithBlock:^(NSString *result, NSArray *items, NSError *error) {
        if(error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Failed to Retrieve Data" message:@"Please try again." delegate:nil cancelButtonTitle:@"Okey, I'll try later" otherButtonTitles:nil] show];
        }
        else
        {
            if([result isEqualToString:@"ok"])
            {
                if(self.locations)
                {
                    self.locations = nil;
                }
                self.locations = [[MyMenuAppController sharedController] sortArrayBasedOnDistance:items];
                if([self.locations count])
                {
                    [self reloadMapView];
                    [self.mapView addAnnotations:self.locations];
                    [self.tableRestaurant reloadData];
                    //self.locations = [[NSMutableArray alloc] initWithArray:items];
                }
                else
                {
                    [self.tableRestaurant reloadData];
                }
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Notice" message:result delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
            }
        }
    } pushParam:params pushPath:kAPISearchName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.locations.count == 0) {
        NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.font = [UIFont italicSystemFontOfSize:19.];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"No results found.";
        cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:13.];
        cell.detailTextLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.text = @"You can look at a specific location by using the search bar above.";
        return cell;
    }
    RestaurantTableCell *cell = (RestaurantTableCell *)[tableView dequeueReusableCellWithIdentifier:[RestaurantTableCell reuseIdentifier]];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RestaurantTableCell class]) owner:self options:nil];
        cell = nib[0];
    }
    cell.indexPathRow = indexPath.row;
    LocationObject *location = [self.locations objectAtIndex:indexPath.row];
    cell.location = location;
    if (location.logo) {
        cell.icon.image = location.logo;
    } else if (location.logoURL){
        //[cell.iconIndicator startAnimating];
        if (!isDragging_msg && !isDecliring_msg)
        {
            location.logo = nil;
            [self performSelectorInBackground:@selector(loadLogoRestaurant:) withObject:indexPath];
        }
        else
        {
             cell.icon.image = [UIImage imageNamed:@"loading.jpg"];
        }
    } else {
        cell.icon.image = nil;
    }
    return cell;
}
-(void)loadLogoRestaurant:(NSIndexPath *)path{
    LocationObject *loca = [self.locations objectAtIndex:path.row];
    NSString *str = [kAPILink stringByAppendingString:loca.logoURL];
    UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
    loca.logo = img;
   [self.tableRestaurant performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    isDragging_msg = FALSE;
    [self.tableRestaurant reloadData];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    isDecliring_msg = FALSE;
    [self.tableRestaurant reloadData]; }
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isDragging_msg = TRUE;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    isDecliring_msg = TRUE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.locations.count == 0) {
        return 1;
    }
    return self.locations.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RestaurantDetailViewController *controller = [RestaurantDetailViewController new];
    [self.navigationController pushViewController:controller animated:YES];

}
@end
