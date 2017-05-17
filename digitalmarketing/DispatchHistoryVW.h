//
//  DispatchHistoryVW.h
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DispatchHistoryVW : UIViewController
{
    NSMutableDictionary *DispatchHistyDict;
}
@property (weak, nonatomic) IBOutlet UITableView *DispatchHstyTLB;

@end
