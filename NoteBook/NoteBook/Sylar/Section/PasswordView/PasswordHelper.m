//
//  PasswordHelper.m
//  NoteBook
//
//  Created by Sylar on 3/25/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////
#import "PasswordHelper.h"
#import "AESCrypt.h"
////////////////////////////////////////////////////////////////////////
# define kLoginAESPassword  @"920ElW6Fs92ZVJ0Q"
# define kLoginPlistKey     @"2ijeI8t"
////////////////////////////////////////////////////////////////////////
@implementation PasswordHelper

+ (BOOL) SetLoginPassword:(NSString *)_password
{
    NSString* ss = [AESCrypt encrypt:_password password:kLoginAESPassword];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:ss forKey:kLoginPlistKey];
    BOOL rt = [def synchronize];
    return rt;
}

+ (BOOL) CheckLoginPassword:(NSString *)_password
{
    NSString* old_password = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginPlistKey];
    old_password = [AESCrypt decrypt:old_password password:kLoginAESPassword];
    BOOL rt = YES;
    if (old_password.length > 1)
    {
        rt = [_password isEqualToString:old_password];
    }
    return rt;
}

@end
