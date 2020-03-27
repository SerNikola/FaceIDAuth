//
//  FaceIDLibraryBridge.m
//  FaceIDLibrary
//
//  Created by Nikola Serafimovski on 3/25/20.
//  Copyright © 2020 Nikola Serafimovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <FaceIDLogin-Swift.h>

#pragma mark - C interface

extern "C" {

    void setup() {
        [[FaceIDLogin shared] setup];
    }
    void faceLogin() {
        [[FaceIDLogin shared] faceLogin];
    }
}

