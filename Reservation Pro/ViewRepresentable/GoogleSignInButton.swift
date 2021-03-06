//
//  GoogleSignInButton.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/20/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import SwiftUI
import Firebase

struct GoogleSignInButton: UIViewRepresentable {
    var colorScheme: ColorScheme
    let onSignIn: (String, String) -> Void
    func makeUIView(context: Context) -> GIDSignInButton {
        let btn = GIDSignInButton()
        btn.colorScheme = colorScheme == .dark ? .dark : .light
        btn.style = .standard
        return btn
    }
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(onSignIn: onSignIn)
    }
    
    class Coordinator: NSObject, GIDSignInUIDelegate, GIDSignInDelegate {
        var onSignIn: (String, String) -> Void
        init(onSignIn: @escaping (String, String) -> Void) {
            self.onSignIn = onSignIn
            super.init()
            GIDSignIn.sharedInstance()?.uiDelegate = self
            GIDSignIn.sharedInstance()?.delegate = self
            DispatchQueue.main.async {
                GIDSignIn.sharedInstance()?.signInSilently()
            }
        }
        func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
            
        }
        func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
            
        }
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if error != nil {
                print("Google sign in error: \(error.debugDescription)")
                return
            }
            print("Success! Signed in user \(signIn.currentUser.userID ?? " X - There was an issue and there is no current user or userID")")
            onSignIn(signIn.currentUser.userID, user.profile.givenName)
        }
    }
}
