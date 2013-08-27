//
//  OCProcessController.h
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/26/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Constants.h"

@class OCAppDelegate;

@interface OCProcessController : NSObject {
@private
    NSTask *task;
    NSPipe *pipe;
    NSFileHandle *handle;
    OCAppDelegate *delegate;
}

-(void) startConnector;
-(void) stopConnector;

@end
