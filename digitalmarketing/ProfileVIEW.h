//
//  ProfileVIEW.h
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVIEW : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Username_TXT;
@property (weak, nonatomic) IBOutlet UITextField *Email_TXT;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNo_TXT;
@property (weak, nonatomic) IBOutlet UITextField *OldPass_TXT;
@property (weak, nonatomic) IBOutlet UITextField *NewPass_TXT;
@property (weak, nonatomic) IBOutlet UITextField *RetypePass_TXT;
@property (weak, nonatomic) IBOutlet UIButton *ChangePass_BTN;

@property (weak, nonatomic) IBOutlet UIView *username_VIEW;

@property (weak, nonatomic) IBOutlet UIView *Email_VIEW;
@property (weak, nonatomic) IBOutlet UIView *Phone_VIEW;
@property (weak, nonatomic) IBOutlet UIView *oldPass_VIEW;
@property (weak, nonatomic) IBOutlet UIView *NewPass_VIEW;
@property (weak, nonatomic) IBOutlet UIView *RetypePass_VIEW;
@property (weak, nonatomic) IBOutlet UIView *Info_View;
@property (weak, nonatomic) IBOutlet UIView *Password_View;

@end
