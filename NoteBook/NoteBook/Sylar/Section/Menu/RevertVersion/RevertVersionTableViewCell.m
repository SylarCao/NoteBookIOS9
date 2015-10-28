//
//  RevertVersionTableViewCell.m
//  NoteBook
//
//  Created by Sylar on 4/1/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////
#import "RevertVersionTableViewCell.h"
#import "LocalVersion.h"
#import "CommonTools.h"
/////////////////////////////////////////////////////////
@interface RevertVersionTableViewCell()
{
    IBOutlet UILabel *m_title;
    IBOutlet UILabel *m_time0;
    IBOutlet UILabel *m_description;
}
@end
/////////////////////////////////////////////////////////
@implementation RevertVersionTableViewCell

+ (NSString *) GetCellId
{
    NSString *rt = @"RevertVersionTableViewCell_id";
    return rt;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    MGSwipeButton *b2 = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        if ([_cbDelegate respondsToSelector:@selector(RevertVersionTableViewCellDidTapDelete:)])
        {
            [_cbDelegate performSelector:@selector(RevertVersionTableViewCellDidTapDelete:) withObject:self];
        }
        return YES;
    }];
    
    self.rightButtons = @[b2];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) SetWithData:(LocalVersionItem *)item
{
    m_title.text = item.title;
    m_time0.text = item.date;
    m_description.text = item.descriptions;
}

@end
