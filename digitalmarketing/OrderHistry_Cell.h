//
//  OrderHistry_Cell.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHistry_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *Back_View;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *Customer_name;
@property (weak, nonatomic) IBOutlet UILabel *Order_Number;
@property (weak, nonatomic) IBOutlet UILabel *Order_date;
@property (weak, nonatomic) IBOutlet UILabel *TotalQTY;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *Discount;
@property (weak, nonatomic) IBOutlet UILabel *GrandTotal;
@property (weak, nonatomic) IBOutlet UILabel *OderStatus;

@end
