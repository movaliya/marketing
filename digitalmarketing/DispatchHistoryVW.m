//
//  DispatchHistoryVW.m
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "DispatchHistoryVW.h"
#import "DispatchHSTY_CELL.h"
#import "digitalMarketing.pch"
#import "DispatchHRTYDetailVW.h"
@interface DispatchHistoryVW ()

@end

@implementation DispatchHistoryVW
@synthesize DispatchHstyTLB;


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"DispatchHSTY_CELL" bundle:nil];
    [DispatchHstyTLB registerNib:nib forCellReuseIdentifier:@"DispatchHSTY_CELL"];
    DispatchHstyTLB.estimatedRowHeight = 183;
    DispatchHstyTLB.rowHeight = UITableViewAutomaticDimension;
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getDispatchHistory];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}

-(void)getDispatchHistory
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_all_dispatch  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"sales_id"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleDispatchHistoryResponse:response];
     }];
}
- (void)handleDispatchHistoryResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        DispatchHistyDict=[response valueForKey:@"result"];
        [DispatchHstyTLB reloadData];
    }
    else
    {
        [DispatchHstyTLB reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return DispatchHistyDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DispatchHSTY_CELL";
    DispatchHSTY_CELL *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    
    cell.CutomerName.text=[[DispatchHistyDict valueForKey:@"customer_name"] objectAtIndex:indexPath.section];
    cell.OrderNumber.text=[NSString stringWithFormat:@"Order Number :#%@",[[DispatchHistyDict valueForKey:@"id"] objectAtIndex:indexPath.section]];
    cell.OrderDate.text=[NSString stringWithFormat:@"Order Date :%@",[[DispatchHistyDict valueForKey:@"dispatch_date"] objectAtIndex:indexPath.section]];
    
    cell.LRNumber.text=[NSString stringWithFormat:@"LR Number :%@",[[DispatchHistyDict valueForKey:@"lr_number"] objectAtIndex:indexPath.section]];
    cell.Remarks.text=[NSString stringWithFormat:@"Remark :%@",[[DispatchHistyDict valueForKey:@"remark"] objectAtIndex:indexPath.section]];
    
    if ([cell.LRNumber.text isEqualToString:@"LR Number :"])
    {
        cell.LRNumberHight.constant=0;
        cell.LRNoTop.constant=0;
    }
    if ([cell.Remarks.text isEqualToString:@"Remark :"])
    {
        cell.RemarkHight.constant=0;
        cell.RemarkTop.constant=0;
    }

    cell.TotalQTY.text=[NSString stringWithFormat:@"Nos.%@",[[DispatchHistyDict valueForKey:@"total_qty"] objectAtIndex:indexPath.section]];
    cell.GrandTotal.text=[NSString stringWithFormat:@"Rs.%@",[[DispatchHistyDict valueForKey:@"grand_total"] objectAtIndex:indexPath.section]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DispatchHRTYDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DispatchHRTYDetailVW"];
    vcr.Dispatch_id=[[DispatchHistyDict valueForKey:@"id"] objectAtIndex:indexPath.section];
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
