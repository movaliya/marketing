//
//  NotificationVW.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "NotificationVW.h"
#import "Notification_Cell.h"
#import "digitalMarketing.pch"
#import "OrderDetailVW.h"

@interface NotificationVW ()

@end

@implementation NotificationVW
@synthesize NotifTableView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"Notification_Cell" bundle:nil];
    Notification_Cell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NotifTableView.rowHeight = cell.frame.size.height;
    [NotifTableView registerNib:nib forCellReuseIdentifier:@"Notification_Cell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getNotification];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)getNotification
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_notification  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"sales_id"];

    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleGetResponse:response];
     }];
}
- (void)handleGetResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        NotificationDic=[response valueForKey:@"result"];
        [NotifTableView reloadData];
    }
    else
    {
        [NotifTableView reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NotificationDic.count;
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
    static NSString *CellIdentifier = @"Notification_Cell";
    Notification_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    cell.Customer_name.text=[[NotificationDic valueForKey:@"customer_name"] objectAtIndex:indexPath.section];
    cell.Order_Number.text=[NSString stringWithFormat:@"Order Number :%@",[[NotificationDic valueForKey:@"order_no"] objectAtIndex:indexPath.section]];
    cell.Order_date.text=[NSString stringWithFormat:@"Order Date :%@",[[NotificationDic valueForKey:@"order_date"] objectAtIndex:indexPath.section]];
    cell.OderStatus.text=[[NotificationDic valueForKey:@"status_slug"] objectAtIndex:indexPath.section];
    cell.TotalQTY.text=[NSString stringWithFormat:@"Nos.%@",[[NotificationDic valueForKey:@"total_qty"] objectAtIndex:indexPath.section]];
    cell.TotalAmount.text=[NSString stringWithFormat:@"Rs.%@",[[NotificationDic valueForKey:@"total_amount"] objectAtIndex:indexPath.section]];
    cell.Discount.text=[NSString stringWithFormat:@"Rs.%@",[[NotificationDic valueForKey:@"discount"] objectAtIndex:indexPath.section]];
    cell.GrandTotal.text=[NSString stringWithFormat:@"Rs.%@",[[NotificationDic valueForKey:@"grand_total"] objectAtIndex:indexPath.section]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderDetailVW"];
    vcr.order_id=[[NotificationDic valueForKey:@"id"] objectAtIndex:indexPath.section];
    vcr.CheckNotificationView=@"NotiVW";
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
