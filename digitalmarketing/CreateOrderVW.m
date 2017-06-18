//
//  CreateOrderVW.m
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "CreateOrderVW.h"
#import "digitalMarketing.pch"
#import "SerachProductVW.h"
#import "OrderDetail_Cell.h"


@interface CreateOrderVW ()<SerachProductVWDelegate,UITextFieldDelegate>


@end

@implementation CreateOrderVW
@synthesize SearchProBackView,SelectCustomerBackView,ProductTitleBackView;
@synthesize CreateOrderBtn,CutomerView,CustomerTBL,SelectCutomer_Button;
@synthesize ProductTBL;
@synthesize TitleHight,TitleTop1,TitleTop2,TitleTop3,TitleTop4;

@synthesize CustomerPhoneLBL,CustomerAdressLBL,CutomerNameLBL,CustomerStateCityLBL;

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
    [SelectCustomerBackView.layer setCornerRadius:3.0f];
    SelectCustomerBackView.layer.borderWidth = 1.0f;
    SelectCustomerBackView.layer.borderColor = [UIColor clearColor].CGColor;
    
    [SelectCustomerBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [SelectCustomerBackView.layer setShadowOpacity:0.8];
    [SelectCustomerBackView.layer setShadowRadius:1.0];
    [SelectCustomerBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
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
    
    [CreateOrderBtn.layer setCornerRadius:3.0f];
    CreateOrderBtn.layer.borderWidth = 1.0f;
    [CreateOrderBtn.layer setMasksToBounds:YES];
    CreateOrderBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [CutomerView.layer setCornerRadius:3.0f];
    CutomerView.layer.borderWidth = 1.0f;
    CutomerView.layer.borderColor = [UIColor clearColor].CGColor;
    [CutomerView.layer setShadowColor:[UIColor grayColor].CGColor];
    [CutomerView.layer setShadowOpacity:0.8];
    [CutomerView.layer setShadowRadius:2.0];
    [CutomerView.layer setShadowOffset:CGSizeMake(10,10)];
    
    CutomerView.hidden=YES;
    CutomerID=@"";
    
    UINib *nib = [UINib nibWithNibName:@"OrderDetail_Cell" bundle:nil];
    OrderDetail_Cell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    ProductTBL.rowHeight = cell.frame.size.height;
    [ProductTBL registerNib:nib forCellReuseIdentifier:@"OrderDetail_Cell"];

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
        [CustomerTBL reloadData];
        CheckSUCCESS=YES;
    }
    else
    {
        [CustomerTBL reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (IBAction)SelectCustomerBtn_POPUP_Action:(id)sender
{
    CutomerView.hidden=NO;
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
        static NSString *CellIdentifier = @"OrderDetail_Cell";
        OrderDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
        }
        
        cell.ProductName.text=[[ProductArry valueForKey:@"name"] objectAtIndex:indexPath.section];
        
        cell.ProductPrice.text=[[ProductArry valueForKey:@"price"] objectAtIndex:indexPath.section];
        
        cell.Qnt_TXT.text=[[ProductArry valueForKey:@"qty"] objectAtIndex:indexPath.section];
        cell.Qnt_TXT.tag=indexPath.section;
        cell.QntLine_LBL.tag=indexPath.section;
        cell.Qnt_TXT.delegate=self;
        
        NSInteger totalValue=[[[ProductArry valueForKey:@"qty"] objectAtIndex:indexPath.section] integerValue]*[[[ProductArry valueForKey:@"price"] objectAtIndex:indexPath.section] integerValue];
        cell.ProductAmount.text=[NSString stringWithFormat:@"%ld",(long)totalValue];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==CustomerTBL)
    {
       CutomerView.hidden=YES;
        
        TitleTop1.constant=15;
        TitleTop2.constant=8;
        TitleTop3.constant=8;
        TitleTop4.constant=8;
        TitleHight.constant=18;
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        // Take Cutomer Detail From Here.
        [SelectCutomer_Button setTitle:[[customerDict valueForKey:@"cname"]objectAtIndex:indexPath.row ]forState:UIControlStateNormal];
        CutomerID=[[customerDict valueForKey:@"id"]objectAtIndex:indexPath.row];
        CutomerNameLBL.text=[[customerDict valueForKey:@"cname"]objectAtIndex:indexPath.row ];
        CustomerAdressLBL.text=[[customerDict valueForKey:@"address"]objectAtIndex:indexPath.row ];
        CustomerPhoneLBL.text=[[customerDict valueForKey:@"phone"]objectAtIndex:indexPath.row ];
        NSString *city=[[customerDict valueForKey:@"city"]objectAtIndex:indexPath.row ];
        NSString *State=[[customerDict valueForKey:@"state"]objectAtIndex:indexPath.row ];
        NSString *Country=[[customerDict valueForKey:@"country"]objectAtIndex:indexPath.row ];
        CustomerStateCityLBL.text=[NSString stringWithFormat:@"%@,%@,%@",city,State,Country];
        
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

- (IBAction)SearchProBtn_action:(id)sender
{
    SerachProductVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SerachProductVW"];
    vcr.delegate=self;
    [self.navigationController pushViewController:vcr animated:YES];
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
    self.TotalAmount_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
    self.GrantTotal_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ProductArry options:0 error:&err];
    ProductJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [ProductTBL reloadData];
    
}
- (IBAction)CreateOrderBtn_Action:(id)sender
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
            [self CreateOrder];
        }
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
    
    
}

-(void)CreateOrder
{

    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Create_Order  forKey:@"s"];
    
    [dictParams setObject:CutomerID  forKey:@"customer_id"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"] forKey:@"sales_id"];
    
    [dictParams setObject:@"0"  forKey:@"discount"];
    [dictParams setObject:@"0"  forKey:@"discount_type"];
    
    [dictParams setObject:[NSString stringWithFormat:@"%ld",(long)totalAmount]  forKey:@"grand_total"];
    [dictParams setObject:[NSString stringWithFormat:@"%ld",(long)totalAmount]  forKey:@"total_amount"];
    [dictParams setObject:[NSString stringWithFormat:@"%ld",(long)totalQTY]  forKey:@"total_qty"];
    [dictParams setObject:ProductJSONString  forKey:@"product"];
   
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleGetPROResponse:response];
     }];
}

- (void)handleGetPROResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        [self.view endEditing:YES];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.view endEditing:YES];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (IBAction)BackBtn_Action:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        for (OrderDetail_Cell *cell in view.subviews)
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
        for (OrderDetail_Cell *cell in view.subviews)
        {
            cell.QntLine_LBL.backgroundColor=[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0f];
        }
    }
    if ([textField.text isEqualToString:@""])
    {
        [ProductTBL reloadData];
    }
    else
    {
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        NSDictionary *oldDict = (NSDictionary *)[ProductArry objectAtIndex:textField.tag];
        [newDict addEntriesFromDictionary:oldDict];
        [newDict setObject:textField.text forKey:@"qty"];
        [ProductArry replaceObjectAtIndex:textField.tag withObject:newDict];
        
        totalAmount=0;
        totalQTY=0;
        GrandAmount=0;
        for (NSInteger jj=0; jj<ProductArry.count; jj++)
        {
            totalAmount=totalAmount+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue]*[[[ProductArry valueForKey:@"price"] objectAtIndex:jj] integerValue];
            
            totalQTY=totalQTY+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue];
        }
      //  GrandAmount=totalAmount-DiscoutINT;
        //self.Discount_LBL.text=[NSString stringWithFormat:@"Rs.%ld",DiscoutINT];
        self.TotalQTY_LBL.text=[NSString stringWithFormat:@"Nos.%ld",(long)totalQTY];
        self.TotalAmount_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
        self.GrantTotal_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)GrandAmount];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:ProductArry options:0 error:&err];
        ProductJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [ProductTBL reloadData];
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *fulltext = [textField.text stringByAppendingString:string];
    NSString *charactersSetString = @"0123456789.";
    
    
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:charactersSetString];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:fulltext];
    
    // If typed character is out of Set, ignore it.
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    if(!stringIsValid) {
        return NO;
    }
    
    
    NSString *currentText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // Change the "," (appears in other locale keyboards, such as russian) key ot "."
    currentText = [currentText stringByReplacingOccurrencesOfString:@"," withString:@"."];
    
    // Check the statements of decimal value.
    if([fulltext isEqualToString:@"."]) {
        textField.text = @"0.";
        return NO;
    }
    
    if([fulltext rangeOfString:@".."].location != NSNotFound) {
        textField.text = [fulltext stringByReplacingOccurrencesOfString:@".." withString:@"."];
        return NO;
    }
    
    // If second dot is typed, ignore it.
    NSArray *dots = [fulltext componentsSeparatedByString:@"."];
    if(dots.count > 2) {
        textField.text = currentText;
        return NO;
    }
    
    // If first character is zero and second character is > 0, replace first with second. 05 => 5;
    if(fulltext.length == 2) {
        if([[fulltext substringToIndex:1] isEqualToString:@"0"] && ![fulltext isEqualToString:@"0."]) {
            textField.text = [fulltext substringWithRange:NSMakeRange(1, 1)];
            return NO;
        }
    }
    return YES;
}

@end
