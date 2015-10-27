//
//  ItemModel.m
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
//////////////////////////////////////////////////////////////////
#import "ItemModel.h"
#import "CommonTools.h"
//////////////////////////////////////////////////////////////////
# define kItemModelDicTitleKey   @"title"
# define kItemModelDicContentKey @"content"
//////////////////////////////////////////////////////////////////
@interface ItemModel()
{
    
}
@end
//////////////////////////////////////////////////////////////////
@implementation ItemModel

- (id) init
{
    self = [super init];
    if (self)
    {
        _title = LocalizedString(@"NewNoteTitle");
    }
    return self;
}

- (NSDictionary *) ToDictionary
{
    NSDictionary *rt = [[NSDictionary alloc] initWithObjectsAndKeys:
                        _title,    kItemModelDicTitleKey,
                        _content,  kItemModelDicContentKey,
                        nil];
    return rt;
}


+ (ItemModel *) GetFromDictionary:(NSDictionary *)_dic
{
    ItemModel *rt = [[ItemModel alloc] init];
    rt.title = [_dic objectForKey:kItemModelDicTitleKey];
    rt.content = [_dic objectForKey:kItemModelDicContentKey];
    return rt;
}



@end
