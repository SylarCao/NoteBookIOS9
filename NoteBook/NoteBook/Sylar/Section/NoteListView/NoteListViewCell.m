//
//  NoteListViewCell.m
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
//////////////////////////////////////////////////////
#import "NoteListViewCell.h"
#import "ItemModel.h"
#import "NoteListViewController.h"
//////////////////////////////////////////////////////
# define kNoteListWobbleEdge 5
//////////////////////////////////////////////////////
@interface NoteListViewCell()
{
    UILabel      *m_title;
    UIButton     *m_close;
    UIImageView  *m_bkg;
}
@end
//////////////////////////////////////////////////////
@implementation NoteListViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self SetInitialValue];
    }
    return self;
}

+ (NSString *) GetCellId
{
    NSString *rt = @"c_note_list_view_cell_id";
    return rt;
}

- (void) SetLabelFontSize:(int)_fontSize
{
    m_title.font = [UIFont systemFontOfSize:_fontSize];
}

- (void) setData:(ItemModel *)data
{
    _data = data;
    [self SetWithTitle:data.title];
}

- (void) SetInitialValue
{
    CGRect content_bounds = self.contentView.bounds;
    // bkg image
    m_bkg = [[UIImageView alloc] init];
    m_bkg.frame = content_bounds;
    m_bkg.image = [UIImage imageNamed:@"note_cell_bkg"];
    [self.contentView addSubview:m_bkg];
    
    // label
    m_title = [[UILabel alloc] init];
    m_title.frame = CGRectMake(kNoteListWobbleEdge, kNoteListWobbleEdge, content_bounds.size.width-2*kNoteListWobbleEdge, content_bounds.size.height-2*kNoteListWobbleEdge);
    m_title.text = @"text";
    m_title.textAlignment = NSTextAlignmentCenter;
    m_title.numberOfLines = 0;
    m_title.font = [UIFont systemFontOfSize:16];
    m_title.shadowColor = [UIColor whiteColor];
    m_title.shadowOffset = CGSizeMake(1, 1);
    [self.contentView addSubview:m_title];
    
    // close button
    m_close = [UIButton buttonWithType:UIButtonTypeCustom];
    m_close.frame = CGRectMake(-5, -5, 25, 25);
    [m_close setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [m_close addTarget:self action:@selector(BtnClose) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:m_close];
    [m_close setHidden:YES];
    
    // add long press gesture
    UILongPressGestureRecognizer *long_press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPress:)];
    long_press.minimumPressDuration = 1;
    [self.contentView addGestureRecognizer:long_press];
}

- (void) SetEditing:(BOOL)_editing
{
    [self SetEditing:_editing Animation:YES];
}

- (void) SetEditing:(BOOL)_editing Animation:(BOOL)animation
{
    if (animation)
    {
        float scale_time = 0.1;
        int rand = random()%60;
        rand += 40;
        float delay = (float)rand/200;
        if (_editing)
        {
            [UIView animateWithDuration:scale_time delay:delay options:0 animations:^{
                m_bkg.frame = m_title.frame;
            } completion:^(BOOL finished) {
                [m_close setHidden:NO];
                [self BeginWobble];
            }];
        }
        else
        {
            [UIView animateWithDuration:scale_time delay:delay options:0 animations:^{
                m_bkg.frame = self.contentView.bounds;
            } completion:^(BOOL finished) {
                [m_close setHidden:YES];
                [self EndWobble];
            }];
        }
    }
    else
    {
        if (_editing)
        {
            m_bkg.frame = m_title.frame;
            [m_close setHidden:NO];
            [self BeginWobble];
        }
        else
        {
            m_bkg.frame = self.contentView.bounds;
            [m_close setHidden:YES];
            [self EndWobble];
        }
    }
}

- (void) BeginWobble
{
    float wobble_cycle = 0.1;
    float wobble_angle = 0.05f;
    int rand = random()%100;
    float delay = (float)rand/200;
    [UIView animateWithDuration:0.1 delay:delay options:0 animations:^{
        self.transform = CGAffineTransformMakeRotation(-wobble_angle);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:wobble_cycle delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformMakeRotation(wobble_angle);
        } completion:nil];
    }];
}

- (void) EndWobble
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void) BtnClose
{
    if ([_delegate respondsToSelector:@selector(cbFromCellRemoveCell:)])
    {
        [_delegate performSelector:@selector(cbFromCellRemoveCell:) withObject:self];
    }
}

- (void) LongPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if ([_delegate respondsToSelector:@selector(cbFromCellBeginEditing)])
        {
            [_delegate performSelector:@selector(cbFromCellBeginEditing)];
        }
    }
}

- (void) SetWithTitle:(NSString *)_labelTitle
{
    m_title.text = _labelTitle;
}



@end
