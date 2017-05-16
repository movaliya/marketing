//
//  Customer_Cell.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Customer_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UIButton *Email_Btn;
@property (weak, nonatomic) IBOutlet UIButton *Call_Btn;
@property (weak, nonatomic) IBOutlet UILabel *CustomerName;
@property (weak, nonatomic) IBOutlet UILabel *Customer_ID;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UILabel *Customer_StateCnty;
@property (weak, nonatomic) IBOutlet UILabel *MobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *ResigterDate;

@end
