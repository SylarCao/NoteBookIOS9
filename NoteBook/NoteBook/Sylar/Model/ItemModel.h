//
//  ItemModel.h
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *content;

- (NSDictionary *) ToDictionary;

+ (ItemModel *) GetFromDictionary:(NSDictionary *)_dic;


@end
