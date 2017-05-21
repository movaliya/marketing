//
//  UpdateInwardCell.h
//  digitalmarketing
//
//  Created by kaushik on 21/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateInwardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *ProductName;
@property (weak, nonatomic) IBOutlet UITextField *ProductPrice;
@property (weak, nonatomic) IBOutlet UITextField *ProductQTY;
@property (weak, nonatomic) IBOutlet UILabel *ProductAmount;
@property (strong, nonatomic) IBOutlet UILabel *PriceLine_LBL;
@property (strong, nonatomic) IBOutlet UILabel *QntLine_LBL;
@end
