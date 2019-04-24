//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jason Stephen on 2/23/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UIApplicationDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {

    fileprivate let SpotifyClientID = "1387473f6a5f4ac38e34153b0cb4df83"
    fileprivate let SpotifyRedirectURI = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    
    var token = ""
    
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

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("success", session)
        
        
        self.appRemote.connectionParameters.accessToken = session.accessToken
        //print("THIS YOUR TOKEN" + session.accessToken)
        
        token = session.accessToken
        self.appRemote.connect()
        
        self.performSegue(withIdentifier: "loginToHome", sender: self)
    }
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("fail", error)
    }
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("renewed", session)
    }
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
        
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
    }
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func viewDidAppear(_ animated: Bool) {
        
 
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        
        print("Session started")
        
//        Alamofire.request("https://api.spotify.com/v1/users/jasonstephen15/playlists")
//            .response {response in
//                print(response)
//
//        }
        
        
        //ANOTHER TRYYY
        
        
//        fetch("https://api.spotify.com/v1/audio-analysis/6EJiVf7U0p1BBfs0qqeb1f", {
//            method: "GET",
//            headers: {
//                Authorization: `Bearer ${userAccessToken}`
//            }
//        })
//            .then(response => response.json())
//            .then(({beats})) => {
//                beats.forEach((beat, index) => {
//                    console.log(`Beat ${index} starts at ${beat.start}`);
//                    })
//        }
        
        //ANOTHER TRYYYYy
//        let string = "https://api.spotify.com/v1/users/jasonstephen15/playlists"
//        let url = NSURL(string: string)
//        let request = NSMutableURLRequest(url: url! as URL)
//
//        let code = "BQBFuLvjCPwnr3FsIy9CnraG1sTAc"//self.appRemote.connectionParameters.accessToken
//
//        request.setValue("Bearer" + code, forHTTPHeaderField: "Authorization")
//        //request.addValue("clientIDhere", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//
//        let tache = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//            if let antwort = response as? HTTPURLResponse {
//                let code = antwort.statusCode
//                print(code)
//            }
//        }
//        tache.resume()
        
        //ANOTHEEEERRR TRYYYy
        

        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let parameters = ["id": 13, "name": "jack"] as [String : Any]

        //create the url with URL
        let url = URL(string: "https://api.spotify.com/v1/users/jasonstephen15/playlists")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    print("AWESOME!!!")
                    print(json)
                    
                    
                    // handle json...
                }
            } catch let error {
                print("ERRORORROROROROORORORORORRRRR")
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
        
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        return true
    }
}
