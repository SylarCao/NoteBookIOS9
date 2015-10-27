//
//  MenuTableViewCell.m
//  NoteBook
//
//  Created by Sylar on 3/31/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
//////////////////////////////////////////////////////////////////
#import "MenuTableViewCell.h"
#import "CommonTools.h"
//////////////////////////////////////////////////////////////////
@interface MenuTableViewCell()
{
    UILabel      *m_label;
    UIImageView  *m_arrow;
}
@end
//////////////////////////////////////////////////////////////////
@implementation MenuTableViewCell

+ (NSString *) GetCellId
{
    NSString *rt = @"MenuTableViewCell_id";
    return rt;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self SetInitialValue];
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    m_arrow.highlighted = highlighted;
}

- (void) SetInitialValue
{
    CGRect content_size = self.contentView.bounds;
    
    // label
    m_label = [[UILabel alloc] init];
    m_label.frame = CGRectMake(20, 0, content_size.size.width, content_size.size.height);
    m_label.text = @"label";
    [self.contentView addSubview:m_label];
    
    // uiimage
    UIImage *normal = [UIImage imageNamed:@"right_arrow"];
    UIImage *HL     = [UIImage imageNamed:@"right_arrow_HL"];
    m_arrow = [[UIImageView alloc] initWithImage:normal highlightedImage:HL];
    float right_edge = 20;
    
    m_arrow.frame = CGRectMake(content_size.size.width-normal.size.width-right_edge, (content_size.size.height-normal.size.height)/2, normal.size.width, normal.size.height);
    [self.contentView addSubview:m_arrow];
}

- (void) SetWithTitle:(NSString *)_labelTitle
{
    m_label.text = _labelTitle;
}

@end
