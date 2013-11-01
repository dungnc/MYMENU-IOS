//
//  MySearchViewController.m
//  myMenu
//
//  Created by Judge Man on 10/31/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "MySearchViewController.h"
#import "LocationObject.h"
#import "RestaurantTableCell.h"

@interface MySearchViewController ()
{
    BOOL isDragging_msg, isDecliring_msg;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableRestaurant;
@property (strong, nonatomic) IBOutlet UITextField *searchTF;
@property (strong, nonatomic) SearchView *searchView;
@end

@implementation MySearchViewController
@synthesize restaurantObjects;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:self options:nil];
        self.searchView = [subviewArray objectAtIndex:0];
        [self.searchView viewDidLoad];
        self.searchView.frame = CGRectMake(0,-500, 320,0);
        self.searchView.delegate = self;
        [self.view addSubview:self.searchView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.restaurantObjects.count == 0) {
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
    LocationObject *location = [self.restaurantObjects objectAtIndex:indexPath.row];
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
    LocationObject *loca = [self.restaurantObjects objectAtIndex:path.row];
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
    if (self.restaurantObjects.count == 0) {
        return 1;
    }
    return self.restaurantObjects.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark TextField Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];

    CGRect newFrameSize = CGRectMake(0,0, 320,460);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.searchView.frame = newFrameSize;
    self.searchView.alpha = 0.98;
    [UIView commitAnimations];
}
#pragma mark searchView Delegates
- (void)SearchViewDidFinish
{
    CGRect newFrameSize = CGRectMake(0,-500, 320,0);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.searchView.frame = newFrameSize;
    [UIView commitAnimations];
}
@end
