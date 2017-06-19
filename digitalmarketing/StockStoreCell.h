//
//  StockStoreCell.h
//  ExpandableTableView
//
//  Created by kaushik on 18/06/17.
//  Copyright © 2017 apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockStoreCell : UITableViewCell
{
    
}

@property (strong, nonatomic) IBOutlet UILabel *StoreName_LBL;
@property (strong, nonatomic) IBOutlet UILabel *StoreQnt_LBL;
@property (strong, nonatomic) IBOutlet UILabel *PandingQnt_LBL;

@end
