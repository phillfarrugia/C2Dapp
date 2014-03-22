//
//  HFBFeed.h
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "JSONModel.h"
#import "HFBDataModel.h"

@interface HFBFeed : JSONModel

@property (strong, nonatomic) NSArray<HFBDataModel>* results;

@end
