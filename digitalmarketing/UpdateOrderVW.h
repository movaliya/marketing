//
//  UpdateOrderVW.h
//  digitalmarketing
//
//  Created by kaushik on 20/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateOrderVW : UIViewController
{
    NSDictionary *customerDict;
    NSMutableArray *ProductArry;
    NSString *CutomerID;
    
    NSInteger totalAmount;
    NSInteger DiscoutINT;
    NSInteger GrandAmount;
    NSInteger totalQTY;
    NSString *ProductJSON;
    NSString *ProductJSONString;
    
    NSMutableDictionary *ProductDictPass;

}

@property (strong, nonatomic) NSMutableDictionary *OrderDetailDICTPass;

@property (weak, nonatomic) IBOutlet UIButton *SelectCutomer_Button;
@property (weak, nonatomic) IBOutlet UIView *SelectCustomerBackView;
@property (weak, nonatomic) IBOutlet UIView *SearchProBackView;
@property (weak, nonatomic) IBOutlet UIView *ProductTitleBackView;
@property (weak, nonatomic) IBOutlet UIButton *CreateOrderBtn;
@property (weak, nonatomic) IBOutlet UITableView *CustomerTBL;
@property (weak, nonatomic) IBOutlet UIView *CutomerView;
@property (weak, nonatomic) IBOutlet UITableView *ProductTBL;
@property (weak, nonatomic) IBOutlet UILabel *TotalQTY_LBL;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmount_LBL;
@property (weak, nonatomic) IBOutlet UILabel *GrantTotal_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Discount_LBL;
@property (weak, nonatomic) IBOutlet UILabel *CutomerNameLBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerAdressLBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerStateCityLBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerPhoneLBL;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleHight;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop4;

- (IBAction)Discount_Click:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *DiscountView;
@property (strong, nonatomic) IBOutlet UILabel *Qty_LBL;
@property (strong, nonatomic) IBOutlet UILabel *Amount_LBL;
@property (strong, nonatomic) IBOutlet UITextField *Discount_TXT;
@property (strong, nonatomic) IBOutlet UILabel *DiscountGrandTotal_LBL;
- (IBAction)DiscountOK_Click:(id)sender;
- (IBAction)DiscountCancle_Click:(id)sender;



@end
