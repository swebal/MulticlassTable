//
//  Horse.h
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HorseStatusDead,
    HorseStatusAlive
} HorseStatus;

@interface Horse : NSObject

@property (nonatomic, assign) HorseStatus horseStatus; // int (primitiv typ)
@property (nonatomic, strong) NSString *horseName; // Objekt (glöm ej "strong" och *

+ (Horse *)randomHorse;
- (NSDictionary *)dictionaryFromObject;

@end
