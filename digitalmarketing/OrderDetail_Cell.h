//
//  OrderDetail_Cell.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetail_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *ProductName;
@property (weak, nonatomic) IBOutlet UILabel *ProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *ProductQTY;
@property (weak, nonatomic) IBOutlet UILabel *ProductAmount;

@end
