//
//  CreatePlaylistViewController.swift
//  Twitter
//
//  Created by Jason Stephen on 4/24/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import Alamofire

class CreatePlaylistViewController: UIViewController {
    
    @IBOutlet weak var hostField: UITextField!
    @IBOutlet weak var guestnameField: UITextField!
    
    
    var token : String?
    var playlistArray = [String]();
    var nameList = [String]();
    var uriList = [String]();
    var counter = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter=0;
        print(token as Any)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitInfo(_ sender: Any) {
        
        let guestname = guestnameField.text!
        print(guestnameField.text!)
        
        
        
        var url = "https://api.spotify.com/v1/users/" + guestname + "/playlists"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
            //            debugPrint(response)
        
            let value = response.result.value as! NSDictionary
            let items = value["items"] as! [NSDictionary]
            var idArray = [String]();
        
            for item in items{
                idArray.append(item["id"] as! String)
            }
        
            self.playlistArray = idArray
        
            //            if let json = response.result.value {
            //                //print("JSON: \(json)") // serialized json response
            //            }
        
        
            for playlist in self.playlistArray {
                url = "https://api.spotify.com/v1/playlists/" + playlist + "/tracks"
                Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
                    let value = response.result.value as! NSDictionary
                    let items = value["items"] as! [NSDictionary]
        
                    var trackArray = [NSDictionary]();
        
                    for item in items{
                        trackArray.append(item["track"] as! NSDictionary)
                    }
        
                    for track in trackArray{
                        self.nameList.append(track["name"] as! String)
                        self.uriList.append(track["uri"] as! String)
                        
                    }
                    
                    //print(self.nameList)

                }
            }
            
        print(self.nameList)
            
            
            self.counter += 1;
            
            //print(self.counter)
            
            if(self.counter%2 == 0){
                
                self.performSegue(withIdentifier: "showPlaylist", sender: "NavigationController")

            }
        
        }
    
    
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a variable that you want to send
        let token2 = String(token!)
        let listOfNames = nameList
        let listOfUris = uriList
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! ShowPlaylistViewController
        
        destinationVC.token = token2
        destinationVC.nameList = listOfNames
        destinationVC.uriList = listOfUris
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if ((self.counter > 0) && (self.counter % 2 == 0)){
            return true
        }
        return false
    }

}
