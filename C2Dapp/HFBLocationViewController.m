//
//  HFBLocationViewController.m
//  C2Dapp
//
//  Created by Robin Wohlers-Reichel on 23/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBLocationViewController.h"

@interface HFBLocationViewController ()

@end

@implementation HFBLocationViewController {
    CLLocationManager *locationManager;
    NSString *locationString;
    NSString *latitudeString;
    NSString *longitudeString;
    int retries;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    retries = 0;
    // Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (retries++ > 3) {//++retries >= 5
        [self performSegueWithIdentifier:@"locationError" sender:self];
    } else {
        //go again
        _locationStatus.hidden = NO;
        [NSThread sleepForTimeInterval:2.0];
        [locationManager stopUpdatingLocation];
        [locationManager startUpdatingLocation];
    }
    /*NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];*/
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil && currentLocation.horizontalAccuracy < 1000) {
        latitudeString = [NSString stringWithFormat:@"%.8f,", currentLocation.coordinate.latitude];
        longitudeString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        locationString = [NSString stringWithFormat:@"%.8f,%.8f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
        [locationManager stopUpdatingLocation];
        [self performSegueWithIdentifier:@"locationFoundSegue" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"locationFoundSegue"]){
        HFBMainViewController *controller = (HFBMainViewController *)segue.destinationViewController;
        controller.formattedLocationString = locationString;
        controller.latitudeLocationString = latitudeString;
        controller.longitudeLocationString = longitudeString;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
