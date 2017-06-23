//
//  CreateDispatchVW.h
//  digitalmarketing
//
//  Created by Mango SW on 18/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"

@interface CreateDispatchVW : UIViewController
{
    NSMutableDictionary *customerDict,*storeDict;
    NSMutableArray *ProductArry;

    NSString *CutomerID;
    NSString *StoreID;
    NSInteger totalAmount;
    NSInteger GrandAmount;
    NSInteger totalQTY;
    NSString *ProductJSONString;
    BOOL CheckSUCCESS;
    BOOL CheckStoreServiceBOOL;
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@property (weak, nonatomic) IBOutlet UIButton *SelectStore_BTN;
@property (weak, nonatomic) IBOutlet UIView *Store_PopupView;
@property (weak, nonatomic) IBOutlet UITableView *StoreTBL;
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
@property (weak, nonatomic) IBOutlet UIView *AddMorDetail_view;
@property (weak, nonatomic) IBOutlet UIView *SelectDateView;
@property (weak, nonatomic) IBOutlet UITextField *SelectDate_TXT;
@property (weak, nonatomic) IBOutlet UIView *LRNumber_View;
@property (weak, nonatomic) IBOutlet UITextField *LrNumber_TXT;
@property (weak, nonatomic) IBOutlet UIView *Remark_view;
@property (weak, nonatomic) IBOutlet UITextView *Remark_TextView;
@property (weak, nonatomic) IBOutlet UIButton *MoreDetail_OK_Btn;
@property (weak, nonatomic) IBOutlet UIButton *MoreDetail_Cancel_Btn;
@property (weak, nonatomic) IBOutlet UIView *MoreDetail_MainView;

@end
