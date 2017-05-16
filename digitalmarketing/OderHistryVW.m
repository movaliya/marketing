//
//  OderHistryVW.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "OderHistryVW.h"
#import "digitalMarketing.pch"
#import "OrderHistry_Cell.h"
#import "OrderDetailVW.h"

@interface OderHistryVW ()

@end

@implementation OderHistryVW
@synthesize Histry_Table;


- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"OrderHistry_Cell" bundle:nil];
    OrderHistry_Cell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    Histry_Table.rowHeight = cell.frame.size.height;
    [Histry_Table registerNib:nib forCellReuseIdentifier:@"OrderHistry_Cell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getOderHistory];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
-(void)getOderHistory
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_all_orders  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"sales_id"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleOderHistoryResponse:response];
     }];
}
- (void)handleOderHistoryResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        OrderHistryDict=[response valueForKey:@"result"];
        [Histry_Table reloadData];
    }
    else
    {
        [Histry_Table reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return OrderHistryDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderHistry_Cell";
    OrderHistry_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    cell.Customer_name.text=[[OrderHistryDict valueForKey:@"customer_name"] objectAtIndex:indexPath.section];
    cell.Order_Number.text=[NSString stringWithFormat:@"Order Number :%@",[[OrderHistryDict valueForKey:@"order_no"] objectAtIndex:indexPath.section]];
    cell.Order_date.text=[NSString stringWithFormat:@"Order Date :%@",[[OrderHistryDict valueForKey:@"order_date"] objectAtIndex:indexPath.section]];
    cell.OderStatus.text=[[OrderHistryDict valueForKey:@"status_slug"] objectAtIndex:indexPath.section];
    cell.TotalQTY.text=[NSString stringWithFormat:@"Nos.%@",[[OrderHistryDict valueForKey:@"total_qty"] objectAtIndex:indexPath.section]];
    cell.TotalAmount.text=[NSString stringWithFormat:@"Rs.%@",[[OrderHistryDict valueForKey:@"total_amount"] objectAtIndex:indexPath.section]];
    cell.Discount.text=[NSString stringWithFormat:@"Rs.%@",[[OrderHistryDict valueForKey:@"discount"] objectAtIndex:indexPath.section]];
    cell.GrandTotal.text=[NSString stringWithFormat:@"Rs.%@",[[OrderHistryDict valueForKey:@"grand_total"] objectAtIndex:indexPath.section]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderDetailVW"];
    vcr.order_id=[[OrderHistryDict valueForKey:@"id"] objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:vcr animated:YES];
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
