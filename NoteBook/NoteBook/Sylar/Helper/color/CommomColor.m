//
//  CommomColor.m
//  NoteBook
//
//  Created by Sylar on 3/11/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////////////////
#import "CommomColor.h"
/////////////////////////////////////////////////////////////////////
@interface CommomColor()

@property (nonatomic, strong) UIColor *p_bkg_color;
@property (nonatomic, strong) UIColor *p_border_color;
@property (nonatomic, strong) UIColor *p_button_border_color;

@end
/////////////////////////////////////////////////////////////////////
@implementation CommomColor

+ (instancetype) Share
{
    static CommomColor* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CommomColor alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        [self SetColor:nil];
    }
    return self;
}

- (void) SetColor:(NSString*)_colorValue
{
    if ([_colorValue isEqualToString:@"someValue"])
    {
        
    }
    else
    {
        // default
        self.p_bkg_color = [UIColor lightGrayColor];
        self.p_border_color = [UIColor blackColor];
        self.p_button_border_color = [UIColor blueColor];
    }
}

+ (UIColor *) GetBkgColor
{
    return [CommomColor Share].p_bkg_color;
}

+ (UIColor *) GetBorderColor
{
    return [CommomColor Share].p_border_color;
}

+ (UIColor *) GetButtonBorderColor
{
    return [CommomColor Share].p_button_border_color;
}


@end
