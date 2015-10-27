//
//  DataModel.m
//  NoteBook
//
//  Created by Sylar on 3/25/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////
#import "DataModel.h"
#import "ItemModel.h"
#import "LocalVersion.h"
////////////////////////////////////////////////////////////////////////
# define kDataModelKey   @"data"
////////////////////////////////////////////////////////////////////////
@interface DataModel()
{
    NSMutableArray* m_current;  // array of ItemModel
}
@end
////////////////////////////////////////////////////////////////////////
@implementation DataModel

+ (instancetype) Share
{
    static DataModel* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataModel alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        [self SetInitData];
    }
    return self;
}

- (void) SetInitData
{
    m_current = [[NSMutableArray alloc] init];
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    NSArray* arr = [user objectForKey:kDataModelKey];
    if (arr)
    {
        for (NSDictionary *dic in arr)
        {
            ItemModel *each_model = [ItemModel GetFromDictionary:dic];
            [m_current addObject:each_model];
        }
    }
}

- (BOOL) RevertVersion:(NSMutableArray *)data PlistData:(NSMutableArray *)plistData
{
    m_current = data;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:plistData forKey:kDataModelKey];
    BOOL rt = [user synchronize];
    return rt;
}

- (int) GetItemCount
{
    int rt = [m_current count];
    return rt;
}

- (ItemModel *) GetItemAtIndex:(int)_index
{
    ItemModel *rt = nil;
    if (_index < [m_current count])
    {
        rt = [m_current objectAtIndex:_index];
    }
    return rt;
}

- (void) MoveItemAtIndex:(int)_fromIndex To:(int)_toIndex
{
    int count = [m_current count];
    if (_fromIndex<count && _toIndex<count)
    {
        ItemModel *from = [m_current objectAtIndex:_fromIndex];
        [m_current removeObject:from];
        [m_current insertObject:from atIndex:_toIndex];
    }
}

- (void) AddItem:(ItemModel *)_item
{
    [m_current addObject:_item];
}

- (void) RemoveItem:(ItemModel *)_item
{
    [m_current removeObject:_item];
    [self Synchronize];
}

- (void) SynchronizeWithEditingItem:(ItemModel *)_model
{
    if ([m_current containsObject:_model] == NO && _model)
    {
        [m_current addObject:_model];
    }
    [self Synchronize];
}

- (void) Synchronize
{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (ItemModel *model in m_current)
    {
        NSDictionary *each_dic = [model ToDictionary];
        [arr addObject:each_dic];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:arr forKey:kDataModelKey];
    [user synchronize];
}

- (BOOL) SaveCurrentWithTitle:(NSString *)_title
{
    NSArray *data = [[NSUserDefaults standardUserDefaults] objectForKey:kDataModelKey];
    BOOL rt = [[LocalVersion Share] SaveData:data WithTitle:_title];
    return rt;
}

- (NSArray *) GetPreviousVersions
{
    NSArray *rt = [[LocalVersion Share] GetLocalVersions];
    return rt;
}


@end
