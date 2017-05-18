//
//  InwardHistryVW.m
//  digitalmarketing
//
//  Created by Mango SW on 18/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "InwardHistryVW.h"
#import "digitalMarketing.pch"
#import "InwardHitry_CELL.h"
#import "InwardHTYDetail.h"
@interface InwardHistryVW ()

@end

@implementation InwardHistryVW
@synthesize InwardHstyTLB;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"InwardHitry_CELL" bundle:nil];
    [InwardHstyTLB registerNib:nib forCellReuseIdentifier:@"InwardHitry_CELL"];
    
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getInwardHistory];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void)getInwardHistory
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_all_inward_store  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"sales_id"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleInwardHistoryResponse:response];
     }];
}
- (void)handleInwardHistoryResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        InwardHistyDict=[response valueForKey:@"result"];
        [InwardHstyTLB reloadData];
    }
    else
    {
        [InwardHstyTLB reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return InwardHistyDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 237;
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
    static NSString *CellIdentifier = @"InwardHitry_CELL";
    InwardHitry_CELL *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    cell.CutomerName.text=[[InwardHistyDict valueForKey:@"vendor_name"] objectAtIndex:indexPath.section];
    cell.OrderNumber.text=[NSString stringWithFormat:@"Inward Number :#%@",[[InwardHistyDict valueForKey:@"id"] objectAtIndex:indexPath.section]];
    cell.OrderDate.text=[NSString stringWithFormat:@"Inward Date :%@",[[InwardHistyDict valueForKey:@"modified_date"] objectAtIndex:indexPath.section]];
    
    
    cell.TotalQTY.text=[NSString stringWithFormat:@"Nos.%@",[[InwardHistyDict valueForKey:@"total_qty"] objectAtIndex:indexPath.section]];
    cell.GrandTotal.text=[NSString stringWithFormat:@"Rs.%@",[[InwardHistyDict valueForKey:@"grand_total"] objectAtIndex:indexPath.section]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InwardHTYDetail *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InwardHTYDetail"];
    vcr.inward_id=[[InwardHistyDict valueForKey:@"id"] objectAtIndex:indexPath.section];
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
