//
//  Stock_Cell.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Stock_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ProductName;
@property (weak, nonatomic) IBOutlet UILabel *StockQTY_lbl;
@property (weak, nonatomic) IBOutlet UILabel *PendingQTY_lbl;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (strong, nonatomic) IBOutlet UIButton *btnShowHide;

@end
