//
//  Customer_Cell.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "Customer_Cell.h"

@implementation Customer_Cell
@synthesize BackView,Email_Btn,Call_Btn;
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [BackView.layer setCornerRadius:3.0f];
    BackView.layer.borderWidth = 1.0f;
    [BackView.layer setMasksToBounds:YES];
    BackView.layer.borderColor = [UIColor clearColor].CGColor;
    
    BackView.layer.masksToBounds = NO;
    [BackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [BackView.layer setShadowOpacity:0.8];
    [BackView.layer setShadowRadius:2.0];
    [BackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    [Email_Btn.layer setCornerRadius:5.0f];
    Email_Btn.layer.borderWidth = 1.0f;
    [Email_Btn.layer setMasksToBounds:YES];
    Email_Btn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [Call_Btn.layer setCornerRadius:5.0f];
    Call_Btn.layer.borderWidth = 1.0f;
    [Call_Btn.layer setMasksToBounds:YES];
    Call_Btn.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
