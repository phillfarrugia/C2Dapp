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
    // Log data in console
    NSLog(@"OMG DATA \n %@", self.results);
    
    [self makeJSONRequest];
    
    //[self populateTextViewsForDictionary:self.results];
}

- (void)makeJSONRequest
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSData* data = [NSData dataWithContentsOfURL:
                                       [NSURL URLWithString:[NSString stringWithFormat:
                                                             @"http://hereforbeer.io/test-google-json.json"]]];
                       [self performSelectorOnMainThread:@selector(fetchedData:)
                                              withObject:data waitUntilDone:YES];
                   });
}


- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    self.results= [json objectForKey:@"results"];
    [self populateTextViewsForDictionary];
}

- (void)populateTextViewsForDictionary {
    
    int dataRange = [self.results count];
    int random = arc4random_uniform(dataRange);
    NSDictionary *info = [self.results objectAtIndex:random];
    
    
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
    
    NSLog(@"INFO ------ \n %@", info);
    
    self.shopTitle.text = [info valueForKey:@"name"];
    self.shopAddress.text = [info valueForKey:@"formatted_address"];
    
    NSString *price = [NSString stringWithFormat:@"%@", [info valueForKey:@"price_level"]];
   self.shopPriceValue.text = price;
    NSLog(@"HI");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackGesture:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
