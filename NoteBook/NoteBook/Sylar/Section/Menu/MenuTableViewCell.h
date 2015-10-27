//
//  MenuTableViewCell.h
//  NoteBook
//
//  Created by Sylar on 3/31/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell

+ (NSString *) GetCellId;

- (void) SetWithTitle:(NSString *)_labelTitle;

@end
