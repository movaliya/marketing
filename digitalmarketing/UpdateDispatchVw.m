//
//  UpdateDispatchVw.m
//  digitalmarketing
//
//  Created by kaushik on 21/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "UpdateDispatchVw.h"
#import "digitalMarketing.pch"
#import "SerachProductVW.h"
#import "UpdateDispatchCell.h"
#import "HomeVW.h"

@interface UpdateDispatchVw ()<SerachProductVWDelegate,UITextFieldDelegate>

@end

@implementation UpdateDispatchVw
@synthesize SearchProBackView,CustomerVIEW,ProductTitleBackView,PopUpCustomerVW;
@synthesize CustomerTBL,selectCutomer_BTN,CreateDispatch_Btn;
@synthesize ProductTBL;
@synthesize CustomerPhoneLBL,CustomerAdressLBL,CutomerNameLBL,CustomerStateCityLBL;
@synthesize TitleTop1,TitleTop2,TitleTop3,TitleTop4,TitleHight;
@synthesize DispatchDetailDICTPass;

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldHidePreviousNext = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    CustomerPhoneLBL.text=@"";
    CustomerAdressLBL.text=@"";
    CutomerNameLBL.text=@"";
    CustomerStateCityLBL.text=@"";
    
    TitleTop1.constant=0;
    TitleTop2.constant=0;
    TitleTop3.constant=0;
    TitleTop4.constant=0;
    TitleHight.constant=10;
    
    
    
    CheckSUCCESS=NO;
    [CustomerVIEW.layer setCornerRadius:3.0f];
    CustomerVIEW.layer.borderWidth = 1.0f;
    CustomerVIEW.layer.borderColor = [UIColor clearColor].CGColor;
    
    [CustomerVIEW.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [CustomerVIEW.layer setShadowOpacity:0.8];
    [CustomerVIEW.layer setShadowRadius:1.0];
    [CustomerVIEW.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    [SearchProBackView.layer setCornerRadius:3.0f];
    SearchProBackView.layer.borderWidth = 1.0f;
    SearchProBackView.layer.borderColor = [UIColor clearColor].CGColor;
    [SearchProBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [SearchProBackView.layer setShadowOpacity:0.8];
    [SearchProBackView.layer setShadowRadius:1.0];
    [SearchProBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    
    [ProductTitleBackView.layer setCornerRadius:3.0f];
    ProductTitleBackView.layer.borderWidth = 1.0f;
    ProductTitleBackView.layer.borderColor = [UIColor clearColor].CGColor;
    [ProductTitleBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [ProductTitleBackView.layer setShadowOpacity:0.8];
    [ProductTitleBackView.layer setShadowRadius:1.0];
    [ProductTitleBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    [CreateDispatch_Btn.layer setCornerRadius:3.0f];
    CreateDispatch_Btn.layer.borderWidth = 1.0f;
    [CreateDispatch_Btn.layer setMasksToBounds:YES];
    CreateDispatch_Btn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [PopUpCustomerVW.layer setCornerRadius:3.0f];
    PopUpCustomerVW.layer.borderWidth = 1.0f;
    PopUpCustomerVW.layer.borderColor = [UIColor clearColor].CGColor;
    [PopUpCustomerVW.layer setShadowColor:[UIColor grayColor].CGColor];
    [PopUpCustomerVW.layer setShadowOpacity:0.8];
    [PopUpCustomerVW.layer setShadowRadius:2.0];
    [PopUpCustomerVW.layer setShadowOffset:CGSizeMake(10,10)];
    
    PopUpCustomerVW.hidden=YES;
    CutomerID=@"";
    Dispatch_ID=@"";
    
    UINib *nib = [UINib nibWithNibName:@"UpdateDispatchCell" bundle:nil];
    UpdateDispatchCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    ProductTBL.rowHeight = cell.frame.size.height;
    [ProductTBL registerNib:nib forCellReuseIdentifier:@"UpdateDispatchCell"];
    
    
    // Get data From dispatch Histry Detail
    if (DispatchDetailDICTPass)
    {
        totalAmount=0;
        totalQTY=0;
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [selectCutomer_BTN setTitle:[DispatchDetailDICTPass valueForKey:@"customer_name"]forState:UIControlStateNormal];
        Dispatch_ID=[DispatchDetailDICTPass valueForKey:@"id"];
        CutomerID=[DispatchDetailDICTPass valueForKey:@"customer_id"];
        CutomerNameLBL.text=[DispatchDetailDICTPass valueForKey:@"customer_name"];
        CustomerAdressLBL.text=[DispatchDetailDICTPass valueForKey:@"delivery_address"];
        CustomerPhoneLBL.text=[DispatchDetailDICTPass valueForKey:@"contact_person"];
        // NSString *city=[DispatchDetailDICTPass valueForKey:@"city"];
        //  NSString *State=[DispatchDetailDICTPass valueForKey:@"state"];
        // NSString *Country=[DispatchDetailDICTPass valueForKey:@"country"];
        // CustomerStateCityLBL.text=[NSString stringWithFormat:@"%@,%@,%@",city,State,Country];
        
        [self.StoreBtn setTitle:[DispatchDetailDICTPass valueForKey:@"store_name"]forState:UIControlStateNormal];
        
        TitleTop1.constant=15;
        TitleTop2.constant=8;
        TitleTop3.constant=8;
        TitleTop4.constant=8;
        TitleHight.constant=18;
        
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        NSMutableDictionary *ProductDictPass=[DispatchDetailDICTPass valueForKey:@"products"];
        NSMutableArray *tempArray=[[NSMutableArray alloc]init];
        for (int ii=0; ii<ProductDictPass.count; ii++)
        {
            NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
            [Productdict setObject:[[ProductDictPass valueForKey:@"pro_name"]objectAtIndex:ii] forKey:@"name"];
            [Productdict setObject:[[ProductDictPass valueForKey:@"id"]objectAtIndex:ii] forKey:@"id"];
            [Productdict setObject:[[ProductDictPass valueForKey:@"unitprice"]objectAtIndex:ii] forKey:@"price"];
            [Productdict setObject:[[ProductDictPass valueForKey:@"pro_qty"]objectAtIndex:ii] forKey:@"qty"];
            [tempArray addObject:Productdict];
        }
        ProductArry=[[NSMutableArray alloc]initWithArray:tempArray];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ProductArry options:0 error:&err];
        ProductJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [ProductTBL reloadData];
        
        totalAmount=[[DispatchDetailDICTPass valueForKey:@"grand_total"] integerValue];
        totalQTY=[[DispatchDetailDICTPass valueForKey:@"total_qty"] integerValue];
        self.TotalQTY_LBL.text=[NSString stringWithFormat:@"Nos.%ld",(long)totalQTY];
        self.GrantTotal_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
    }
    
    
}

- (IBAction)StoreBtn_Action:(id)sender {
}
- (IBAction)SelectCutomerBtn_Action:(id)sender
{
    PopUpCustomerVW.hidden=NO;
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        if (!CheckSUCCESS)
        {
            [self getCutomerDetail];
        }
        
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
-(void)getCutomerDetail
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_ordered_customer  forKey:@"s"];
    
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
        [CustomerTBL reloadData];
        CheckSUCCESS=YES;
    }
    else
    {
        [CustomerTBL reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (IBAction)Search_Pro_Btn_Action:(id)sender
{
    if (CutomerID.length!=0)
    {
        SerachProductVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SerachProductVW"];
        vcr.delegate=self;
        vcr.CheckDispatch=@"DISPATCH";
        vcr.DispatchCutomerID=CutomerID;
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:@"Alert..!" message:@"Please Select Customer first." delegate:nil];
    }
}
#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==CustomerTBL)
    {
        return 1;
    }
    else
    {
        return ProductArry.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==CustomerTBL )
    {
        return customerDict.count;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==CustomerTBL)
    {
        return 1;
    }
    else
    {
        return 0.0;
    }
    //return 10.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //if (tableView==CustomerTBL)
    // {
    //  return nil;
    // }
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==CustomerTBL)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UILabel *titleLBL=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 300, 44)];
        titleLBL.textColor=[UIColor colorWithRed:(132/255.0) green:(132/255.0) blue:(132/255.0) alpha:1.0];
        //titleLBL.backgroundColor=[UIColor redColor];
        
        if (IS_IPHONE_4 || isIPhone5)
        {
            titleLBL.font=[UIFont systemFontOfSize:11.5f];
        }
        else
        {
            titleLBL.font=[UIFont systemFontOfSize:13.0f];
        }
        titleLBL.text=[[customerDict valueForKey:@"cname"] objectAtIndex:indexPath.row];
        [cell addSubview:titleLBL];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"UpdateDispatchCell";
        UpdateDispatchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
        }
        
        cell.ProductName.text=[[ProductArry valueForKey:@"name"] objectAtIndex:indexPath.section];
        
        cell.ProductPrice.text=[[ProductArry valueForKey:@"price"] objectAtIndex:indexPath.section];
        
        cell.ProductQTY.text=[[ProductArry valueForKey:@"qty"] objectAtIndex:indexPath.section];
        cell.ProductQTY.tag=indexPath.section;
        cell.ProductQTY.delegate=self;
        cell.QntLine_LBL.tag=indexPath.section;
        
        NSInteger totalValue=[[[ProductArry valueForKey:@"qty"] objectAtIndex:indexPath.section] integerValue]*[[[ProductArry valueForKey:@"price"] objectAtIndex:indexPath.section] integerValue];
        cell.ProductAmount.text=[[ProductArry valueForKey:@"qty"] objectAtIndex:indexPath.section];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==CustomerTBL)
    {
        PopUpCustomerVW.hidden=YES;
        
        // Take Cutomer Detail From Here.
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [selectCutomer_BTN setTitle:[[customerDict valueForKey:@"cname"]objectAtIndex:indexPath.row ]forState:UIControlStateNormal];
        CutomerID=[[customerDict valueForKey:@"id"]objectAtIndex:indexPath.row];
        CutomerNameLBL.text=[[customerDict valueForKey:@"cname"]objectAtIndex:indexPath.row ];
        CustomerAdressLBL.text=[[customerDict valueForKey:@"address"]objectAtIndex:indexPath.row ];
        CustomerPhoneLBL.text=[[customerDict valueForKey:@"phone"]objectAtIndex:indexPath.row ];
        NSString *city=[[customerDict valueForKey:@"city"]objectAtIndex:indexPath.row ];
        NSString *State=[[customerDict valueForKey:@"state"]objectAtIndex:indexPath.row ];
        NSString *Country=[[customerDict valueForKey:@"country"]objectAtIndex:indexPath.row ];
        CustomerStateCityLBL.text=[NSString stringWithFormat:@"%@,%@,%@",city,State,Country];
        
        TitleTop1.constant=15;
        TitleTop2.constant=8;
        TitleTop3.constant=8;
        TitleTop4.constant=8;
        TitleHight.constant=18;
        
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==CustomerTBL)
    {
        return 44;
    }
    return 50;
    
}

- (void)ChkProductValue:(NSMutableArray *)ProductDict
{
    // NSLog(@"value====%@",ProductDict);
    
    // NSString *jsonString = [ProductDict JSONRepresentation];
    ProductArry=[[NSMutableArray alloc]initWithArray:ProductDict];
    
    totalAmount=0;
    totalQTY=0;
    for (NSInteger jj=0; jj<ProductArry.count; jj++)
    {
        totalAmount=totalAmount+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue]*[[[ProductArry valueForKey:@"price"] objectAtIndex:jj] integerValue];
        
        totalQTY=totalQTY+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue];
    }
    
    self.TotalQTY_LBL.text=[NSString stringWithFormat:@"Nos.%ld",(long)totalQTY];
    self.GrantTotal_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ProductArry options:0 error:&err];
    ProductJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [ProductTBL reloadData];
    
}
- (IBAction)CreateDispatch_Action:(id)sender
{
    if ([CutomerID isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Customer." delegate:nil];
    }
    else if (ProductArry.count==0)
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Product." delegate:nil];
    }
    else
    {
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
        {
            BOOL Chk = NO;
            for (int i=0; i<ProductArry.count; i++)
            {
                if ([[[ProductArry objectAtIndex:i] valueForKey:@"product_stock"] rangeOfString:@"-"].location == NSNotFound || [[[ProductArry objectAtIndex:i] valueForKey:@"product_stock"] rangeOfString:@"0"].location == NSNotFound)
                {
                    Chk=NO;
                    break;
                    [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[NSString stringWithFormat:@"Selected product quantity not available in stock."] delegate:nil];
                }
                else
                {
                    Chk=YES;
                    NSLog(@"string contains bla!");
                }
            }
            if (Chk==YES)
            {
                 [self CreateDispatch];
            }
        }
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
}

-(void)CreateDispatch
{
    
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:update_dispatch  forKey:@"s"];
    
    [dictParams setObject:CutomerID  forKey:@"customer_id"];
    [dictParams setObject:Dispatch_ID  forKey:@"id"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"] forKey:@"sales_id"];
    [dictParams setObject:ProductJSONString  forKey:@"product"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleDispatchResponse:response];
     }];
}
- (void)handleDispatchResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        for (UIViewController* viewController in self.navigationController.viewControllers)
        {
            if ([viewController isKindOfClass:[HomeVW class]] )
            {
                HomeVW *groupViewController = (HomeVW*)viewController;
                [self.navigationController popToViewController:groupViewController animated:YES];
            }
        }
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackBtn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // NSIndexPath *pathOfTheCell=[NSIndexPath indexPathForRow:0 inSection:[sender tag]];
    // OfferzoneCell *cell = (OfferzoneCell *)[TBL cellForRowAtIndexPath:pathOfTheCell];
    
    for (UIView *view in ProductTBL.subviews)
    {
        for (UpdateDispatchCell *cell in view.subviews)
        {
            if (cell.QntLine_LBL.tag==textField.tag)
            {
                cell.QntLine_LBL.backgroundColor=[UIColor colorWithRed:62.0f/255.0f green:64.0f/255.0f blue:149.0f/255.0f alpha:1.0f];
            }
            else
            {
                cell.QntLine_LBL.backgroundColor=[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0f];
            }
        }
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    for (UIView *view in ProductTBL.subviews)
    {
        for (UpdateDispatchCell *cell in view.subviews)
        {
            cell.QntLine_LBL.backgroundColor=[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0f];
        }
    }
    
    NSLog(@"==%@",[ProductArry objectAtIndex:textField.tag]);
    if ([textField.text isEqualToString:@""])
    {
        [ProductTBL reloadData];
    }
    else
    {
        NSString *Stock = [[ProductArry objectAtIndex:textField.tag] valueForKey:@"product_stock"];
        if ([Stock floatValue]>=[textField.text floatValue])
        {
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            NSDictionary *oldDict = (NSDictionary *)[ProductArry objectAtIndex:textField.tag];
            [newDict addEntriesFromDictionary:oldDict];
            [newDict setObject:textField.text forKey:@"qty"];
            [ProductArry replaceObjectAtIndex:textField.tag withObject:newDict];
            
            totalAmount=0;
            totalQTY=0;
            for (NSInteger jj=0; jj<ProductArry.count; jj++)
            {
                totalAmount=totalAmount+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue]*[[[ProductArry valueForKey:@"price"] objectAtIndex:jj] integerValue];
                
                totalQTY=totalQTY+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue];
            }
            
            self.TotalQTY_LBL.text=[NSString stringWithFormat:@"Nos.%ld",(long)totalQTY];
            self.GrantTotal_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ProductArry options:0 error:&err];
            ProductJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        else
        {
            [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[NSString stringWithFormat:@"%@ Qnt not available in stock.",textField.text] delegate:nil];
        }
        
        
        [ProductTBL reloadData];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:textField.text];
    
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    return stringIsValid;
}



@end
