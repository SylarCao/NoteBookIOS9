//
//  LocalVersion.h
//  NoteBook
//
//  Created by Sylar on 4/1/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalVersion : NSObject

+ (id) Share;

- (BOOL) SaveData:(NSArray *)data WithTitle:(NSString *)title;

- (NSArray *) GetLocalVersions;

- (BOOL) deleteLocalVersionWithTitle:(NSString *)aTitle;

@end
/////////////////////////////////////////////////////////////////////

@interface LocalVersionItem : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *date;
@property (nonatomic, strong, readonly) NSString *descriptions;
@property (nonatomic, strong, readonly) NSArray  *items;
@property (nonatomic, strong)    NSMutableArray  *data; // for plist

+ (LocalVersionItem *) CreateWithDictionary:(NSDictionary *)dic;

@end