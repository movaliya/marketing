//
//  DispatchHSTY_CELL.m
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "DispatchHSTY_CELL.h"

@implementation DispatchHSTY_CELL
@synthesize BackView;
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [BackView.layer setCornerRadius:3.0f];
    BackView.layer.borderWidth = 1.0f;
    [BackView.layer setMasksToBounds:YES];
    BackView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    BackView.layer.masksToBounds = NO;
    [BackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [BackView.layer setShadowOpacity:0.8];
    [BackView.layer setShadowRadius:2.0];
    [BackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
