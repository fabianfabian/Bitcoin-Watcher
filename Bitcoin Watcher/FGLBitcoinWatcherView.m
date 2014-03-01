//
//  FGLStatusView.m
//  Bitcoin Watcher
//
//  Created by Fabian Lachman on 28/02/14.
//  Copyright (c) 2014 Fabian Lachman. All rights reserved.
//
#import "FGLBitcoinWatcherView.h"
#import "FGLPopoverContentViewController.h"

@interface FGLBitcoinWatcherView ()

@property NSStatusItem *statusItem;
@property NSPopover *popover;

@end


@implementation FGLBitcoinWatcherView

- (void)setTitle:(NSString*)title
{
    [_statusItem setTitle:title];
}

- (id)init
{
    self = [super init];
    if (self) {
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [_statusItem setTitle:@"0.0000"];
        
        [_statusItem setTarget:self];
        [_statusItem setAction:@selector(statusClicked:)];
        
        if (_popover == nil) {
            FGLPopoverContentViewController *pcvc = [[FGLPopoverContentViewController alloc] initWithNibName:@"BitcoinWatcher" bundle:nil];
            pcvc.popoverDelegate = self;
            
            _popover = [[NSPopover alloc] init];
            _popover.behavior = NSPopoverBehaviorTransient;
            _popover.delegate = self;
            _popover.contentViewController = pcvc;
        }
     }
    return self;
}

- (void)statusClicked:(id)sender {
    if ([_popover isShown]) {
        [_popover close];
    }
    [_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}

-(void)dismissPopover
{
    [_popover close];
    
}

- (void)popoverDidClose:(NSNotification *)notification
{
    
}

@end
