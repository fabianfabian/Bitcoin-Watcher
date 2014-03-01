//
//  FGLPopoverContentViewController.m
//  Bitcoin Watcher
//
//  Created by Fabian Lachman on 28/02/14.
//  Copyright (c) 2014 Fabian Lachman. All rights reserved.
//

#import "FGLPopoverContentViewController.h"
#import "FGLBitcoinWatcherView.h"
#import "FGLAppDelegate.h"

@interface FGLPopoverContentViewController ()

@end

@implementation FGLPopoverContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (IBAction)quit:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (IBAction)done:(id *)sender {
    [self.popoverDelegate dismissPopover];
    FGLAppDelegate *appDelegate = (FGLAppDelegate*) [[NSApplication sharedApplication] delegate];
    [appDelegate refreshBalace];
}

- (IBAction)donate:(id)sender {
    NSAlert *alert = [NSAlert alertWithMessageText:@"Donations are welcome at:\n\n 147kyNiZhiDZn5vZyyTRroMtFFPKV8wf1e"
                                     defaultButton:@"OK"
                                   alternateButton:@"View address on Blockchain.info"
                                       otherButton:@""
                         informativeTextWithFormat:@""];


    NSModalResponse response = [alert runModal];
    if (response == NSAlertAlternateReturn)
    {
        [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: @"https://blockchain.info/address/147kyNiZhiDZn5vZyyTRroMtFFPKV8wf1e"]];
    }
}

@end
