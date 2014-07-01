//
//  HFBShopViewController.m
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBShopViewController.h"
#import "JSONModelLib.h"
#import "HFBDataModel.h"
#import "HFBFeed.h"
#import "HFBPhotoFeed.h"

@interface HFBShopViewController () {
     HFBPhotoFeed* _photoURL;
    NSString *formattedAddress;
}

@property (weak, nonatomic) IBOutlet UILabel *shopTitle;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceValue;
@property (weak, nonatomic) IBOutlet UIImageView *shopPhoto;
<<<<<<< HEAD
=======
@property (strong, nonatomic) NSString* busID;
@property (strong, nonatomic) NSDictionary* info;
>>>>>>> robdogga

@end

@implementation HFBShopViewController

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
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNext:)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
//    [self asyncRequest];
}

- (void)gotoNext:(id)sender {
    [self populateTextViewsForDictionary];
}



- (void)asyncRequest
{
//    dispatch_async(
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
//                   ^{
//                       NSData* data = [NSData dataWithContentsOfURL:
//                                       [NSURL URLWithString:[NSString stringWithFormat:
//                                                             @"http://hereforbeer.io/test-google-json.json"]]];
//                       [self performSelectorOnMainThread:@selector(fetchedData:)
//                                              withObject:data waitUntilDone:YES];
//                   });
}


- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    self.results= [json objectForKey:@"results"];
    
    // Sets values for Shop View in Storyboard from Async Data
    [self populateTextViewsForDictionary];
}

- (void)populateTextViewsForDictionary {
    
    int dataRange = [self.results count];
    int random = arc4random_uniform(dataRange);
    self.info = [self.results objectAtIndex:random];
    
    NSDictionary *tempGeometry = [self.info objectForKey:@"geometry"];
    NSDictionary *tempLocation = [tempGeometry objectForKey:@"location"];
    NSString *lat = [tempLocation objectForKey:@"lat"];
    NSString *lng = [tempLocation objectForKey:@"lng"];
    
<<<<<<< HEAD
    
    // Set Image First and If No Image recalculate the object Index
    
    NSString *photoReference = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"photos.photo_reference"]];
    
    NSLog(@"PHOTO REFERENCE -- \n %@", photoReference);
    NSString *photoReferenceClean = @"";
    
    if (photoReference != nil) {
        NSString *photoTrim = [[photoReference stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
        photoReferenceClean = [photoTrim stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        photoReferenceClean = [photoReferenceClean stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
    }
    
    NSLog(@"%@", photoReferenceClean);
    NSString* photoURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=AIzaSyBmGfUedBA9Zm61R8KH9asr8Nf7arolcIc&sensor=false&maxwidth=320", photoReferenceClean];
    
    NSLog(@"PHOTO URL ----- \n %@", photoURL);
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURL]];
    self.shopPhoto.image = [UIImage imageWithData:imageData];
    
    // Set all other values
    
    self.title = [info valueForKey:@"name"];
    self.shopTitle.text = [info valueForKey:@"name"];
    self.shopAddress.text = [info valueForKey:@"formatted_address"];
    self.shopPriceValue.text = [info valueForKey:@"price_level"];
    
=======
    [self setForamttedAddress:lat andLng:lng];
    
    NSString *photoReference = [NSString stringWithFormat:@"%@",[self.info valueForKeyPath:@"photos.photo_reference"]];
    NSString *photoReferenceClean = @"";
    
    // Checks for photo and cleans photoReference
    // Can be deleted once empty photo shops are deleted
    if (photoReference != nil) {
        NSString *photoTrim = [[photoReference stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
        photoReferenceClean = [photoTrim stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        photoReferenceClean = [photoReferenceClean stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
    }
    
    // Sets UIImageView with Photo URL from Google API
    NSString* photoURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=AIzaSyBmGfUedBA9Zm61R8KH9asr8Nf7arolcIc&sensor=false&maxwidth=800", photoReferenceClean];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURL]];
    self.shopPhoto.image = [UIImage imageWithData:imageData];
    
    // ToDo - Need to check if Google API key photos is nil and delete shop object from dictionary

    self.shopTitle.text = [self.info valueForKey:@"name"];
    //self.shopAddress.text = formattedAddress;//[self.info valueForKey:@"formatted_address"];
    self.shopPrice.text = @"Price";
    
    if ([self.info valueForKey:@"price_level"] == nil) {
        self.shopPriceValue.text = @"Unrated";
        self.shopPrice.text = @"Price";
    } else {
    NSString *price = [NSString stringWithFormat:@"%@", [self.info valueForKey:@"price_level"]];
    self.shopPriceValue.text = price;
    self.shopPrice.text = @"Price";
        
        self.busID = [self.info valueForKey:@"id"];
        NSLog(@"Business ID ---- \n %@", [self.info valueForKey:@"id"]);
    }
>>>>>>> robdogga
}

- (void)setForamttedAddress:(NSString*)lat andLng:(NSString*)lng {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSLog(@"Resolving the Address");
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
    CLLocation *businessLocation=[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [geocoder reverseGeocodeLocation:businessLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             //address is NSString variable that declare in .h file.
             formattedAddress = [NSString stringWithFormat:@"%@, %@",[placemark thoroughfare],[placemark locality]];
             NSLog(@"New Address Is:%@",formattedAddress);
             self.shopAddress.text = formattedAddress;
         }
     }];
}

- (IBAction)mapsButton:(id)sender {
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        NSDictionary *tempGeometry = [self.info objectForKey:@"geometry"];
        NSDictionary *tempLocation = [tempGeometry objectForKey:@"location"];
        NSString *lat = [tempLocation objectForKey:@"lat"];
        NSString *lng = [tempLocation objectForKey:@"lng"];
        // Create an MKMapItem to pass to the Maps app
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"My Place"];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
