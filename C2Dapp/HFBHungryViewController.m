//
//  HFBHungryViewController.m
//  C2Dapp
//
//  Created by Robin Wohlers-Reichel on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBHungryViewController.h"

@interface HFBHungryViewController ()
@property (weak, nonatomic) IBOutlet UIView *detailView;
- (IBAction)swipeLeft:(id)sender;
@property (strong, nonatomic) NSString* busID;

@end


@implementation HFBHungryViewController

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
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPreviousView:)];
    swipeRight.numberOfTouchesRequired = 1;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    CGRect newFrame = self.detailView.frame;
    newFrame.origin.y += -367;    // shift down by 365pts
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.detailView.frame = newFrame;
                     }];

    [self asyncRequest];
    
}

- (void)gotoPreviousView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)asyncRequest
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSData* data = [NSData dataWithContentsOfURL:
                                       [NSURL URLWithString:[NSString stringWithFormat:
                                                             @"https://maps.googleapis.com/maps/api/place/textsearch/json?query=food&sensor=true&radius=1000&opennow&key=AIzaSyBmGfUedBA9Zm61R8KH9asr8Nf7arolcIc"]]];
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
    
    // Sets values for Shop View in Storyboard from Async Data
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [super populateTextViewsForDictionary];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

-(void)performSegue{
    [self performSegueWithIdentifier:@"shopViewSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(id)sender {
    [self populateTextViewsForDictionary];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    NSLog(@"DeviceID ---- \n %@", currentDeviceId);
        NSLog(@"Business ID pre-post ---- \n %@", self.busID);
    
//    NSString *Post = [[NSString alloc] initWithFormat:@"&bizid=%@&deviceid=%@&like=0", self.busID, currentDeviceId];
//    
//    NSString *urlString = [NSString stringWithFormat:@"http://hereforbeer.io/hbn/index.php?command=clientresponse&bizid=%@&deviceid=%@&like=0", self.busID, currentDeviceId];
//    NSURL *url = [NSURL URLWithString:urlString];


    
    
    
}

@end
