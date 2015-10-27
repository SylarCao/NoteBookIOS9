//
//  CommonTools.h
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefines.h"
#import "CommomColor.h"
#import "CommonActionSheet.h"

@interface CommonTools : NSObject

//+ (NSTimeInterval) GetTime0;


/* convert NSDate to NSString 
 */
+ (NSString *) GetStringFromDate:(NSDate *)_date; // @"yyyy-MM-dd HH-mm"
+ (NSString *) GetStringFromDate:(NSDate *)_date WithFormate:(NSDateFormatter *)_formatter;

/* auto layout
 * subview之间的gap平均分配
 * 所有subviews的height加起来应该小于等于parentView的height */
+ (void) AutoLayoutVerticleView:(UIView*)_parentView WithSubviews:(NSArray*)_subViews TopEdge:(float)_topEdge BottomEdge:(float)_bottomEdge NeedCenter:(BOOL)_center;

+ (int) GetNaviStatusBarHeight;

/* resize image
 * _width _height  为2个对应的比例 范围(0,1)
 * stretchableImageWithLeftCapWidth:IMAGE_WIDTH*_width topCapHeight:IMAGE_HEIGHT*_height */
+ (UIImage *) GetResizeImageWithName:(NSString *)_imgName;
+ (UIImage *) GetResizeImageWithName:(NSString *)_imgName Width:(float)_width Height:(float)_height;

+ (UIImage *)imageWithColor:(UIColor *)color;

// constrain label height
+ (CGFloat) GetLabelHeightWithLabel:(UILabel*)_label Text:(NSString*)_text;

// get max date
+ (NSDate *) MaxDate1:(NSDate *)date1 Date2:(NSDate *)date2;



@end
