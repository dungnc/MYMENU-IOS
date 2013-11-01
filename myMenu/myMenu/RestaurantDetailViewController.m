//
//  RestaurantDetailViewController.m
//  myMenu
//
//  Created by HoaTruong on 10/28/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "LocationObject_hoa.h"
#import "RestaurantDetailObject.h"
@interface RestaurantDetailViewController ()

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *textScrollview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOnOffLabel;
@property (weak, nonatomic) IBOutlet UIButton *bioButton;
@property (assign, nonatomic) BOOL isDoubleClick;
@end
#define WIDTH_OF_SCROLL_PAGE 320
#define HEIGHT_OF_SCROLL_PAGE 220
#define WIDTH_OF_IMAGE 320
#define HEIGHT_OF_IMAGE 220

@implementation RestaurantDetailViewController
@synthesize location;
@synthesize restanrantDetail;
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
   // self.isDoubleClick = YES;
    self.textScrollview.hidden = YES;
    location = [[LocationObject_hoa alloc] init];
    restanrantDetail = [[RestaurantDetailObject alloc] init];
    [self buildImageScrollView];
    [self setLable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buildImageScrollView {
    self.imageScrollView .scrollEnabled = YES;
    for (int i=0; i<[[location arrayImage] count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_OF_IMAGE * i),0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE)];
        imageView.image = [[location arrayImage] objectAtIndex:i];
        [self.imageScrollView addSubview:imageView];
    }
    [self.pageControl setNumberOfPages:[location arrayImage].count];
    self.pageControl.currentPage = 0;
    
    [self.imageScrollView setContentSize:CGSizeMake(WIDTH_OF_SCROLL_PAGE * ([location.arrayImage count]),HEIGHT_OF_SCROLL_PAGE)];
    [self.imageScrollView scrollRectToVisible:CGRectMake(0,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
   
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.imageScrollView .frame.size.width;
    int page = floor((self.imageScrollView .contentOffset.x - pageWidth / [[location arrayImage] count]) / pageWidth)+1;
    //NSLog(@"cuoc doi van dep sao:%d",page);
    self.pageControl.currentPage = page;
}
- (void)setLable{
    NSDictionary *dictionary = [[restanrantDetail jsonResult] objectAtIndex:1];
    self.titleLabel.text = [dictionary objectForKey:@"name"];
    self.phoneLabel.text = [@"Phone:" stringByAppendingString:[dictionary objectForKey:@"phone"]];
    self.addressLabel.text = [@"Address:"stringByAppendingString:[dictionary objectForKey:@"address"]];
    self.webLabel.text = [dictionary objectForKey:@"web"];
    self.timeOnOffLabel.text = [@"Time: "stringByAppendingString:[dictionary objectForKey:@"timeOnOff"]];
   
}
- (IBAction)pageControlSelected:(UIPageControl *)sender {
    float scrollToRect = (sender.currentPage) * 320.;
    [self.imageScrollView setContentOffset:CGPointMake(scrollToRect, 0.)];
    
}
- (IBAction)setupBio:(id)sender {
//    if (self.textScrollview.hidden == NO) {
//         self.textScrollview.hidden = YES;
//        return;
//    }
    self.textScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(8.0f, 300.0f, 305.0f, 80.0f)];
    self.textScrollview.hidden = NO;
    NSString *abc =@"truong cong hoa nha so 2 kiet 84 le ngo cat thua thien dhfjsdgfjsdfgjsdfhgjsfgjsdfhgjsdfgjsdfgjsfghjdfjhdfgsjfhjdsfhue hien dang cong tac la la la ucoc doi van dep sao hehehe";
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, abc.length/2+20)];
    myLabel.text =abc;
    myLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    myLabel.textColor = [UIColor whiteColor];
    myLabel.backgroundColor = [UIColor blackColor];
    myLabel.numberOfLines = 20;
    self.textScrollview.pagingEnabled = YES;
    self.textScrollview.contentSize = CGSizeMake(self.textScrollview.contentSize.width, abc.length/2+20);
    [self.textScrollview addSubview:myLabel];
    [self.view addSubview:self.textScrollview];
//    }
//    else
//    {
//        self.textScrollview.hidden = YES;
//    }
}
- (IBAction)offBio:(id)sender {
     self.textScrollview.hidden = YES;
}
- (IBAction)offBioButton:(id)sender {
    self.textScrollview.hidden = YES;
}

@end
