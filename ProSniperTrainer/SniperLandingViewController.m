//
//  SniperLandingViewController.m
//  ProSniperTrainer
//
//  Created by Nikki Fernandez on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SniperLandingViewController.h"
#import <QuartzCore/QuartzCore.h>

// CONSTANTS
#define kFilteringFactor			0.1

#define kSniperExpertThreshold      0.000160
#define kSniperStandardThreshold    0.000640
#define kSniperNoviceThreshold      0.001500
#define kRifleExpertThreshold       0.000250
#define kRifleStandardThreshold     0.005050
#define kRifleNoviceThreshold       0.010150
#define kPistolExpertThreshold      0.001150
#define kPistolStandardThreshold    0.049150
#define kPistolNoviceThreshold      0.100150

#define kSniperExpertFrequency      100
#define kSniperStandardFrequency    90
#define kSniperNoviceFrequency      80
#define kRifleExpertFrequency       90
#define kRifleStandardFrequency     80
#define kRifleNoviceFrequency       70
#define kPistolExpertFrequency      80
#define kPistolStandardFrequency    70
#define kPistolNoviceFrequency      60

#define kSniperExpertReticleFix     60
#define kSniperStandardReticleFix   50
#define kSniperNoviceReticleFix     40
#define kRifleExpertReticleFix      50
#define kRifleStandardReticleFix    40
#define kRifleNoviceReticleFix      30
#define kPistolExpertReticleFix     40
#define kPistolStandardReticleFix   30
#define kPistolNoviceReticleFix     20

#define kSniperExpertSensitivity       0.001500
#define kSniperStandardSensitivity     0.001500
#define kSniperNoviceSensitivity       0.005050
#define kRifleExpertSensitivity        0.008600
#define kRifleStandardSensitivity      0.012150
#define kRifleNoviceSensitivity        0.015750
#define kPistolExpertSensitivity       0.019250
#define kPistolStandardSensitivity     0.022805
#define kPistolNoviceSensitivity       0.026355


int reticleFixCount;
int weaponType;
int xpLevel;

@implementation SniperLandingViewController

@synthesize shotMapButton;
@synthesize weaponSelectorButton;
@synthesize settingsButton;
@synthesize soundsButton;
@synthesize reticleView;
@synthesize selectedWeaponView;
@synthesize weaponPickerView;
@synthesize barGraphView;
@synthesize x, y, z;
@synthesize xAcc, yAcc, zAcc, lastX, lastY, lastZ;
@synthesize sensorBar;
@synthesize sensorValue;
@synthesize meterView = _meterView;
@synthesize reticleFix = _reticleFix;
@synthesize frequency = _frequency;
@synthesize threshold = _threshold;
@synthesize meterSensitivity = _meterSensitivity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        weaponArray = [[NSMutableArray alloc] initWithObjects:@"Sniper", @"Shoulder Rifle", @"Pistol", nil];
        levelArray = [[NSMutableArray alloc] initWithObjects:@"Expert", @"Standard", @"Novice", nil];
        self.threshold = kSniperExpertThreshold;
        self.frequency = kSniperExpertFrequency;
        self.meterSensitivity = kSniperExpertSensitivity;
        self.reticleFix = kSniperExpertReticleFix;
        weaponType = 1;
        xpLevel = 3;
    }
    return self;
}

- (void)dealloc
{
    self.meterView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark Accelerometer events

- (void)startAccelerometer {
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval = 1.0 / self.frequency;
}

- (void)stopAccelerometer {
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = nil;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer
		didAccelerate:(UIAcceleration *)acceleration
{
    float xyz;
    float rate;

    //double dt = 1.0 / 60;
    //double RC = 1.0 / 5.0;
    //double filterConstant = dt / (dt + RC);
    double kThreshold = self.threshold; //slider.value;
    if (   fabsf(acceleration.x) > kThreshold
        || fabsf(acceleration.y) > kThreshold
        || fabsf(acceleration.z) > kThreshold) {
        //Use a basic low-pass filter to only keep the gravity in the accelerometer values
        xAcc = acceleration.x * kFilteringFactor  + xAcc * (1.0 - kFilteringFactor );
        yAcc = acceleration.y * kFilteringFactor  + yAcc * (1.0 - kFilteringFactor );
        zAcc = acceleration.z * kFilteringFactor  + zAcc * (1.0 - kFilteringFactor );
        x.text = [NSString stringWithFormat:@"X is: %.05f", 0 - (xAcc)];
        y.text = [NSString stringWithFormat:@"Y is: %.05f", 0 - (yAcc)];
        z.text = [NSString stringWithFormat:@"Z is: %.05f", 0 - (zAcc)];
        //double magnitude = sqrt((xAcc*xAcc) + (yAcc*yAcc) + (zAcc*zAcc));
        //m.text = [NSString stringWithFormat:@" %.02f", magnitude];
        if((0 - xAcc) > (0 -lastX)) {
            xyz = xyz + (0 - (xAcc)) - (0 - (lastX));
            //rate = rate + (xyz * 12);
        }
        if((0 - yAcc) > (0 -lastY)) {
            xyz = xyz + (0 - (yAcc)) - (0 - (lastY));
            //rate = rate + (xyz * 12);
        }
        if((0 - zAcc) > (0 -lastZ)) {
            xyz = xyz + (0 - (zAcc)) - (0 - (lastZ));
            //rate = rate + (xyz * 12);
        }
        rate = ((0 - (xAcc)) - (0 - (lastX)) + (0 - (yAcc)) - (0 - (lastY)) + (0 - (zAcc)) - (0 - (lastZ))) * ((self.reticleFix / 10) * (1 / self.meterSensitivity)); //self.frequency;
        sensorBar.progress = xyz;
        _meterView.rating = rate;
        sensorValue.text = [NSString stringWithFormat:@"%.06f", xyz];
        if (xyz <= self.meterSensitivity){
            reticleFixCount ++;
            if (reticleFixCount == self.reticleFix){
                reticleView.image = [UIImage imageNamed:@"reticle-green.png"];
            }
        } else {
            reticleFixCount = 0;
            reticleView.image = [UIImage imageNamed:@"reticle-red.png"];
        }
        lastX=xAcc;
        lastY=yAcc;
        lastZ=zAcc;
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    
    isSoundOn = NO;
    barGraphView.layer.cornerRadius = 8;
    
    //Sensor Bar Initialization
    _meterView.blankBar = [UIImage imageNamed:@"meter_blank.png"];
    _meterView.greenBar = [UIImage imageNamed:@"meter_green.png"];
    _meterView.yellowBar = [UIImage imageNamed:@"meter_yellow.png"];
    _meterView.redBar = [UIImage imageNamed:@"meter_red.png"];
    _meterView.rating = 0;
    _meterView.editable = NO;
    _meterView.maxRating = 12;
    
    //Sensitivity Values Initialization. Temp defaults to Sniper Expert
    reticleFixCount = 0;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self stopAccelerometer];
     self.meterView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self startAccelerometer];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self stopAccelerometer];
}

#pragma mark Picker View 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{    
    if(component == 0)              // Weapon type picker
        return [weaponArray count];
    else                            // Level picker
        return [levelArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    if(component == 0)              // Weapon type picker
        return [weaponArray objectAtIndex:row];
    else                            // Level picker
        return [levelArray objectAtIndex:row];
}

#pragma mark Picker View delegate methods

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{   
    if(component == 0)
    {
        if(row == 0) {        // Sniper
            selectedWeaponView.image = [UIImage imageNamed:@"weapon-sniper.png"];
            weaponType = 1;
        }else if(row == 1) {  // Shoulder rifle
            selectedWeaponView.image = [UIImage imageNamed:@"weapon-rifle.png"];
            weaponType = 2;
        }else {               // Pistol
            selectedWeaponView.image = [UIImage imageNamed:@"weapon-pistol.png"];
            weaponType = 3;
        }
    }   
    
    if(component == 1)
    {
        if (row == 0) {         // Expert
            xpLevel = 3;
        } else if(row == 1) {   // Standard
            xpLevel = 2;
        } else {                // Novice
            xpLevel = 1;
        }
    }
    
    switch (weaponType) {
        case 1:
            switch (xpLevel) {
                case 3:
                    self.threshold = kSniperExpertThreshold;
                    self.frequency = kSniperExpertFrequency;
                    self.reticleFix = kSniperExpertReticleFix;
                    self.meterSensitivity = kSniperExpertSensitivity;
                    break;
                case 2:
                    self.threshold = kSniperStandardThreshold;
                    self.frequency = kSniperStandardFrequency;
                    self.reticleFix = kSniperStandardReticleFix;
                    self.meterSensitivity = kSniperStandardSensitivity;
                    break;
                case 1:
                    self.threshold = kSniperNoviceThreshold;
                    self.frequency = kSniperNoviceFrequency;
                    self.reticleFix = kSniperNoviceReticleFix;
                    self.meterSensitivity = kSniperNoviceSensitivity;
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (xpLevel) {
                case 3:
                    self.threshold = kRifleExpertThreshold;
                    self.frequency = kRifleExpertFrequency;
                    self.reticleFix = kRifleExpertReticleFix;
                    self.meterSensitivity = kRifleExpertSensitivity;
                    break;
                case 2:
                    self.threshold = kRifleStandardThreshold;
                    self.frequency = kRifleStandardFrequency;
                    self.reticleFix = kRifleStandardReticleFix;
                    self.meterSensitivity = kRifleStandardSensitivity;
                    break;
                case 1:
                    self.threshold = kRifleNoviceThreshold;
                    self.frequency = kRifleNoviceFrequency;
                    self.reticleFix = kRifleNoviceReticleFix;
                    self.meterSensitivity = kRifleNoviceSensitivity;
                    break;
                default:
                    break;
            }
        case 3:
            switch (xpLevel) {
                case 3:
                    self.threshold = kPistolExpertThreshold;
                    self.frequency = kPistolExpertFrequency;
                    self.reticleFix = kPistolExpertReticleFix;
                    self.meterSensitivity = kPistolExpertSensitivity;
                    break;
                case 2:
                    self.threshold = kPistolStandardThreshold;
                    self.frequency = kPistolStandardFrequency;
                    self.reticleFix = kPistolStandardReticleFix;
                    self.meterSensitivity = kPistolStandardSensitivity;
                    break;
                case 1:
                    self.threshold = kPistolNoviceThreshold;
                    self.frequency = kPistolNoviceFrequency;
                    self.reticleFix = kPistolStandardReticleFix;
                    self.meterSensitivity = kPistolNoviceSensitivity;
                    break;
                default:
                    break;
            }
        default:
            break;
    }
}


/*- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
 {
 UILabel *retval = (id)view;
 if (!retval) 
 {
 retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)] autorelease];
 }
 
 retval.text = @"Demo";
 retval.font = [UIFont systemFontOfSize:22];
 return retval;
 }*/


#pragma mark Navigation Button events

-(IBAction) shotMapClicked
{
    shotMapVC = [[ShotMapViewController alloc] initWithNibName:@"ShotMapViewController" bundle:nil];
    [self.navigationController pushViewController:shotMapVC animated:NO];
}

-(IBAction) weaponSelectorClicked
{
    [self stopAccelerometer];
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    weaponPickerView.frame = CGRectMake(0.0, 40.0, 0.0, 150.0);
    [actionSheet addSubview:weaponPickerView];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES; 
    doneButton.frame = CGRectMake(260.0, 5.0, 55.0, 30.0);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blueColor];
    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    [doneButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];    
    [actionSheet setBounds:CGRectMake(0.0, 0.0, 320.0, 350.0)];
}

-(IBAction) settingsClicked
{
    sniperSettingsVC = [[SniperSettingsViewController alloc] initWithNibName:@"SniperSettingsViewController" bundle:nil];
    [self.navigationController pushViewController:sniperSettingsVC animated:NO];
}

-(IBAction) soundsClicked
{
    isSoundOn = !isSoundOn;
    if(isSoundOn == YES)
        soundsButton.backgroundColor = [UIColor greenColor];        
    else
        soundsButton.backgroundColor = [UIColor grayColor];    
}

-(IBAction) doneButtonClicked
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [self startAccelerometer];
}


@end
