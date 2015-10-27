//
//  SettingFontSizeDetailCell.h
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingFontSizeDetailCell : UITableViewCell

+ (NSString *) GetCellId;

- (void) SetWithTitle:(NSString *)pTitle;

- (void) SetTicked:(BOOL)tick;


@end
