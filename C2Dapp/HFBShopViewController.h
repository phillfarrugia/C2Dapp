//
//  HFBShopViewController.h
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HFBShopViewController : UIViewController

@property(nonatomic) NSString *formattedLocationString;
@property(nonatomic) NSString *latitudeLocationString;
@property(nonatomic) NSString *longitudeLocationString;

@property (strong, nonatomic) NSArray* results;
- (IBAction)mapsButton:(id)sender;
- (void)populateTextViewsForDictionary;

@end
