//
//  CommonActionSheet.m
//  testcollectionview
//
//  Created by Sylar on 3/28/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////
#import "CommonActionSheet.h"
#import "LXActionSheet.h"
///////////////////////////////////////////////////////////////
@interface CommonActionSheet()
<LXActionSheetDelegate>

@property (nonatomic, strong) SelectedIndex selectIndex;

@end
///////////////////////////////////////////////////////////////
@implementation CommonActionSheet

+ (id) Create
{
    static CommonActionSheet *single = nil;
    single = [[CommonActionSheet alloc] init];
    return single;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _title = @"title";
        _cancelButtonTitle = @"cancel";
        _destructiveButtonTitle = @"ok";
    }
    return self;
}

- (void) ShowWithSelectedIndex:(SelectedIndex)_block
{
    [self ShowInView:_showInView SelectedIndex:_block];
}

- (void) ShowInView:(UIView *)_view SelectedIndex:(SelectedIndex)_block
{
    LXActionSheet *lx = [[LXActionSheet alloc] initWithTitle:_title delegate:self cancelButtonTitle:_cancelButtonTitle destructiveButtonTitle:_destructiveButtonTitle otherButtonTitles:_otherButtonTitles];
    _selectIndex = _block;
    [lx showInView:_view];
}

- (void)didClickOnButtonIndex:(NSInteger)buttonIndex
{
    self.selectIndex(buttonIndex);
}

@end
