//
//  CommonTools.m
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (NSTimeInterval) GetTime0
{
    NSDate* start = [NSDate date];
    NSTimeInterval rt = [start timeIntervalSince1970];
    return rt;
}

+ (NSString *) GetStringFromDate:(NSDate *)_date
{
    NSDateFormatter *ff = [[NSDateFormatter alloc] init];
    [ff setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *rt = [self GetStringFromDate:_date WithFormate:ff];
    return rt;
}

+ (NSString *) GetStringFromDate:(NSDate *)_date WithFormate:(NSDateFormatter *)_formatter
{
    NSString *rt = [_formatter stringFromDate:_date];
    return rt;
}

+ (void) AutoLayoutVerticleView:(UIView*)_parentView WithSubviews:(NSArray*)_subViews TopEdge:(float)_topEdge BottomEdge:(float)_bottomEdge NeedCenter:(BOOL)_center
{
    int subview_count = [_subViews count];
    if (subview_count > 0)
    {
        float total_subview_height = _topEdge+_bottomEdge;
        for (UIView* each_view in _subViews)
        {
            total_subview_height += each_view.frame.size.height;
        }
        float gap = (_parentView.frame.size.height - total_subview_height)/(subview_count+1);
        float pos_y = _topEdge + gap;
        for (int i=0; i<subview_count; i++)
        {
            UIView* the_view = [_subViews objectAtIndex:i];
            CGRect the_frame = the_view.frame;
            the_frame.origin.y = pos_y;
            pos_y = pos_y + gap + the_frame.size.height;
            
            if (_center)
            {
                the_frame.origin.x = (_parentView.frame.size.width - the_frame.size.width)/2;
            }
            [the_view setFrame:the_frame];
        }
    }
}

+ (int) GetNaviStatusBarHeight
{
    return 64;
}

+ (UIImage *) GetResizeImageWithName:(NSString *)_imgName
{
    UIImage *rt = [self GetResizeImageWithName:_imgName Width:0.5 Height:0.5];
    return rt;
}

+ (UIImage *) GetResizeImageWithName:(NSString *)_imgName Width:(float)_width Height:(float)_height
{
    UIImage *img = [UIImage imageNamed:_imgName];
    UIImage *rt = [img stretchableImageWithLeftCapWidth:img.size.width*_width topCapHeight:img.size.height*_height];
    return rt;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGFloat) GetLabelHeightWithLabel:(UILabel*)_label Text:(NSString*)_text
{
    CGRect rect = [_text boundingRectWithSize:CGSizeMake(_label.frame.size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _label.font} context:nil];
    CGRect rect_one_line = [@"123" boundingRectWithSize:CGSizeMake(_label.frame.size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _label.font} context:nil];
    int addition_height = rect.size.height/rect_one_line.size.height;
    CGFloat rt = rect.size.height+addition_height;
    return rt;
}

+ (NSDate *) MaxDate1:(NSDate *)date1 Date2:(NSDate *)date2
{
    NSDate *rt = date1;
    if ([date1 compare:date2] == NSOrderedAscending)
    {
        rt = date2;
    }
    return rt;
}

@end
