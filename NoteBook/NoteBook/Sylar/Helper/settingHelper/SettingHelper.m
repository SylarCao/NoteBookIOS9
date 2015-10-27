//
//  SettingHelper.m
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////
#import "SettingHelper.h"
///////////////////////////////////////////////////////////////
# define kSettingKeyAll                 @"kSettingKey"
# define kSettingKeyPassword            @"kSettingKeyPassword" // 1->on 0->off
# define kSettingKeyFontSize            @"kSettingKeyFontSize"
# define kSettingKeyPasswordLastTime    @"kSettingKeyPasswordLastTime"
///////////////////////////////////////////////////////////////
const NSInteger c_password_time_delta = 60; // 1 min
///////////////////////////////////////////////////////////////
@interface SettingHelper()
{
    NSMutableDictionary *m_setting;
}
@end
///////////////////////////////////////////////////////////////
@implementation SettingHelper

+ (id) Share
{
    static SettingHelper *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SettingHelper alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        m_setting = [[[NSUserDefaults standardUserDefaults] objectForKey:kSettingKeyAll] mutableCopy];
        if (m_setting == nil)
        {
            NSString *font_size = [NSString stringWithFormat:@"%d", en_setting_font_size_middle];
            m_setting = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                         @"0",      kSettingKeyPassword,
                         font_size, kSettingKeyFontSize,
                         nil];
            [[NSUserDefaults standardUserDefaults] setObject:m_setting forKey:kSettingKeyAll];
        }
    }
    return self;
}

- (void) SetPasswordOnOff:(BOOL)onOff
{
    NSString *on_off = [NSString stringWithFormat:@"%d", onOff];
    [m_setting setObject:on_off forKey:kSettingKeyPassword];
    [self Synchronize];
}

- (BOOL) checkNeedPresentPasswordView
{
    BOOL rt = [self CheckPasswordOn];
    if (rt)
    {
        // check time
        NSInteger time0 = [[NSDate date] timeIntervalSince1970];
        NSInteger time0_saved = [[m_setting objectForKey:kSettingKeyPasswordLastTime] integerValue];
        NSInteger delta = ABS(time0 - time0_saved);
        if (delta < c_password_time_delta)
        {
            rt = NO;
        }
    }
    return rt;
}

- (BOOL) CheckPasswordOn
{
    BOOL rt = NO;
    NSString *on_off = [m_setting objectForKey:kSettingKeyPassword];
    if (on_off)
    {
        rt = [on_off intValue];
    }
    return rt;
}

- (void) SetFontSize:(enSettingFontSize)fontSize
{
    NSString *font_size = [NSString stringWithFormat:@"%d", fontSize];
    [m_setting setObject:font_size forKey:kSettingKeyFontSize];
    [self Synchronize];
}

- (enSettingFontSize) GetFontSize
{
    enSettingFontSize rt = en_setting_font_size_middle;
    NSString *font_size = [m_setting objectForKey:kSettingKeyFontSize];
    if (font_size)
    {
        rt = [font_size intValue];
    }
    return rt;
}

- (void) SynchronizePasswordTime
{
    if ([self CheckPasswordOn])
    {
        NSInteger time0 = [[NSDate date] timeIntervalSince1970];
        NSString *str_time0 = [NSString stringWithFormat:@"%d", time0];
        [m_setting setObject:str_time0 forKey:kSettingKeyPasswordLastTime];
        [self Synchronize];
    }
}

- (void) Synchronize
{
    [[NSUserDefaults standardUserDefaults] setObject:m_setting forKey:kSettingKeyAll];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
