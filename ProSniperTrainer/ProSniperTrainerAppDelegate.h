//
//  ProSniperTrainerAppDelegate.h
//  ProSniperTrainer
//
//  Created by Nikki Fernandez on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SniperLandingViewController.h"

//@class SniperLandingViewController;

@interface ProSniperTrainerAppDelegate : NSObject <UIApplicationDelegate> {
    SniperLandingViewController *sniperLandingVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
