//
//  HFBMainViewController.m
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBMainViewController.h"
#import "HFBShopViewController.h"
#import "JSONModelLib.h"
#import "HFBDataModel.h"
#import "HFBFeed.h"
#import "FontAwesomeKit/FontAwesomeKit.h"

@interface HFBMainViewController () {

    HFBFeed* _feed;

}
@property (weak, nonatomic) IBOutlet UIImageView *hungryIcon;
@property (weak, nonatomic) IBOutlet UIImageView *boredIcon;
@property (weak, nonatomic) IBOutlet UIImageView *nakedIcon;

@end

@implementation HFBMainViewController

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
    NSLog(@"%@",_formattedLocationString);
    
    // Hungry Icon
    FAKFontAwesome *cutleryIcon = [FAKFontAwesome cutleryIconWithSize:50];
    [cutleryIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                 whiteColor]];
    self.hungryIcon.image = [cutleryIcon imageWithSize:CGSizeMake(50, 50)];
    
    // Bored Icon
    FAKFontAwesome *trophyIcon = [FAKFontAwesome trophyIconWithSize:50];
    [trophyIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                    whiteColor]];
    self.boredIcon.image = [trophyIcon imageWithSize:CGSizeMake(50, 50)];
    
    // Naked Icon
    FAKIonIcons *tagsIcon = [FAKIonIcons pricetagsIconWithSize:45];
    [tagsIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                    whiteColor]];
    self.nakedIcon.image = [tagsIcon imageWithSize:CGSizeMake(45, 45)];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"hViewSegue"]) {
        HFBShopViewController *controller = (HFBShopViewController *)segue.destinationViewController;
        controller.formattedLocationString = self.formattedLocationString;
        controller.latitudeLocationString = self.latitudeLocationString;
        controller.longitudeLocationString = self.longitudeLocationString;
        NSArray *results = _feed.results;
        controller.results = results;
    }
    if ([segue.identifier isEqualToString:@"nViewSegue"]) {
        HFBShopViewController *controller = (HFBShopViewController *)segue.destinationViewController;
        controller.formattedLocationString = self.formattedLocationString;
        controller.latitudeLocationString = self.latitudeLocationString;
        controller.longitudeLocationString = self.longitudeLocationString;
        NSArray *results = _feed.results;
        controller.results = results;
    }
    if ([segue.identifier isEqualToString:@"bViewSegue"]) {
        HFBShopViewController *controller = (HFBShopViewController *)segue.destinationViewController;
        controller.formattedLocationString = self.formattedLocationString;
        controller.latitudeLocationString = self.latitudeLocationString;
        controller.longitudeLocationString = self.longitudeLocationString;
        NSArray *results = _feed.results;
        controller.results = results;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
