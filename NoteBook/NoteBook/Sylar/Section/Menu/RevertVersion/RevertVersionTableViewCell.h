//
//  RevertVersionTableViewCell.h
//  NoteBook
//
//  Created by Sylar on 4/1/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
@class RevertVersionTableViewCell;
@class LocalVersionItem;
/////////////////////////////////////////////////////////
@protocol RevertVersionTableViewCellDelegate <NSObject>

@optional
- (void) RevertVersionTableViewCellDidTapDelete:(RevertVersionTableViewCell *)cell;

@end
/////////////////////////////////////////////////////////
@interface RevertVersionTableViewCell : MGSwipeTableCell

@property (nonatomic, weak) id<RevertVersionTableViewCellDelegate> cbDelegate;

+ (NSString *) GetCellId;

- (void) SetWithData:(LocalVersionItem *)item;

@end
/////////////////////////////////////////////////////////