//
//  InwardHitry_CELL.h
//  digitalmarketing
//
//  Created by Mango SW on 18/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InwardHitry_CELL : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *CutomerName;
@property (weak, nonatomic) IBOutlet UILabel *OrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *OrderDate;
@property (weak, nonatomic) IBOutlet UILabel *TotalQTY;
@property (weak, nonatomic) IBOutlet UILabel *GrandTotal;
@property (weak, nonatomic) IBOutlet UILabel *store_Name;

@end
