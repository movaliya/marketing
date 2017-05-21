//
//  SerachProductVW.h
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SerachProductVWDelegate <NSObject>
-(void)ChkProductValue:(NSMutableArray *)ProductDict;

@end
@interface SerachProductVW : UIViewController
{
    NSMutableDictionary *ProductDict;
    NSMutableDictionary *Searchdic;
    NSMutableArray *WithSelectArr;
    NSMutableArray *withSelectMain;


}
@property (strong, nonatomic) NSString *CheckDispatch;
@property (strong, nonatomic) NSString *DispatchCutomerID;

@property (nonatomic, retain) id <SerachProductVWDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *ProductTable;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBR;
@property (weak, nonatomic) IBOutlet UIView *SearchBackView;

@end
