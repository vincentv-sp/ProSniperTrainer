//
//  ShotMapViewController.h
//  ProSniperTrainer
//
//  Created by Nikki Fernandez on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShotMapViewController : UIViewController <UIScrollViewDelegate> {
    
}

// Navigation buttons
@property (nonatomic, retain) IBOutlet UIButton* addRoundButton;
@property (nonatomic, retain) IBOutlet UIButton* deleteRoundButton;
@property (nonatomic, retain) IBOutlet UIButton* settingsButton;
@property (nonatomic, retain) IBOutlet UIButton* sniperButton;

@property (nonatomic, retain) IBOutlet UIScrollView* shotMapScrollView;
@property (nonatomic, retain) IBOutlet UIImageView* shotMap1ImageView;
@property (nonatomic, retain) IBOutlet UIImageView* shotMap2ImageView;


-(IBAction) addRoundClicked;
-(IBAction) deleteRoundClicked;
-(IBAction) settingsClicked;
-(IBAction) sniperClicked;


@end
