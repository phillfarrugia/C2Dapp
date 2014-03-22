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
    
    [self populateTextViewsForDictionary];
}

- (void)populateTextViewsForDictionary {
    // Get a random object from data
    int dataRange = [self.results count];
    int random = arc4random_uniform(dataRange);
    NSDictionary *info = [self.results objectAtIndex:random];
    self.title = [info valueForKey:@"name"];
    self.shopTitle.text = [info valueForKey:@"name"];
    self.shopAddress.text = [info valueForKey:@"formatted_address"];
    self.shopPriceValue.text = [info valueForKey:@"price_level"];
    
    NSString *photoReference = [info valueForKeyPath:@"photos.photo_reference"];
    
    NSString* photoURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&sensor=true&key=AIzaSyBmGfUedBA9Zm61R8KH9asr8Nf7arolcIc&photoreference=%@", [info valueForKeyPath:@"photos.photo_reference"]];
    
    NSLog(photoURL);
    
    // Fetch Data from Google Places API
    _photoURL = [[HFBPhotoFeed alloc] initFromURLWithString:photoURL
                                                 completion:^(JSONModel *model, JSONModelError *err) {
                                                     
                                                     // Display in console
                                                     NSLog(@"%@", _photoURL);
                                                 }];
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
