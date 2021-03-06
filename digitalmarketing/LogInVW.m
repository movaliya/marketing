//
//  LogInVW.m
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "LogInVW.h"
#import "ForgotPassVW.h"
#import "digitalMarketing.pch"
#import "HomeVW.h"

@interface LogInVW ()

@end

@implementation LogInVW
@synthesize UserName_TXT,Password_TXT,LoginBtn;
@synthesize usernm_View,password_View;


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [usernm_View.layer setCornerRadius:3.0f];
    usernm_View.layer.borderWidth = 1.0f;
    [usernm_View.layer setMasksToBounds:YES];
    usernm_View.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [password_View.layer setCornerRadius:3.0f];
    password_View.layer.borderWidth = 1.0f;
    [password_View.layer setMasksToBounds:YES];
    password_View.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [LoginBtn.layer setCornerRadius:3.0f];
    LoginBtn.layer.borderWidth = 1.0f;
    [LoginBtn.layer setMasksToBounds:YES];
    LoginBtn.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    

    //Auto Login
    if ([KmyappDelegate isUserLoggedIn] == YES)
    {
        HomeVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeVW"];
        [self.navigationController pushViewController:vcr animated:NO];
    }
    
   

    // Do any additional setup after loading the view.
}
- (IBAction)LogIn_Btn_Action:(id)sender
{
    if ([UserName_TXT.text isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter username" delegate:nil];
    }
    else
    {
       
        if ([Password_TXT.text isEqualToString:@""])
        {
            [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter password" delegate:nil];
        }
        else
        {
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
                [self CallForloging];
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        }
    }
}

-(void)CallForloging
{
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:user_login  forKey:@"s"];
    [dictParams setObject:UserName_TXT.text  forKey:@"username"];
    [dictParams setObject:Password_TXT.text  forKey:@"password"];
    [dictParams setObject:@"IOS"  forKey:@"imei"];
    [dictParams setObject:@"fksdfns7f6dsbfds7fs"  forKey:@"refreshToken"];
    
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleResponse:response];
     }];
}
- (void)handleResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        
        NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];
        dic=[[response valueForKey:@"result"] mutableCopy];
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"LoginUserDic"];
        
        UserName_TXT.text=@"";
        Password_TXT.text=@"";
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        
        HomeVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeVW"];
        [self.navigationController pushViewController:vcr animated:YES];
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (IBAction)ForgotPasswrdBtn_Action:(id)sender
{
    ForgotPassVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgotPassVW"];
    [self.navigationController pushViewController:vcr animated:YES];
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
