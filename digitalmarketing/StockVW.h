//
//  StockVW.h
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockVW : UIViewController
{
    NSMutableDictionary *StockDict;
    NSMutableDictionary *Searchdic;
}
@property (weak, nonatomic) IBOutlet UIView *SearchBackView;
@property (weak, nonatomic) IBOutlet UIView *TitleBack_View;
@property (weak, nonatomic) IBOutlet UITableView *StockTable;
@property (weak, nonatomic) IBOutlet UISearchBar *SerachBar;

@end
