//
//  ViewController.swift
//  SignInWithAppleID_Demo
//
//  Created by Devubha Manek on 13/11/19.
//  Copyright © 2019 Devubha Manek. All rights reserved.
//

import UIKit
import AuthenticationServices

//MARK: ViewController
class ViewController: UIViewController {

    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        self.setupSignInButton()
    }
    
    //BUtton SetUp
    private func setupSignInButton() {
        let signInButton = ASAuthorizationAppleIDButton()
        signInButton.addTarget(self, action: #selector(ViewController.signInButtonTapped), for: .touchDown)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1),
            signInButton.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}

//MARK: Actions
extension ViewController {
    
    //Tapped On SignIn Button
    @objc private func signInButtonTapped() {
        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request = authorizationProvider.createRequest()
        request.requestedScopes = [.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

//MARK: ASAuthorizationControllerDelegate

extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        print( "userId: \(appleIDCredential.user)","email: \(String(describing: appleIDCredential.email))","fullName: \(String(describing: appleIDCredential.fullName))")
      
        let alert = UIAlertController(title: "Success", message: "Sign In with apple id ", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NextVC") as? NextVC
            nextVC?.strEmail = appleIDCredential.email ?? "Email is Hide"
            nextVC?.strUid = appleIDCredential.user
            self.present(nextVC!, animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
       // print(“AppleID Credential failed with error: \(error.localizedDescription)”)
    }
}

//MARK: ASAuthorizationControllerPresentationContextProviding
extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

