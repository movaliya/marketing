//
//  CreateInwardOrderVW.h
//  digitalmarketing
//
//  Created by Mango SW on 18/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"

@interface CreateInwardOrderVW : UIViewController
{
    NSDictionary *customerDict,*storeDict;
    NSMutableArray *ProductArry;
    NSString *CutomerID;
    
    NSInteger totalAmount;
    NSInteger totalQTY;
    NSString *ProductJSONString;
    BOOL CheckSUCCESS;
     BOOL CheckSTORELOAD;
    NSString *StoreID;
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@property (weak, nonatomic) IBOutlet UIButton *SelectStore_BTN;
@property (weak, nonatomic) IBOutlet UITableView *Store_TBL;
@property (weak, nonatomic) IBOutlet UIView *Store_PopUp_View;
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

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleHight;

@end
