//
//  ShowPlaylistViewController.swift
//  Twitter
//
//  Created by Jason Stephen on 5/11/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import Alamofire

import MediaPlayer

class ShowPlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var token : String?
    var nameList = [String]();
    var secnameList = [String]();
    var numWanted = Int();
    var finalnameList = [String]();
    var finaluriList = [String]();
    var avPlayer : AVPlayer!
    var uriList = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
         
        //print(nameList)
        //print(uriList)
        
        var firstlen = nameList.count
        var seclen = secnameList.count
        
        var i = 0
        var j = 0
        
        repeat {
            
            if(i < firstlen){
            finalnameList.append(nameList[i])
            finaluriList.append(uriList[i])
                i += 1;
            }
            if(j < seclen){
            finalnameList.append(secnameList[j])
                finaluriList.append(uriList[j])
                j += 1;
            }
            
            
        } while i+j < numWanted
        
        
        // Do any additional setup after loading the view.
    }
    
    func play(url:NSURL) {
        print("playing \(url)")
        let playerItem = AVPlayerItem(url: url as URL)
        
        self.avPlayer = AVPlayer(playerItem:playerItem)
        self.avPlayer.play()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSong", for: indexPath)
        
        let song = finalnameList[indexPath.row]
        cell.textLabel?.text = song
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalnameList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var url = finaluriList[indexPath.row]
        
        let nsurl = NSURL(string: url)
        play(url: nsurl!)
        //print(nameList)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    @IBAction func onConfirm(_ sender: Any) {
        
        let params : Parameters = [
            "name": "TESTEERRRRR",
            "description": "New playlist description",
            "public": false
        ]
   
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        Alamofire.request("https://api.spotify.com/v1/playlists", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            debugPrint(response)
            
        

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
