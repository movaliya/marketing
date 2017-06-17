//
//  CreateDispatchVW.m
//  digitalmarketing
//
//  Created by Mango SW on 18/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "CreateDispatchVW.h"

#import "digitalMarketing.pch"
#import "SerachProductVW.h"
#import "OrderDetail_Cell.h"
#import "IQKeyboardManager.h"

@interface CreateDispatchVW ()<SerachProductVWDelegate,UITextFieldDelegate>


@end


@implementation CreateDispatchVW

@synthesize SearchProBackView,CustomerVIEW,ProductTitleBackView,PopUpCustomerVW;
@synthesize CustomerTBL,selectCutomer_BTN,CreateDispatch_Btn;
@synthesize ProductTBL;
@synthesize CustomerPhoneLBL,CustomerAdressLBL,CutomerNameLBL,CustomerStateCityLBL;
@synthesize TitleTop1,TitleTop2,TitleTop3,TitleTop4,TitleHight;

@synthesize SelectDate_TXT,SelectDateView,LrNumber_TXT,LRNumber_View,Remark_view,Remark_TextView,MoreDetail_OK_Btn,MoreDetail_Cancel_Btn,AddMorDetail_view,MoreDetail_MainView;
@synthesize StoreTBL,Store_PopupView;
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
    CheckStoreServiceBOOL=NO;
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
    Store_PopupView.hidden=YES;
    CutomerID=@"";
    
    UINib *nib = [UINib nibWithNibName:@"OrderDetail_Cell" bundle:nil];
    OrderDetail_Cell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    ProductTBL.rowHeight = cell.frame.size.height;
    [ProductTBL registerNib:nib forCellReuseIdentifier:@"OrderDetail_Cell"];
    
    
    //****************************MoreDetailView*********************************************
    MoreDetail_MainView.hidden=YES;
    
    [AddMorDetail_view.layer setCornerRadius:3.0f];
    AddMorDetail_view.layer.borderWidth = 1.0f;
    [AddMorDetail_view.layer setMasksToBounds:YES];
    AddMorDetail_view.layer.borderColor = [UIColor clearColor].CGColor;
    
    [SelectDateView.layer setCornerRadius:3.0f];
    SelectDateView.layer.borderWidth = 1.0f;
    [SelectDateView.layer setMasksToBounds:YES];
    SelectDateView.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [LRNumber_View.layer setCornerRadius:3.0f];
    LRNumber_View.layer.borderWidth = 1.0f;
    [LRNumber_View.layer setMasksToBounds:YES];
    LRNumber_View.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [Remark_view.layer setCornerRadius:3.0f];
    Remark_view.layer.borderWidth = 1.0f;
    [Remark_view.layer setMasksToBounds:YES];
    Remark_view.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    
    [MoreDetail_Cancel_Btn.layer setCornerRadius:3.0f];
    MoreDetail_Cancel_Btn.layer.borderWidth = 1.0f;
    [MoreDetail_Cancel_Btn.layer setMasksToBounds:YES];
    MoreDetail_Cancel_Btn.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [MoreDetail_OK_Btn.layer setCornerRadius:3.0f];
    MoreDetail_OK_Btn.layer.borderWidth = 1.0f;
    [MoreDetail_OK_Btn.layer setMasksToBounds:YES];
    MoreDetail_OK_Btn.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:GregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:1];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-100];
    [datePicker setMaximumDate:maxDate];
    datePicker.backgroundColor=[UIColor whiteColor];
    
    [datePicker setMinimumDate:[NSDate date]];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle   = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:SelectDate_TXT action:@selector(resignFirstResponder)];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[itemSpace,itemDone];
    
    SelectDate_TXT.inputAccessoryView = toolbar;
    [SelectDate_TXT setInputView:datePicker];
    
    //***************************************END*********************************************
    
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
- (IBAction)Select_Store_Action:(id)sender
{
    Store_PopupView.hidden=NO;
    if (CheckStoreServiceBOOL==NO)
    {
        [self getStorDetail];
    }
    
}

-(void)getStorDetail
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_store  forKey:@"s"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleStorResponse:response];
     }];
}
- (void)handleStorResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        CheckStoreServiceBOOL=YES;
        storeDict=[response valueForKey:@"result"];
        [StoreTBL reloadData];
    }
    else
    {
        [StoreTBL reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (IBAction)Search_Pro_Btn_Action:(id)sender
{
    if (StoreID.length!=0)
    {
        SerachProductVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SerachProductVW"];
        vcr.delegate=self;
        vcr.CheckDispatch=@"DISPATCH";
        vcr.DispatchCutomerID=StoreID;
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:@"Alert..!" message:@"Please Select Store first." delegate:nil];
    }
    
}
#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==CustomerTBL)
    {
        return 1;
    }
   else if (tableView==StoreTBL)
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
    else if (tableView==StoreTBL )
    {
        return storeDict.count;
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
    else if (tableView==StoreTBL)
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
    else if (tableView==StoreTBL)
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
        
        UILabel *titleLBL=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 300, 30)];
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
        titleLBL.text=[[storeDict valueForKey:@"name"] objectAtIndex:indexPath.row];
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
    
    if (tableView==StoreTBL)
    {
        Store_PopupView.hidden=YES;
        StoreID=[[storeDict valueForKey:@"id"]objectAtIndex:indexPath.row ];
        [self.SelectStore_BTN setTitle:[[storeDict valueForKey:@"name"]objectAtIndex:indexPath.row ]forState:UIControlStateNormal];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==CustomerTBL)
    {
        return 44;
    }
    else if (tableView==StoreTBL)
    {
        return 30;
    }
    return 50;
}

- (void)ChkProductValue:(NSMutableArray *)ProductDict
{
    
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
    
    NSMutableArray *NewArr=[[NSMutableArray alloc]init];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    NSDictionary *oldDict = (NSDictionary *)[ProductDict objectAtIndex:0];
    [newDict addEntriesFromDictionary:oldDict];
    [newDict removeObjectForKey:@"product_stock"];
    [NewArr addObject:newDict];
    
    
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
            MoreDetail_MainView.hidden=NO;
        }
    }
}

-(void)CreateDispatch
{
    NSDate *todayDate = [NSDate date]; //Get todays date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dispatch_date;
    if ([SelectDate_TXT.text isEqualToString:@""])
    {
        dispatch_date = [dateFormatter stringFromDate:todayDate];
    }
    else
    {
         dispatch_date = SelectDate_TXT.text;
    }
    
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Add_dispatch_Order  forKey:@"s"];
    
    [dictParams setObject:CutomerID  forKey:@"customer_id"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"] forKey:@"sales_id"];
    
    [dictParams setObject:dispatch_date  forKey:@"dispatch_date"];
    [dictParams setObject:LrNumber_TXT.text  forKey:@"lr_number"];
    [dictParams setObject:Remark_TextView.text  forKey:@"remark"];
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (IBAction)MoreDetail_Ok_Action:(id)sender
{
    MoreDetail_MainView.hidden=YES;
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self CreateDispatch];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

- (IBAction)MoreDetail_Cancel_Action:(id)sender
{
    MoreDetail_MainView.hidden=YES;
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self CreateDispatch];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)SelectDate_TXT.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    SelectDate_TXT.text = [NSString stringWithFormat:@"%@",dateString];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    Remark_TextView.textColor=[UIColor blackColor];
    
    if ([textView.text isEqualToString:@"Enter Remark"]) {
        textView.text = @"";
        //textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    Remark_TextView.textColor=[UIColor blackColor];
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter Remark";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackBtn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
            GrandAmount=0;
            for (NSInteger jj=0; jj<ProductArry.count; jj++)
            {
                totalAmount=totalAmount+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue]*[[[ProductArry valueForKey:@"price"] objectAtIndex:jj] integerValue];
                
                totalQTY=totalQTY+[[[ProductArry valueForKey:@"qty"] objectAtIndex:jj] integerValue];
            }
            //  GrandAmount=totalAmount-DiscoutINT;
            //self.Discount_LBL.text=[NSString stringWithFormat:@"Rs.%ld",DiscoutINT];
            self.TotalQTY_LBL.text=[NSString stringWithFormat:@"Nos.%ld",(long)totalQTY];
            //self.TotalAmount_LBL.text=[NSString stringWithFormat:@"Rs.%ld",(long)totalAmount];
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
