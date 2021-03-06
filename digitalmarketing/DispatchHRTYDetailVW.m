//
//  DispatchHRTYDetailVW.m
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "DispatchHRTYDetailVW.h"
#import "digitalMarketing.pch"
#import <QuartzCore/QuartzCore.h>
#import "OrderDetail_Cell.h"
#import "UpdateDispatchVw.h"

@interface DispatchHRTYDetailVW ()

@end

@implementation DispatchHRTYDetailVW
@synthesize DetailBackView,CutomerName,OrderDate,OrderStatus,OrderNamuber,TotalAmount,TotalQTY,GrandTotal,Discount;
@synthesize TitleBackView,OrderDetailTable,Store_Name;

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    if ([[UserSaveData valueForKey:@"dispatch_update_flag"] isEqualToString:@"0"])
    {
        self.Edit_Btn.hidden=YES;
    }
    
    [DetailBackView.layer setCornerRadius:3.0f];
    DetailBackView.layer.borderWidth = 1.0f;
    [DetailBackView.layer setMasksToBounds:YES];
    DetailBackView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    DetailBackView.layer.masksToBounds = NO;
    [DetailBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [DetailBackView.layer setShadowOpacity:0.8];
    [DetailBackView.layer setShadowRadius:2.0];
    [DetailBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    [TitleBackView.layer setCornerRadius:3.0f];
    TitleBackView.layer.borderWidth = 1.0f;
    [TitleBackView.layer setMasksToBounds:YES];
    TitleBackView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    TitleBackView.layer.masksToBounds = NO;
    [TitleBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [TitleBackView.layer setShadowOpacity:0.8];
    [TitleBackView.layer setShadowRadius:2.0];
    [TitleBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    
    UINib *nib = [UINib nibWithNibName:@"OrderDetail_Cell" bundle:nil];
    OrderDetail_Cell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    OrderDetailTable.rowHeight = cell.frame.size.height;
    [OrderDetailTable registerNib:nib forCellReuseIdentifier:@"OrderDetail_Cell"];
    
    [DetailBackView setHidden:YES];
    [TitleBackView setHidden:YES];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getDispatchDetial];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
-(void)getDispatchDetial
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_dispatch_item  forKey:@"s"];
    [dictParams setObject:self.Dispatch_id  forKey:@"dispatch_id"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleOderDetailResponse:response];
     }];
}
- (void)handleOderDetailResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        
        OrderDetailDict=[response valueForKey:@"result"];
        OrderProductDict=[OrderDetailDict valueForKey:@"products"];
        Store_Name.text=[OrderDetailDict valueForKey:@"store_name"];
        CutomerName.text=[OrderDetailDict valueForKey:@"customer_name"];
        OrderNamuber.text=[NSString stringWithFormat:@"Order Number :%@",[OrderDetailDict valueForKey:@"customer_id"]];
        OrderDate.text=[NSString stringWithFormat:@"Order Date :%@",[OrderDetailDict valueForKey:@"dispatch_date"]];
        OrderStatus.text=@"";
        TotalQTY.text=[NSString stringWithFormat:@"Nos.%@",[OrderDetailDict valueForKey:@"total_qty"]];
        //TotalAmount.text=[NSString stringWithFormat:@"Rs.%@",[OrderDetailDict valueForKey:@"totalprice"] ];
       // Discount.text=@"";
        GrandTotal.text=[NSString stringWithFormat:@"Rs.%@",[OrderDetailDict valueForKey:@"grand_total"]];
        
        [DetailBackView setHidden:NO];
        [TitleBackView setHidden:NO];
        
        [OrderDetailTable reloadData];
    }
    else
    {
        [DetailBackView setHidden:YES];
        [TitleBackView setHidden:YES];
        [OrderDetailTable reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return OrderProductDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderDetail_Cell";
    OrderDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    cell.ProductName.text=[[OrderProductDict valueForKey:@"pro_name"] objectAtIndex:indexPath.section];
    
    cell.ProductPrice.text=[[OrderProductDict valueForKey:@"unitprice"] objectAtIndex:indexPath.section];
    
    cell.Qnt_TXT.text=[[OrderProductDict valueForKey:@"pro_qty"] objectAtIndex:indexPath.section];
    cell.Qnt_TXT.enabled=NO;
    cell.QntLine_LBL.hidden=YES;
    cell.ProductAmount.text=[[OrderProductDict valueForKey:@"totalprice"] objectAtIndex:indexPath.section];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)Edit_Btn_Action:(id)sender
{
    UpdateDispatchVw *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UpdateDispatchVw"];
    vcr.DispatchDetailDICTPass=[OrderDetailDict mutableCopy];
    [self.navigationController pushViewController:vcr animated:NO];
}

- (IBAction)BackBtn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
