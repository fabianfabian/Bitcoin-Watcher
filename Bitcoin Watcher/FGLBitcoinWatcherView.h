//
//  FGLStatusView.h
//  Bitcoin Watcher
//
//  Created by Fabian Lachman on 28/02/14.
//  Copyright (c) 2014 Fabian Lachman. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FGLPopoverContentViewController.h" 

@interface FGLBitcoinWatcherView : NSView <NSMenuDelegate, NSPopoverDelegate, DismissPopoverDelegate>

- (void)setTitle:(NSString*)title;
- (void)dismissPopover;

@end



