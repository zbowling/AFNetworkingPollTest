//
//  ZBViewController.m
//  ServerTest
//
//  Created by Zac Bowling on 11/29/11.
//  Copyright (c) 2011 i'mhello. All rights reserved.
//

#import "ZBViewController.h"
#import "AFURLConnectionOperation.h"
@interface ZBViewController()

- (void)executeTest;

@end

@implementation ZBViewController {
    NSOperationQueue *_operationQueue;
    int _runCount;
}
@synthesize statusLabel = _statusLabel;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self){
        _runCount = 0;
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)executeTest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:1337"] 
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData 
                                         timeoutInterval:200];
    
    AFURLConnectionOperation *urlConnectionOperation = [[AFURLConnectionOperation alloc] initWithRequest:request];
    urlConnectionOperation.completionBlock = ^{
        dispatch_async(dispatch_get_main_queue(),^{
            self.statusLabel.text = [NSString stringWithFormat:@"operation %i completed at %@\nbattery level is: %0.2f%%",_runCount,[NSDate date],[[UIDevice currentDevice] batteryLevel] * 100];
            _runCount++;
            [self executeTest];
        });

    };
    [_operationQueue addOperation:urlConnectionOperation];
}

- (IBAction)runTest:(id)sender {
    _runCount = 1;
    [_operationQueue cancelAllOperations];
    [_operationQueue waitUntilAllOperationsAreFinished];
    self.statusLabel.text = @"starting new test"; 
    [self executeTest];

}

@end
