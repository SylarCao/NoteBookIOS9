//
//  SettingPasswordCell.h
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@interface SettingPasswordCell : UITableViewCell

@property (nonatomic, weak) SettingViewController *parentViewcontroller;

+ (NSString *) GetCellId;

@end
