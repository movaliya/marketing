//
//  Stock_Cell.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "Stock_Cell.h"

@implementation Stock_Cell
@synthesize BackView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    BackView.layer.borderWidth = 1.0f;
    [BackView.layer setMasksToBounds:YES];
    BackView.layer.borderColor = [UIColor colorWithRed:(132/255.0) green:(132/255.0) blue:(132/255.0) alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
