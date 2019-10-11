//
//  JRC_Joke.m
//  ClimbNightWeek4
//
//  Created by AlphaDVLPR on 10/10/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import "JRC_Joke.h"

//MARK: - Coding Keys
static NSString * const kJoke = @"joke";
static NSString * const kCategories = @"categories";

@implementation JRC_Joke

//MARK: - Memberwise Init
- (instancetype)initWithJoke:(NSString *)joke categories:(NSArray<NSString *> *)categories
{
    self = [super init];
    if (self) {
        //What you are initializing example: _name = name
        _joke = joke;
        _categories = categories;
    }
    return self;
}

@end

//MARK: - Conv Init
@implementation JRC_Joke (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *joke = dictionary[kJoke];
    NSArray *categories = dictionary[kCategories];
    
    return [self initWithJoke:joke categories:categories];
}

@end
