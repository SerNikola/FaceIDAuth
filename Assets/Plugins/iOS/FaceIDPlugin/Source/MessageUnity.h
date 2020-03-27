////
////  MessageUnity.m
////  FaceIDLibrary
////
////  Created by Nikola Serafimovski on 3/25/20.
////  Copyright © 2020 Nikola Serafimovski. All rights reserved.
////

#import <Foundation/Foundation.h>

@interface MessageUnity : NSObject

+ (void)sendMessage:(const char*)target methodName:(const char*)method messageParameter: (const char*)message;
@end
