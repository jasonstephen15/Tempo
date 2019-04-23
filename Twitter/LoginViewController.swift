//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jason Stephen on 2/23/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, SPTSessionManagerDelegate {

    fileprivate let SpotifyClientID = "1387473f6a5f4ac38e34153b0cb4df83"
    fileprivate let SpotifyRedirectURI = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURI)
        // Set the playURI to a non-nil value so that Spotify plays music after authenticating and App Remote can connect
        // otherwise another app switch will be required
        configuration.playURI = ""
        
        // Set these url's to your backend which contains the secret to exchange for an access token
        // You can use the provided ruby script spotify_token_swap.rb for testing purposes
        configuration.tokenSwapURL = URL(string: "https://amethyst-plain.glitch.me/api/token")
        configuration.tokenRefreshURL = URL(string: "https://amethyst-plain.glitch.me/api/refresh_token")
        return configuration
    }()
    
    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()

    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("success", session)
    }
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("fail", error)
    }
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("renewed", session)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
 
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        return true
    }
}
