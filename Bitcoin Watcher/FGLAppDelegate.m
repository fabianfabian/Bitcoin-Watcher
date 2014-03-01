//
//  FGLAppDelegate.m
//  Bitcoin Watcher
//
//  Created by Fabian Lachman on 28/02/14.
//  Copyright (c) 2014 Fabian Lachman. All rights reserved.
//

#import "FGLAppDelegate.h"
#import "FGLBitcoinWatcherView.h"
#import "AFHTTPRequestOperationManager.h"

@interface FGLAppDelegate ()

@property FGLBitcoinWatcherView* statusView;
@property NSTimer* updateTimer;
@property double updateInterval;

@end

@implementation FGLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _statusView = [[FGLBitcoinWatcherView alloc] init];
    _updateInterval = 60 * 5;
    NSString *pastedText = [[NSUserDefaults standardUserDefaults] stringForKey:@"addresses"];
    
    if (pastedText == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"\nPaste bitcoin addresses here" forKey:@"addresses"];
    }

    NSSet *addresses = [self bitcoinAddressesFromString:pastedText];
    
    [self fetchBalanceForAddresses:addresses];
    [self startTimer];
}

- (void)refreshBalace
{
    NSString *pastedText = [[NSUserDefaults standardUserDefaults] stringForKey:@"addresses"];
    NSSet *addresses = [self bitcoinAddressesFromString:pastedText];
    [self fetchBalanceForAddresses:addresses];
}

// Fetch balance using blockchain.info's API
// See https://blockchain.info/q for details
- (void)fetchBalanceForAddresses:(NSSet*)addresses
{
    // Concatenate addresses with |
    NSString *joinedAddresses = [[addresses allObjects] componentsJoinedByString:@"%7C"]; // | encodes to "%7C"
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"Fetching...");
    [manager GET:[NSString stringWithFormat:@"https://blockchain.info/q/addressbalance/%@",joinedAddresses] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        float balance = [string floatValue] / 100000000; // Divide because response is in satoshi's
        [self.statusView setTitle:[NSString stringWithFormat:@"%.4f",balance]]; // update display
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}

// Detect addresses in string
// Looks for strings with a length of 25-34
// Addresses can be seperated by tabs, spaces or newlines
- (NSSet*)bitcoinAddressesFromString: (NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    NSMutableArray *items = [[string componentsSeparatedByString:@"\n"] mutableCopy];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length >= 25 AND length <= 34"];
    [items filterUsingPredicate:predicate];
    return [NSSet setWithArray:items];
}

- (void)startTimer
{
    [_updateTimer invalidate];
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:_updateInterval
                                                    target:self
                                                  selector:@selector(refreshBalace)
                                                  userInfo:nil
                                                   repeats:YES];
}

@end
