//
//  SettingFontSizeDetailCell.m
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////
#import "SettingFontSizeDetailCell.h"
////////////////////////////////////////////////////////////
@interface SettingFontSizeDetailCell()
{
    IBOutlet UILabel      *m_title;
    IBOutlet UIImageView  *m_tick;
}
@end
////////////////////////////////////////////////////////////
@implementation SettingFontSizeDetailCell

+ (NSString *) GetCellId
{
    NSString *rt = @"SettingFontSizeDetailCell_id";
    return rt;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) SetWithTitle:(NSString *)pTitle
{
    // label
    m_title.text = pTitle;
    
    // image
    m_tick.hidden = YES;
}

- (void) SetTicked:(BOOL)tick
{
    m_tick.hidden = !tick;
}

@end
