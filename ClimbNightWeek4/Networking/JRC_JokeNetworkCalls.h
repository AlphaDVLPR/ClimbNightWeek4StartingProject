//
//  JRC_JokeNetworkCalls.h
//  ClimbNightWeek4
//
//  Created by AlphaDVLPR on 10/10/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRC_Joke.h"

@interface JRC_JokeNetworkCalls : NSObject

+ (void)fetchJokeWithFirstName:(NSString *)firstName lastName:(NSString *)lastName numberOfJokes:(NSInteger)numberOfJokes completion:(void (^) (NSArray<JRC_Joke *> *))completion;



@end

