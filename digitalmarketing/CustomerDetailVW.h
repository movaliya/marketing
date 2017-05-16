//
//  CustomerDetailVW.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDetailVW : UIViewController
{
    NSDictionary *customerDict;
}
@property (weak, nonatomic) IBOutlet UISearchBar *serachBar;
@property (weak, nonatomic) IBOutlet UIView *SearchBackView;
@property (weak, nonatomic) IBOutlet UITableView *CustomerTable;

@end
