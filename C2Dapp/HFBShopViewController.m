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
}

@property (weak, nonatomic) IBOutlet UILabel *shopTitle;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceValue;
@property (weak, nonatomic) IBOutlet UIImageView *shopPhoto;
@property (strong, nonatomic) NSString* busID;

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
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    NSLog(@"DeviceID ---- \n %@", currentDeviceId);
    NSLog(@"Business ID pre-post ---- \n %@", self.busID);
    
    //    NSString *Post = [[NSString alloc] initWithFormat:@"&bizid=%@&deviceid=%@&like=0", self.busID, currentDeviceId];
    //
    //    NSString *urlString = [NSString stringWithFormat:@"http://hereforbeer.io/hbn/index.php?command=clientresponse&bizid=%@&deviceid=%@&like=0", self.busID, currentDeviceId];
    //
    //    NSURL *url = [NSURL URLWithString:urlString];
    //
    //    NSLog(urlString);
    //
    //    NSString *post = [NSString stringWithFormat:@"&bizid=%@&deviceid=%@&like=0", self.busID, currentDeviceId];
    
    //
    
    NSString *post =[[NSString alloc] initWithFormat:@"http://hereforbeer.io/hbn/index.php?command=clientresponse&bizId=%@&deviceId=%@&like=TRUE", self.busID, currentDeviceId];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSLog(post);
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
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

- (IBAction)mapsButton:(id)sender {
}

- (void)populateTextViewsForDictionary {
    
    int dataRange = [self.results count];
    int random = arc4random_uniform(dataRange);
    NSDictionary *info = [self.results objectAtIndex:random];
    
    NSString *photoReference = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"photos.photo_reference"]];
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

    self.shopTitle.text = [info valueForKey:@"name"];
    self.shopAddress.text = [info valueForKey:@"formatted_address"];
    self.shopPrice.text = @"Price";
    
    if ([info valueForKey:@"price_level"] == nil) {
        self.shopPriceValue.text = @"Unrated";
        self.shopPrice.text = @"Price";
    } else {
    NSString *price = [NSString stringWithFormat:@"%@", [info valueForKey:@"price_level"]];
    self.shopPriceValue.text = price;
    self.shopPrice.text = @"Price";
        
        self.busID = [info valueForKey:@"id"];
        NSLog(@"Business ID ---- \n %@", [info valueForKey:@"id"]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
