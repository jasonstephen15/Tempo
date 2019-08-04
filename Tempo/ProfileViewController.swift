//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jason Stephen on 4/24/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    var programVar : String?
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + programVar!
        ]
        
        //https://api.spotify.com/v1/users/jasonstephen15/playlists
        
        Alamofire.request("https://api.spotify.com/v1/me", method: .get, headers: headers).responseJSON { response in
            debugPrint(response)
            
            let value = response.result.value as? NSDictionary
            let title = value!["display_name"] as? String
            self.name = title
            
            if response.result.value != nil {
                //print("JSON: \(json)") // serialized json response
               
            }
            
            print(title ?? String());
            self.usernameLabel.text = self.name

            
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBAction func onCreatePlaylist(_ sender: Any) {
        
        usernameLabel.text = name
        
        //self.performSegue(withIdentifier: "makePlaylist", sender: self)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a variable that you want to send
        let token = String(programVar!)
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! CreatePlaylistViewController
        
        destinationVC.token = token
    }

}
