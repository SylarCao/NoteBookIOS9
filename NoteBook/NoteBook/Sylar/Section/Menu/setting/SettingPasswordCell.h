//
//  SettingPasswordCell.h
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "SettingViewController.h"
////////////////////////////////////////////////////////////
typedef NS_ENUM(NSUInteger, enPasswordType) {
    en_passowrd_type_9_point,
    en_passowrd_type_touch_id,
};
////////////////////////////////////////////////////////////
@interface SettingPasswordCell : UITableViewCell

@property (nonatomic, weak) SettingViewController *parentViewcontroller;

+ (NSString *) GetCellId;

/**
 *  设置密码格式，touch id or 九宫格
 *
 *  @param type <#type description#>
 */
- (void) setWithPassowrdType:(enPasswordType)type;

@end
////////////////////////////////////////////////////////////