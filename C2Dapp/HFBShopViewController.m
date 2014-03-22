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
    
    // Get a random object from data
    int dataRange = [self.results count];
    int random = arc4random_uniform(dataRange);
    NSDictionary *info = [self.results objectAtIndex:random];
    
    self.title = [info valueForKey:@"name"];
    self.shopTitle.text = [info valueForKey:@"name"];
    self.shopAddress.text = [info valueForKey:@"formatted_address"];
    self.shopPriceValue.text = [info valueForKey:@"price_level"];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
