//
//  MessageUnity.m
//  FaceIDPlugin
//
//  Created by Nikola Serafimovski on 3/25/20.
//  Copyright © 2020 Nikola Serafimovski. All rights reserved.
//
#import <MessageUnity.h>
#import <Foundation/Foundation.h>

@implementation MessageUnity

+ (void)sendMessage:(const char*)target methodName:(const char*)method messageParameter: (const char*)message {
    UnitySendMessage(target, method, message);
}

@end
