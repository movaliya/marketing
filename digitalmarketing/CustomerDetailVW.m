//
//  CustomerDetailVW.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "CustomerDetailVW.h"
#import "Customer_Cell.h"
#import "digitalMarketing.pch"

@interface CustomerDetailVW ()

@end

@implementation CustomerDetailVW
@synthesize CustomerTable,serachBar,SearchBackView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // CustomerTable.layer.borderWidth = 1.0f;
   // CustomerTable.layer.cornerRadius=2.0f;
   // [CustomerTable.layer setMasksToBounds:YES];
   // CustomerTable.layer.borderColor = [UIColor colorWithRed:(132/255.0) green:(132/255.0) blue:(132/255.0) alpha:1.0].CGColor;
    
    serachBar.layer.borderWidth = 1;
    serachBar.layer.borderColor = [UIColor whiteColor].CGColor;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [SearchBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [SearchBackView.layer setShadowOpacity:0.8];
    [SearchBackView.layer setShadowRadius:1.0];
    [SearchBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    UINib *nib = [UINib nibWithNibName:@"Customer_Cell" bundle:nil];
    CustomerTable.estimatedRowHeight = 183;
    CustomerTable.rowHeight = UITableViewAutomaticDimension;
    [CustomerTable registerNib:nib forCellReuseIdentifier:@"Customer_Cell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getCutomerDetail];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void)getCutomerDetail
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_CutomerDetail  forKey:@"s"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleCutomerDTResponse:response];
     }];
}
- (void)handleCutomerDTResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        customerDict=[response valueForKey:@"result"];
        [CustomerTable reloadData];
    }
    else
    {
        [CustomerTable reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return customerDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13.0; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Customer_Cell";
    Customer_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.CustomerName.text=[[[customerDict valueForKey:@"cname"] objectAtIndex:indexPath.section] uppercaseString];
    cell.Customer_ID.text=[NSString stringWithFormat:@"#%@",[[customerDict valueForKey:@"id"] objectAtIndex:indexPath.section]];
    cell.Address.text=[[customerDict valueForKey:@"address"] objectAtIndex:indexPath.section];
    NSString*city=[[customerDict valueForKey:@"city"] objectAtIndex:indexPath.section];
    NSString *stateStr=[[customerDict valueForKey:@"state"] objectAtIndex:indexPath.section];
    NSString *Country=[[customerDict valueForKey:@"country"] objectAtIndex:indexPath.section];
    NSString *citystateCounty=[NSString stringWithFormat:@"%@,%@,%@",city,stateStr,Country];
    cell.Customer_StateCnty.text=citystateCounty;
    cell.MobileNumber.text=[[customerDict valueForKey:@"phone"] objectAtIndex:indexPath.section];
    cell.ResigterDate.text=[[customerDict valueForKey:@"created_date"] objectAtIndex:indexPath.section];
    
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)searchBtn_action:(id)sender
{
    [serachBar resignFirstResponder];
}

- (IBAction)BackBtn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
