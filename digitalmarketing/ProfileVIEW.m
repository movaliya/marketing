//
//  ProfileVIEW.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "ProfileVIEW.h"
#import "digitalMarketing.pch"
@interface ProfileVIEW ()

@end

@implementation ProfileVIEW
@synthesize Username_TXT,Email_TXT,PhoneNo_TXT,OldPass_TXT,NewPass_TXT,RetypePass_TXT;
@synthesize username_VIEW,Email_VIEW,Phone_VIEW,oldPass_VIEW,NewPass_VIEW,RetypePass_VIEW,ChangePass_BTN;
@synthesize Info_View,Password_View;

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Info_View.layer setShadowColor:[UIColor blackColor].CGColor];
    [Info_View.layer setShadowOpacity:0.8];
    [Info_View.layer setShadowRadius:2.0];
    [Info_View.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    [Password_View.layer setShadowColor:[UIColor blackColor].CGColor];
    [Password_View.layer setShadowOpacity:0.8];
    [Password_View.layer setShadowRadius:2.0];
    [Password_View.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    
    [username_VIEW.layer setCornerRadius:3.0f];
    username_VIEW.layer.borderWidth = 1.0f;
    [username_VIEW.layer setMasksToBounds:YES];
    username_VIEW.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [Email_VIEW.layer setCornerRadius:3.0f];
    Email_VIEW.layer.borderWidth = 1.0f;
    [Email_VIEW.layer setMasksToBounds:YES];
    Email_VIEW.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [Phone_VIEW.layer setCornerRadius:3.0f];
    Phone_VIEW.layer.borderWidth = 1.0f;
    [Phone_VIEW.layer setMasksToBounds:YES];
    Phone_VIEW.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [oldPass_VIEW.layer setCornerRadius:3.0f];
    oldPass_VIEW.layer.borderWidth = 1.0f;
    [oldPass_VIEW.layer setMasksToBounds:YES];
    oldPass_VIEW.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [NewPass_VIEW.layer setCornerRadius:3.0f];
    NewPass_VIEW.layer.borderWidth = 1.0f;
    [NewPass_VIEW.layer setMasksToBounds:YES];
    NewPass_VIEW.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [RetypePass_VIEW.layer setCornerRadius:3.0f];
    RetypePass_VIEW.layer.borderWidth = 1.0f;
    [RetypePass_VIEW.layer setMasksToBounds:YES];
    RetypePass_VIEW.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    [ChangePass_BTN.layer setCornerRadius:3.0f];
    ChangePass_BTN.layer.borderWidth = 1.0f;
    [ChangePass_BTN.layer setMasksToBounds:YES];
    ChangePass_BTN.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;
    
    
    Username_TXT.enabled=NO;
    Email_TXT.enabled=NO;
    PhoneNo_TXT.enabled=NO;
    
    if ([KmyappDelegate isUserLoggedIn] == YES)
    {
        NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
        if ([UserSaveData valueForKey:@"username"] != (id)[NSNull null])
        {
            Username_TXT.text=[UserSaveData valueForKey:@"username"];
        }
        if ([UserSaveData valueForKey:@"email"] != (id)[NSNull null])
        {
            Email_TXT.text=[UserSaveData valueForKey:@"email"];
        }
        if ([UserSaveData valueForKey:@"phone"] != (id)[NSNull null])
        {
            PhoneNo_TXT.text=[UserSaveData valueForKey:@"phone"];
        }
    }
    
}
- (IBAction)ChangePassword_Action:(id)sender
{
    if ([OldPass_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Old Password" delegate:nil];
    }
    else if ([NewPass_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter New Password" delegate:nil];
    }
    else if ([RetypePass_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Confirm Password" delegate:nil];
    }
    else
    {
        if([NewPass_TXT.text isEqualToString:RetypePass_TXT.text])
        {
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
            {
                [self updatePassword];
            }
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
            
            
        }
        else
        {
            [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"New Password and Re-Type New Password are not the same!" delegate:nil];
        }
    }
}
-(void)updatePassword
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:user_change_password  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"id"];
    [dictParams setObject:OldPass_TXT.text  forKey:@"password"];
    [dictParams setObject:NewPass_TXT.text  forKey:@"new_password"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleUpdatePasswordResponse:response];
     }];
}

- (void)handleUpdatePasswordResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        OldPass_TXT.text=@"";
        NewPass_TXT.text=@"";
        RetypePass_TXT.text=@"";
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        OldPass_TXT.text=@"";
        NewPass_TXT.text=@"";
        RetypePass_TXT.text=@"";
        
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}


- (IBAction)BackBtn_action:(id)sender
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
