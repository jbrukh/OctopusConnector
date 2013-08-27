//
//  OCProcessController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/26/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCProcessController.h"

@implementation OCProcessController

- (id) init {
    self = [super init];
    if (self) {
        delegate = (OCAppDelegate *)[[NSApplication sharedApplication] delegate];
    }
    return self;
}
- (void)startServer
{
    NSLog(@"Starting Octopus Server.");
    
    // check if the task is running
    if (task != NULL && [task isRunning]) {
        NSLog(@"Octopus Server is already running.");
        return;
    }
    
    //create the task
    task = [[NSTask alloc] init];
    NSString* resourcePath = [[NSBundle mainBundle] pathForResource:OCServerBinary ofType:@""];
    
    [task setLaunchPath:resourcePath];
    NSArray *args = [self getArgs];
    [task setArguments:args];
    
    pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task setStandardError:pipe];
    
    [delegate setStatusItemUp];
    
    // subscribe to output from the process
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOutputFromProcess:) name: NSFileHandleReadCompletionNotification object:handle];

    
    // set termination handler
    id weakDelegate = delegate;
    id weakSelf = self;
    [task setTerminationHandler:^(NSTask *localTask){
        // TODO: send notification here with exit code
        [weakDelegate setStatusItemDown];
        int rc = [localTask terminationStatus];
        printf("EXIT CODE %d", rc);
        [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
    }];
    handle = [pipe fileHandleForReading];
  
    [task launch];
    [handle readInBackgroundAndNotify];
}

-(NSArray *)getArgs {
    NSMutableArray *result = [NSMutableArray array];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//
//    if (delegate.mockDevice) {
        [result addObject:@"--mockDevice"];
//        NSString* obfFile =[[NSBundle mainBundle] pathForResource:MOCK_FILE ofType:@""];
//        [result addObject:@"--mockFile"];
//        [result addObject:obfFile];
//    } else {
//        [result addObject:@"--device"];
//        [result addObject:delegate.deviceName];
//        [result addObject:@"--port"];
//        [result addObject:delegate.devicePort];
//    }
//    [result addObject:@"--repo"];
//    [result addObject:delegate.repoPath];
    return result;
}

-(void)stopServer
{
    NSLog(@"Stopping Octopus Server.");
    if (task != NULL && [task isRunning]) {
        [task terminate];
        [task waitUntilExit];
        [delegate setStatusItemDown];
    }
}

-(void)handleOutputFromProcess:(NSNotification *)notification
{
    if (task.isRunning) {
        [handle readInBackgroundAndNotify];
        NSData *data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];
        NSString *str;
        str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // notify observers
        [[NSNotificationCenter defaultCenter] postNotificationName:OCConsoleOutputNotification object:str];
    }
}

@end
