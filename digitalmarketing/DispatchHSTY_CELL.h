//
//  DispatchHSTY_CELL.h
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DispatchHSTY_CELL : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *CutomerName;
@property (weak, nonatomic) IBOutlet UILabel *OrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *OrderDate;
@property (weak, nonatomic) IBOutlet UILabel *LRNumber;
@property (weak, nonatomic) IBOutlet UILabel *Remarks;
@property (weak, nonatomic) IBOutlet UILabel *TotalQTY;
@property (weak, nonatomic) IBOutlet UILabel *GrandTotal;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LRNumberHight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *RemarkHight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LRNoTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *RemarkTop;
@end
