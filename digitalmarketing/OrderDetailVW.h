//
//  OrderDetailVW.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailVW : UIViewController
{
    NSDictionary *OrderDetailDict,*OrderProductDict;
}
@property (weak, nonatomic) IBOutlet UIButton *EditIcon_BTN;

@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *CheckNotificationView;
@property (weak, nonatomic) IBOutlet UIView *DetailBackView;
@property (weak, nonatomic) IBOutlet UIView *TitleBackView;
@property (weak, nonatomic) IBOutlet UITableView *OrderDetailTable;

@property (weak, nonatomic) IBOutlet UILabel *CutomerName;
@property (weak, nonatomic) IBOutlet UILabel *OrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *OrderNamuber;
@property (weak, nonatomic) IBOutlet UILabel *OrderDate;
@property (weak, nonatomic) IBOutlet UILabel *TotalQTY;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *Discount;
@property (weak, nonatomic) IBOutlet UILabel *GrandTotal;

@end
