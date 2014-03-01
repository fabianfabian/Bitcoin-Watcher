//
//  FGLPopoverContentViewController.h
//  Bitcoin Watcher
//
//  Created by Fabian Lachman on 28/02/14.
//  Copyright (c) 2014 Fabian Lachman. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol DismissPopoverDelegate

- (void) dismissPopover;

@end


@interface FGLPopoverContentViewController : NSViewController

@property (nonatomic, assign) id<DismissPopoverDelegate> popoverDelegate;

- (IBAction)quit:(id)sender;
- (IBAction)done:(id *)sender;

@end
