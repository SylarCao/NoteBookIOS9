//
//  RevertNoteListDetailedViewController.m
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////
#import "RevertNoteListDetailedViewController.h"
#import "ItemModel.h"
////////////////////////////////////////////////////////////////
@interface RevertNoteListDetailedViewController ()

@end
////////////////////////////////////////////////////////////////
@implementation RevertNoteListDetailedViewController

+ (id) CreateWithData:(ItemModel *)_data
{
    id rt = [[RevertNoteListDetailedViewController alloc] initWithData:_data];
    return rt;
}

- (id) initWithData:(ItemModel *)_data
{
    self = [super initWithData:_data];
    if (self)
    {
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    // right swap back enable
    
}


- (void) SetNaviBar
{
    // title
    m_title = [[UITextField alloc] init];
    m_title.frame = CGRectMake(0, 0, 140, 40);
    m_title.text = m_data.title;
    m_title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = m_title;
    
    m_title.enabled = NO;
    m_content.editable = NO;
}

@end
