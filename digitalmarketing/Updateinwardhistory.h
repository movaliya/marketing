//
//  Updateinwardhistory.h
//  digitalmarketing
//
//  Created by kaushik on 21/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Updateinwardhistory : UIViewController
{
    NSDictionary *OrderDetailDict,*OrderProductDict;

}

@property (strong, nonatomic) NSString *inward_id;

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
