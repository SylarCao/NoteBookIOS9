//
//  SettingHelper.h
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
////////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSInteger, enSettingFontSize)
{
    en_setting_font_size_small = 14,
    en_setting_font_size_middle = 18,
    en_setting_font_size_big = 22,
};
////////////////////////////////////////////////////////////////////////////
@interface SettingHelper : NSObject

+ (id) Share;

- (void) SetPasswordOnOff:(BOOL)onOff;

- (BOOL) checkNeedPresentPasswordView;

- (BOOL) CheckPasswordOn;

- (void) SetFontSize:(enSettingFontSize)fontSize;

- (enSettingFontSize) GetFontSize;

- (void) SynchronizePasswordTime;

@end
