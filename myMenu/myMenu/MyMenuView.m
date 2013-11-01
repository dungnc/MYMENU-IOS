//
//  MyMenuView.m
//  myMenu
//
//  Created by Judge Man on 10/29/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "MyMenuView.h"
#import "MenuCell.h"
#import "HomeMenu.h"
@interface  MyMenuView(){
    NSMutableArray *dictMenu;
}

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@end
@implementation MyMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)viewDidLoad
{
    dictMenu = [HomeMenu returnListMenu];
}
-(void) setInfoUser
{
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dictMenu count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row]==[dictMenu count])
    {
        NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        return cell;
    }
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:[MenuCell reuseIdentifier]];
    if (cell == nil) 	{
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MenuCell class]) owner:self options:nil];
        cell = nib[0];
    }
    NSDictionary *dict = [dictMenu objectAtIndex:indexPath.row];
    cell.icon.image = [UIImage imageNamed:[dict objectForKey:@"imagePath"]];
    cell.nameLB.text = [dict objectForKey:@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
