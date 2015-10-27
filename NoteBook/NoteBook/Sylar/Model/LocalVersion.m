//
//  LocalVersion.m
//  NoteBook
//
//  Created by Sylar on 4/1/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
#import "LocalVersion.h"
#import "JSONKit.h"
#import "CommonTools.h"
#import "ItemModel.h"
////////////////////////////////////////////////////////////////////////////////////
@interface LocalVersion()
{
    NSString *m_path;
}
@end
////////////////////////////////////////////////////////////////////////////////////
@implementation LocalVersion

+ (id) Share
{
    static LocalVersion *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[LocalVersion alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        [self SetInitialValue];
    }
    return self;
}

- (void) SetInitialValue
{
    // save path
    NSString *home = NSHomeDirectory();
    m_path = [home stringByAppendingPathComponent:@"Documents/Versions"];
    [[NSFileManager defaultManager] createDirectoryAtPath:m_path withIntermediateDirectories:YES attributes:nil error:nil];
}

- (BOOL) SaveData:(NSArray *)data WithTitle:(NSString *)title
{
    long time0 = [[NSDate date] timeIntervalSince1970];
    NSString *stime0 = [NSString stringWithFormat:@"%ld", time0];
    if (title.length < 1)
    {
        title = [CommonTools GetStringFromDate:[NSDate date]];
    }
    NSDictionary *save = [NSDictionary dictionaryWithObjectsAndKeys:
                          data,    @"data",
                          title,   @"title",
                          stime0,  @"time0",
                          nil];
    NSString *file = [m_path stringByAppendingPathComponent:title];
    BOOL rt = [[NSFileManager defaultManager] createFileAtPath:file contents:[save JSONData] attributes:nil];
    return rt;
}

- (NSArray *) GetLocalVersions
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *versions = [manager contentsOfDirectoryAtPath:m_path error:nil];
    NSMutableArray *rt = [[NSMutableArray alloc] init];
    for (NSString *each_name in versions)
    {
        if ([each_name isEqualToString:@".DS_Store"])
        {
            continue;
        }
        NSString *each_file = [m_path stringByAppendingPathComponent:each_name];
        NSData *data = [manager contentsAtPath:each_file];
        NSDictionary *dic = [data objectFromJSONData];
        LocalVersionItem *each_item = [LocalVersionItem CreateWithDictionary:dic];
        [rt addObject:each_item];
    }
    return rt;
}

- (BOOL) deleteLocalVersionWithTitle:(NSString *)aTitle
{
    BOOL rt = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *versions = [manager contentsOfDirectoryAtPath:m_path error:nil];
    for (NSString *each_name in versions)
    {
        if ([each_name isEqualToString:aTitle])
        {
            NSString *file_path = [m_path stringByAppendingPathComponent:each_name];
            rt = [manager removeItemAtPath:file_path error:nil];
            break;
        }
    }
    return rt;
}

@end
////////////////////////////////////////////////////////////////////////////////////////////
@implementation LocalVersionItem

+ (LocalVersionItem *) CreateWithDictionary:(NSDictionary *)dic
{
    LocalVersionItem *rt = [[LocalVersionItem alloc] initWithDictionary:dic];
    return rt;
}

- (id) initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _title = [dic objectForKey:@"title"];
        _date = [CommonTools GetStringFromDate:[NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"time0"] floatValue]]];
        NSMutableArray *obj_items = [[NSMutableArray alloc] init];
        NSArray        *dic_items = [dic objectForKey:@"data"];
        _data = [[NSMutableArray alloc] initWithArray:dic_items];
        NSString       *des = @"";
        for (NSDictionary *each_dic_item in dic_items)
        {
            ItemModel *each_item_model = [ItemModel GetFromDictionary:each_dic_item];
            [obj_items addObject:each_item_model];
            des = [des stringByAppendingFormat:@"(%@)  ", each_item_model.title];
        }
        _items = obj_items;
        _descriptions = des;
    }
    return self;
}

@end