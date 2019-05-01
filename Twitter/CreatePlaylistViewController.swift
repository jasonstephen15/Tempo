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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(token as Any)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitInfo(_ sender: Any) {
        
        print(guestnameField.text!)
        
        let guestname = guestnameField.text!
        var url = "https://api.spotify.com/v1/users/" + guestname + "/playlists"
   
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
//            debugPrint(response)
            
            let value = response.result.value as! NSDictionary
            //let title = value!["display_name"] as? String
            //self.name = title
            let items = value["items"] as! [NSDictionary]
            var idArray = [String]();
            
            for item in items{
                print(item["id"] as! String)
                idArray.append(item["id"] as! String)
                
            }
            
            for id in idArray{
                print(id)
            }
            
            self.playlistArray = idArray
            
            if let json = response.result.value {
                 //print("JSON: \(json)") // serialized json response
            }
    
    }
        
        for playlist in playlistArray{
            
            url = "https://api.spotify.com/v1/playlists/" + playlist + "/tracks"
            
            Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
                //            debugPrint(response)
                
                let value = response.result.value as! NSDictionary
                let items = value["items"] as! [NSDictionary]
                var nameArray = [String]();
                var trackArray = [NSDictionary]();
                
                for item in items{
                    print(item["id"] as! String)
                    trackArray.append(item["track"] as! NSDictionary)
                }
                
                for track in trackArray{
                    print(track["name"] as! String)
                }

                
                if let json = response.result.value {
                    //print("JSON: \(json)") // serialized json response
                }
                
            }
        }
        
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
