//
//  HomeVW.h
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "digitalMarketing.pch"

@interface HomeVW : UIViewController<CCKFNavDrawerDelegate>
{
    BOOL CheckAttendence;
}
@property (weak, nonatomic) IBOutlet UIButton *AttendenceIcon_Btn;
@property (strong, nonatomic) IBOutlet UIScrollView *HomeScroll;

@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@end
