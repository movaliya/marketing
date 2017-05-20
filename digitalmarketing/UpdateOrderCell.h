//
//  UpdateOrderCell.h
//  digitalmarketing
//
//  Created by kaushik on 20/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *ProductName;
@property (weak, nonatomic) IBOutlet UILabel *ProductPrice;
@property (weak, nonatomic) IBOutlet UITextField *ProductQTY;
@property (weak, nonatomic) IBOutlet UILabel *ProductAmount;

@end
