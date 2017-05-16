//
//  OrderHistry_Cell.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "OrderHistry_Cell.h"

@implementation OrderHistry_Cell
@synthesize BackView,Back_View;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [Back_View.layer setCornerRadius:3.0f];
    Back_View.layer.borderWidth = 1.0f;
    [Back_View.layer setMasksToBounds:YES];
    Back_View.layer.borderColor = [UIColor whiteColor].CGColor;
    
    Back_View.layer.masksToBounds = NO;
    [Back_View.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [Back_View.layer setShadowOpacity:0.8];
    [Back_View.layer setShadowRadius:2.0];
    [Back_View.layer setShadowOffset:CGSizeMake(0.3,0.3)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
