//
//  CommonActionSheet.h
//  testcollectionview
//
//  Created by Sylar on 3/28/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SelectedIndex)(int index);

@interface CommonActionSheet : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *destructiveButtonTitle;
@property (nonatomic, strong) NSArray  *otherButtonTitles;
@property (nonatomic, strong) UIView   *showInView;

+ (id) Create;

- (void) ShowWithSelectedIndex:(SelectedIndex)_block;

- (void) ShowInView:(UIView *)_view SelectedIndex:(SelectedIndex)_block;


@end
