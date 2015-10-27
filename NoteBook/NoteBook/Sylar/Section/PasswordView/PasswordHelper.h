//
//  PasswordHelper.h
//  NoteBook
//
//  Created by Sylar on 3/25/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordHelper : NSObject

+ (BOOL) SetLoginPassword:(NSString *)_password;

+ (BOOL) CheckLoginPassword:(NSString *)_password;


@end
