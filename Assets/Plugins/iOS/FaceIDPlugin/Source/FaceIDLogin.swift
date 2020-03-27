//
//  FaceIDFramework.swift
//  FaceIDFramework
//
//  Created by Nikola Serafimovski on 3/25/20.
//  Copyright © 2020 Nikola Serafimovski. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit


@objc(SWIFTFaceIDLogin)
public class FaceIDLogin : NSObject {
    @objc public static let shared = FaceIDLogin()
    
     @objc var context = LAContext()
        let targetGO = "FaceIDManager"
        /// The available states of being logged in or not.
        enum AuthenticationState : String {
            case loggedin = "loggedin", loggedout = "loggedout"
        }
        
        var state = AuthenticationState.loggedout {

            // Update the UI on a change.
            didSet {
                self.stateValue = state.rawValue
                stateChanged()
            }
        }
        
        @objc var stateValue : String = "loggedout"
    
        @objc public func setup() {
            context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)

            state = .loggedout
        }
    @objc public func stateChanged() {
            MessageUnity.sendMessage(targetGO, methodName: "SetAuthState", messageParameter: self.stateValue)
            MessageUnity.sendMessage(targetGO, methodName: "SetHasFaceID", messageParameter: (context.biometryType == .faceID).description)
        }
        
    @objc public func faceLogin() {
            context = LAContext()

            context.localizedCancelTitle = "Enter Username/Password"

            // First check if we have the needed hardware support.
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                    if success {
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedin
                        }

                        MessageUnity.sendMessage(self.targetGO, methodName: "SetLoginSuccess", messageParameter: success.description)

                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")

                        // Fall back to a asking for username and password.
                        // ...
                        MessageUnity.sendMessage(self.targetGO, methodName: "SetLoginSuccess", messageParameter: error?.localizedDescription ?? "Failed to authenticate")

                    }
                    
                }
            } else {
                print(error?.localizedDescription ?? "Can't evaluate policy")

                MessageUnity.sendMessage(self.targetGO, methodName: "SetLoginSuccess", messageParameter: error?.localizedDescription ?? "Can't evaluate policy")
                // Fall back to a asking for username and password.
                // ...
            }
        }
}
