//
//  SplashScreenViewController.m
//  myMenu
//
//  Created by HoaTruong on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "LocationObject_hoa.h"
#import "SignupViewController.h"
#import "ViewController.h"
@interface SplashScreenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewFrame;
@end

#define WIDTH_OF_SCROLL_PAGE 320
#define HEIGHT_OF_SCROLL_PAGE 460
#define WIDTH_OF_IMAGE 320
#define HEIGHT_OF_IMAGE 460
#define LEFT_EDGE_OFSET 0

@implementation SplashScreenViewController

@synthesize location;
@synthesize loginView;
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
  //  [self imageDisplay];
//    NSMutableAttributedString *attString =[[NSMutableAttributedString alloc] initWithString: @"truongConghoa"];
//    [attString addAttribute: NSFontAttributeName value:  [UIFont fontWithName:@"Helvetica" size:15] range: NSMakeRange(0,6)];
//   self.titleLabel.attributedText =  attString;

    location = [[LocationObject_hoa alloc] init];
      [self buildImageScrollView];
}
- (IBAction)pressedRegisterButton:(id)sender {
    SignupViewController *signupView = [[SignupViewController alloc]initWithNibName:@"SignupViewController" bundle:nil];
    [self presentViewController:signupView animated:YES completion:^{
    }];
}
- (IBAction)pressedLogin:(id)sender {
    [self presentViewController:self.loginView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Helpers
// lay du lieu tu model
- (void)buildImageScrollView {   
    self.imageScrollView .scrollEnabled = YES;
    //add the last image first
    UIImageView *imageView;
    imageView= [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_EDGE_OFSET, 0,WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE)];
    UIImage *image;
    image = [location.arrayImage objectAtIndex:[location.arrayImage count]-1];
    imageView.image = image ;
    [self.imageScrollView addSubview:imageView];
    for (int i=0; i<[[location arrayImage] count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_OF_IMAGE * i)+320, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE)];
        imageView.image = [[location arrayImage] objectAtIndex:i];
        [self.imageScrollView addSubview:imageView];
    }
    //add the first image at the end
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_OF_SCROLL_PAGE * ([location arrayImage].count +1), 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE)];
    imageView.image = [location.arrayImage objectAtIndex:0];
    [self.imageScrollView addSubview:imageView];

    [self.pageControl setNumberOfPages:[location arrayImage].count];
    self.pageControl.currentPage = 0;
    
    [self.imageScrollView setContentSize:CGSizeMake(WIDTH_OF_SCROLL_PAGE * ([location.arrayImage count]+2),HEIGHT_OF_SCROLL_PAGE)];
    [self.imageScrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.imageScrollView .frame.size.width;
    int page = floor((self.imageScrollView .contentOffset.x - pageWidth / ([[location arrayImage] count]+2)) / pageWidth) + 1;
    NSLog(@"cuoc doi van dep sao:%d",page);
    self.pageControl.currentPage = page-1;
    if (page >0 && page < [[location arrayImage] count] + 1) {
       // self.titleLabel.text = [location contentTitle:page-1];
        int lengthContentTitle = [[location contentTitle:page -1] length];
        NSString *string = [[location contentTitle:page -1] stringByAppendingString:[location contentNote:page-1]];
        NSMutableAttributedString *attString =[[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute: NSFontAttributeName value:  [UIFont fontWithName:@"Helvetica" size:15] range: NSMakeRange(lengthContentTitle,[[location contentNote:page-1] length])];
       self.titleLabel.attributedText =attString;
//        self.titleLabel.text = string;
        
        self.descriptionLabel.text = [location contentDescription:page -1];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = floor((self.imageScrollView.contentOffset.x - self.imageScrollView.frame.size.width / ([[location arrayImage] count]+2)) / self.imageScrollView.frame.size.width) + 1;
    if (currentPage==0) {
    	//go last but 1 page
    	[self.imageScrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE * [[location arrayImage] count],0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    } else if (currentPage==([[location arrayImage] count]+1)) {
    	[self.imageScrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    }
}
- (IBAction)pageControlSelected:(UIPageControl *)sender {
    float scrollToRect = (sender.currentPage + 1) * 320.;
    [self.imageScrollView setContentOffset:CGPointMake(scrollToRect, 0.)];
}
@end
