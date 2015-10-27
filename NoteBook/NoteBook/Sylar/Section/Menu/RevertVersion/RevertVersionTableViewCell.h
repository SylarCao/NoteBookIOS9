//
//  RevertVersionTableViewCell.h
//  NoteBook
//
//  Created by Sylar on 4/1/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@class LocalVersionItem;

@interface RevertVersionTableViewCell : SWTableViewCell

+ (NSString *) GetCellId;

- (NSArray *) SetRightButtons;

- (void) SetWithData:(LocalVersionItem *)item;

@end
