//
//  HFBLocationViewController.h
//  C2Dapp
//
//  Created by Robin Wohlers-Reichel on 23/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HFBMainViewController.h"

@interface HFBLocationViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *locationStatus;

@end
