//
//  UpdateDispatchVw.h
//  digitalmarketing
//
//  Created by kaushik on 21/05/17.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateDispatchVw : UIViewController
{
    NSMutableDictionary *customerDict;
    NSMutableArray *ProductArry;
    
    NSString *CutomerID;
    NSString *Dispatch_ID;
    NSInteger totalAmount;
    NSInteger totalQTY;
    NSString *ProductJSONString;
    BOOL CheckSUCCESS;
}
@property (strong, nonatomic) NSMutableDictionary *DispatchDetailDICTPass;

@property (weak, nonatomic) IBOutlet UIView *PopUpCustomerVW;
@property (weak, nonatomic) IBOutlet UIView *CustomerVIEW;
@property (weak, nonatomic) IBOutlet UIView *SearchProBackView;
@property (weak, nonatomic) IBOutlet UIView *ProductTitleBackView;
@property (weak, nonatomic) IBOutlet UITableView *CustomerTBL;
@property (weak, nonatomic) IBOutlet UITableView *ProductTBL;
@property (weak, nonatomic) IBOutlet UILabel *TotalQTY_LBL;
@property (weak, nonatomic) IBOutlet UILabel *GrantTotal_LBL;

@property (weak, nonatomic) IBOutlet UIButton *selectCutomer_BTN;
@property (weak, nonatomic) IBOutlet UILabel *CutomerNameLBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerAdressLBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerStateCityLBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerPhoneLBL;
@property (weak, nonatomic) IBOutlet UIButton *CreateDispatch_Btn;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleTop4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TitleHight;

@end
