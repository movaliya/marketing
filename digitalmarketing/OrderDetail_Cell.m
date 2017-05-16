//
//  OrderDetail_Cell.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "OrderDetail_Cell.h"


@implementation OrderDetail_Cell
@synthesize BackView;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    BackView.layer.borderWidth = 1.0f;
    [BackView.layer setMasksToBounds:YES];
    BackView.layer.borderColor = [UIColor grayColor].CGColor;
    
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
