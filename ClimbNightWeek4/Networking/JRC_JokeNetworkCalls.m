//
//  JRC_JokeNetworkCalls.m
//  ClimbNightWeek4
//
//  Created by AlphaDVLPR on 10/10/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import "JRC_JokeNetworkCalls.h"

//MARK: - Coding Keys
static NSString * const kBaseUrlString = @"https://api.icndb.com";
static NSString * const kJokes = @"jokes";
static NSString * const kRandom = @"random";
static NSString * const firstNameKey = @"firstName";
static NSString * const lastNameKey = @"lastName";
static NSString * const limitToCategoriesString = @"limitTo";
static NSString * const kNerdy = @"[nerdy]";

@implementation JRC_JokeNetworkCalls

+ (void)fetchJokeWithFirstName:(NSString *)firstName lastName:(NSString *)lastName numberOfJokes:(NSInteger)numberOfJokes completion:(void (^)(NSArray<JRC_Joke *> *))completion
{
    //Build The URl
    NSURL *baseUrl = [NSURL URLWithString:kBaseUrlString];
    NSURL *jokesComponent = [baseUrl URLByAppendingPathComponent:kJokes];
    NSURL *randomComponent = [jokesComponent URLByAppendingPathComponent:kRandom];
    NSURL *numberOfJokesUrl = [randomComponent URLByAppendingPathComponent:[NSString stringWithFormat:@"%li", (long)numberOfJokes ]];
    NSURLQueryItem *firstNameQueryItem = [NSURLQueryItem queryItemWithName:firstNameKey value:firstName];
    NSURLQueryItem *lastNameQueryItem = [NSURLQueryItem queryItemWithName:lastNameKey value:lastName];
    NSURLQueryItem *limitToQueryItem = [NSURLQueryItem queryItemWithName:limitToCategoriesString value:kNerdy];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:numberOfJokesUrl resolvingAgainstBaseURL:true];
    urlComponents.queryItems = @[firstNameQueryItem, lastNameQueryItem, limitToQueryItem];
    NSURL *finalUrl = urlComponents.URL;
    
    //Start The URL Session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Handle errors
        if (error) {
            NSLog(@"error with url session method <fetchJokeWithFirstName> : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        //Handle the response
        if (response) {
            NSLog(@"error with response method <fetchJokeWithFirstName> : %@", response);
        }
        //Handle the data
        if (!data) {
            NSLog(@"There was an error retrieving the data for the method <fetchJokeWithFirstName> : %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        //Now we can parse through the JSON
        NSDictionary *jokesTopLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *levelDownArray = jokesTopLevelDictionary[@"value"];
        
        if (!jokesTopLevelDictionary) {
            NSLog(@"Error passing the JSON %@", error);
            completion(nil);
            return;
        }
        
        NSMutableArray *jokesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *jokeDictionary in levelDownArray) {
            JRC_Joke *joke = [[JRC_Joke alloc] initWithDictionary:jokeDictionary];
            [jokesArray addObject:joke];
        }
        completion(jokesArray);
    }] resume];
}

@end
