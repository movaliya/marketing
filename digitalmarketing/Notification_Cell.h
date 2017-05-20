//
//  Notification_Cell.h
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Notification_Cell : UITableViewCell
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
