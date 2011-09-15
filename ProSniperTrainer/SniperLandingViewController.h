//
//  SniperLandingViewController.h
//  ProSniperTrainer
//
//  Created by Nikki Fernandez on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShotMapViewController.h"
#import "SniperSettingsViewController.h"
#import "MeterView.h"

@interface SniperLandingViewController : UIViewController <UIPickerViewDelegate, UIActionSheetDelegate, UIAccelerometerDelegate> {
    MeterView *_meterView;
    ShotMapViewController *shotMapVC;
    SniperSettingsViewController *sniperSettingsVC;
    
    BOOL isSoundOn;
    NSMutableArray *weaponArray;
    NSMutableArray *levelArray;
    
    UIActionSheet *actionSheet;
    
    UILabel *x;
    UILabel *y;
    UILabel *z;
    
    UIProgressView *sensorBar;
    int _reticleFix;
    int _frequency;
    float _threshold;
    float _meterSensitivity;
    
}

// Navigation buttons
@property (nonatomic, retain) IBOutlet UIButton* shotMapButton;
@property (nonatomic, retain) IBOutlet UIButton* weaponSelectorButton;
@property (nonatomic, retain) IBOutlet UIButton* settingsButton;
@property (nonatomic, retain) IBOutlet UIButton* soundsButton;

@property (nonatomic, retain) IBOutlet UIImageView *reticleView;
@property (nonatomic, retain) IBOutlet UIImageView *selectedWeaponView;

// Weapon Selector Pickers
@property (nonatomic, retain) IBOutlet UIPickerView *weaponPickerView;

// Bar Graph
@property (nonatomic, retain) IBOutlet UIView *barGraphView;

//Accelerometer
@property(nonatomic, readonly) UIAccelerationValue xAcc;
@property(nonatomic, readonly) UIAccelerationValue yAcc;
@property(nonatomic, readonly) UIAccelerationValue zAcc;

@property(nonatomic, readonly) UIAccelerationValue lastZ;
@property(nonatomic, readonly) UIAccelerationValue lastY;
@property(nonatomic, readonly) UIAccelerationValue lastX;

@property (nonatomic, retain) IBOutlet UILabel *x;
@property (nonatomic, retain) IBOutlet UILabel *y;
@property (nonatomic, retain) IBOutlet UILabel *z;

//Sensor Bar Graph
@property (nonatomic, retain) IBOutlet MeterView *meterView;
@property (nonatomic, readonly) IBOutlet UIProgressView *sensorBar;
@property (nonatomic, readonly) IBOutlet UILabel *sensorValue;

//Sensitivity Variables
@property int reticleFix;
@property int frequency;
@property float threshold;
@property float meterSensitivity;


-(IBAction) shotMapClicked;
-(IBAction) weaponSelectorClicked;
-(IBAction) settingsClicked;
-(IBAction) soundsClicked;

-(IBAction) doneButtonClicked;

@end
