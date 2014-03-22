//
//  HFBGeometryModel.m
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBGeometryModel.h"

@implementation HFBGeometryModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"location.lat": @"lat",
                                                       @"location.lng": @"lng",
                                                       }];
}

@end
