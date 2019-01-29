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
    Horse *h = [Horse new];
    int randomIndex = arc4random_uniform((int)names.count);
    NSString *randomName = names[randomIndex];
    h.horseName = randomName;
    h.horseStatus = (HorseStatus)arc4random_uniform(2);
    return h;
}


- (NSDictionary *)dictionaryFromObject {
    return @{@"horseName":_horseName, @"horseStatus":@(_horseStatus)};
}

@end



