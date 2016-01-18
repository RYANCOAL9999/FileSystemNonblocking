//
//  FileSystem_Nonblocking_steamevents.h
//  FileSystem-Nonblocking
//
//  Created by Steven Poon on 15/1/2016.
//  Copyright © 2016 Steven Poon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSystem_Nonblocking_steamevents : NSObject

@property(strong,readwrite)NSStream *newevents;
@property(strong,readonly)NSMutableData *_data;
@property(strong,readonly)NSInputStream *ins;
@property(readonly,nonatomic) NSInteger *newhandleevents;



- (void)testsetUpStreamForFile;
//- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;
- (void)Getdata;

@end
