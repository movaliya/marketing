//
//  Updateinwardhistory.m
//  digitalmarketing
//
//  Created by kaushik on 21/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "Updateinwardhistory.h"
#import "digitalMarketing.pch"
#import <QuartzCore/QuartzCore.h>
#import "OrderDetail_Cell.h"

@interface Updateinwardhistory ()

@end

@implementation Updateinwardhistory
@synthesize DetailBackView,CutomerName,OrderDate,OrderStatus,OrderNamuber,TotalAmount,TotalQTY,GrandTotal,Discount;
@synthesize TitleBackView,OrderDetailTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        [self getInwardDetial];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void)getInwardDetial
{
    
//    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
//    [dictParams setObject:Base_Key  forKey:@"key"];
//    [dictParams setObject:get_inward_store_item  forKey:@"s"];
//    [dictParams setObject:self.inward_id  forKey:@"inward_id"];
//    
//    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
//     {
//         [self handleInwardDetialResponse:response];
//     }];
    
}

- (void)handleInwardDetialResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        
        OrderDetailDict=[response valueForKey:@"result"];
        OrderProductDict=[OrderDetailDict valueForKey:@"products"];
        
        CutomerName.text=[OrderDetailDict valueForKey:@"vendor_name"];
        OrderNamuber.text=[NSString stringWithFormat:@"Inward Number :#%@",[OrderDetailDict valueForKey:@"id"]];
        OrderDate.text=[NSString stringWithFormat:@"Inward Date :%@",[OrderDetailDict valueForKey:@"adate"]];
        TotalQTY.text=[NSString stringWithFormat:@"Nos.%@",[OrderDetailDict valueForKey:@"total_qty"]];
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
    
    cell.ProductName.text=[[OrderProductDict valueForKey:@"product_name"] objectAtIndex:indexPath.section];
    
    cell.ProductPrice.text=[[OrderProductDict valueForKey:@"product_price"] objectAtIndex:indexPath.section];
    
    cell.ProductQTY.text=[[OrderProductDict valueForKey:@"receive_qty"] objectAtIndex:indexPath.section];
    cell.ProductAmount.text=[[OrderProductDict valueForKey:@"product_total"] objectAtIndex:indexPath.section];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)Edit_Btn_Action:(id)sender
{
    
}

- (IBAction)BackBtn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
