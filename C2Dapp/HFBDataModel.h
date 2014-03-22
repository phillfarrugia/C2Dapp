//
//  HFBDataModel.h
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "JSONModel.h"
#import "HFBGeometryModel.h"
#import "HFBOpenHoursModel.h"

@protocol HFBDataModel @end

@interface HFBDataModel : JSONModel

@property (strong, nonatomic) NSString* formatted_address;

// Geometry Model
@property (strong, nonatomic) HFBGeometryModel* geometry;

@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSString* name;

//@property (strong, nonatomic) HFBOpenHoursModel* open_now;

//@property (strong, nonatomic) NSString* website;
//@property (strong, nonatomic) NSString* vicinity;
//@property (strong, nonatomic) NSString* formatted_phone_number;

@property (strong, nonatomic) NSString<Optional>* price_level;
//@property (assign, nonatomic) double rating;

@property (strong, nonatomic) NSArray* types;

@property (strong, nonatomic) NSArray* photos;

// TODO: Add Photo Requests
//@property (strong, nonatomic) NSArray* photos;
//@property (assign, nonatomic) int width;
//@property (assign, nonatomic) int height;

@end

