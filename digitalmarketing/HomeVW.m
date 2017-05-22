//
//  HomeVW.m
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "HomeVW.h"
#import "ProfileVIEW.h"
#import "NotificationVW.h"
#import "StockVW.h"
#import "OderHistryVW.h"
#import "CustomerDetailVW.h"
#import "CreateOrderVW.h"
#import "DispatchHistoryVW.h"
#import "CreateDispatchVW.h"
#import "CreateInwardOrderVW.h"
#import "InwardHistryVW.h"

@interface HomeVW ()

@end

@implementation HomeVW
@synthesize AttendenceIcon_Btn;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav CheckLoginArr];
    [self.rootNav.pan_gr setEnabled:YES];
    
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:NO];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSString *attendance = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"ATTENDENCE"];
    if (attendance.length>0)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *en_US = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:en_US];
        
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-60*60*7]];
        NSDate *SaveDate = [dateFormatter dateFromString:attendance];
        
        
        
        NSDate *todayDate = [NSDate date]; //Get todays date
        NSDateFormatter *dateFormatter11 = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
        [dateFormatter11 setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
        NSString *convertedDateString = [dateFormatter11 stringFromDate:todayDate];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        NSLocale *en_US1 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter1 setLocale:en_US1];
        
        [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-60*60*7]];
        NSDate *CurrentDate = [dateFormatter1 dateFromString:convertedDateString];
        
        switch ([SaveDate compare:CurrentDate]){
            case NSOrderedAscending:
                NSLog(@"Current Date is bigger");
                NSLog(@"currentdate greater");
                [AttendenceIcon_Btn setImage:[UIImage imageNamed:@"attendence_empty.png"] forState:UIControlStateNormal];
                CheckAttendence=YES;
                
                break;
            case NSOrderedSame:
                
                NSLog(@"NSOrderedSame");
                [AttendenceIcon_Btn setImage:[UIImage imageNamed:@"attendence.png"] forState:UIControlStateNormal];
                CheckAttendence=NO;
                break;
            case NSOrderedDescending:
                NSLog(@"current date is less");
                break;
        }

    }
    else
    {
        [AttendenceIcon_Btn setImage:[UIImage imageNamed:@"attendence_empty.png"] forState:UIControlStateNormal];
        CheckAttendence=YES;
    }
    
    // Do any additional setup after loading the view.
}

- (IBAction)Home_Icon_Method:(id)sender
{
    UIButton *aButton = (UIButton *)sender;
    
    if (aButton.tag == 1)
    {
        // Attendance
        if (CheckAttendence==YES)
        {
            [self AddAttendence];
        }
        return;
    }
    if (CheckAttendence==YES)
    {
        [AppDelegate showErrorMessageWithTitle:@"" message:@"You have to submit your attendance before starting your work" delegate:nil];
    }
    else
    {
        if (aButton.tag == 2)
        {
            // Notification
            NotificationVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NotificationVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 3)
        {
            // Create Order
            CreateOrderVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateOrderVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 4)
        {
            // Order History
            OderHistryVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OderHistryVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 5)
        {
            // Customer
            CustomerDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomerDetailVW"];
            [self.navigationController pushViewController:vcr animated:YES];
            
        }
        else if (aButton.tag == 6)
        {
            // Create Inward order
            CreateInwardOrderVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateInwardOrderVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 7)
        {
            // Inward History
            InwardHistryVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InwardHistryVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 8)
        {
            // Stock
            StockVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StockVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 9)
        {
            // Create Dispatch
            CreateDispatchVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateDispatchVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 10)
        {
            // Dispatch History
            DispatchHistoryVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DispatchHistoryVW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 11)
        {
            // Profile Activity
            ProfileVIEW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileVIEW"];
            [self.navigationController pushViewController:vcr animated:YES];
        }
        else if (aButton.tag == 12)
        {
            // Logout
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Are you sure want to Logout?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Logout",nil];
            alert.tag=50;
            [alert show];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked Logout
    if (alertView.tag==50)
    {
        if (buttonIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LoginUserDic"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ATTENDENCE"];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    }
}

-(void)AddAttendence
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];

    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:add_attendance  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"sales_id"];
    
   
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleAttendenceResponse:response];
     }];
}
- (void)handleAttendenceResponse:(NSDictionary*)response
{
    NSDate *todayDate = [NSDate date]; //Get todays date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
    [dateFormatter setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
    NSLog(@"Today formatted date is %@",convertedDateString);
    
    [[NSUserDefaults standardUserDefaults] setObject:convertedDateString forKey:@"ATTENDENCE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Attendence insert Successfully.!" delegate:nil];
    [AttendenceIcon_Btn setImage:[UIImage imageNamed:@"attendence.png"] forState:UIControlStateNormal];
    CheckAttendence=NO;
    
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
       // [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
    else
    {
       // [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
#pragma mark - photoShotSavedDelegate

- (IBAction)MenuBtn_action:(id)sender
{
    [self.rootNav drawerToggle];
}
-(void)CCKFNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"CCKFNavDrawerSelection = %li", (long)selectionIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
