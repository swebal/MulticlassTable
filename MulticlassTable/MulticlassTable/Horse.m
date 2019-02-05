//
//  Horse.m
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#define names       @[@"Bob", @"Joe", @"Sam", @"Bill", @"Niel", @"Jim", @"John", @"Kim", @"Karen", @"Nathalie", @"Rose"]

#import "Horse.h"

@implementation Horse

+ (Horse *)randomHorse {
    int randomIndex = arc4random_uniform((int)names.count);
    NSString *randomName = names[randomIndex];
    Horse *h = [Horse new];
    h.horseName = randomName;
    h.horseStatus = (HorseStatus)arc4random_uniform(2);
    return h;
}

- (id)initWithDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.horseName = data[@"horseName"]; // Samma som att ropa på [data objectForKey:@"horseName"];
        self.horseStatus = [data[@"horseStatus"] intValue];
    }
    return self;
}

- (NSDictionary *)dictionaryFromObject {
    return @{@"horseName":_horseName, @"horseStatus":@(_horseStatus)};
}

@end



