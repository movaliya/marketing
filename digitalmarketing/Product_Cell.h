//
//  Product_Cell.h
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ProductNameLBL;
@property (weak, nonatomic) IBOutlet UILabel *PriceLBL;
@property (weak, nonatomic) IBOutlet UIButton *CheckBoxBtn;

@end
