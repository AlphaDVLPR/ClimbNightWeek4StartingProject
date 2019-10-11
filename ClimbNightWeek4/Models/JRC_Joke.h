//
//  JRC_Joke.h
//  ClimbNightWeek4
//
//  Created by AlphaDVLPR on 10/10/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JRC_Joke : NSObject

//MARK: - Properties
@property (nonatomic, copy, readonly) NSString *joke;
@property (nonatomic, copy, readonly) NSArray <NSString *> *categories;

//MARK: - Memberwise Initializer
- (instancetype) initWithJoke:(NSString *)joke
                   categories:(NSArray <NSString *> *)categories;

@end

@interface JRC_Joke (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
