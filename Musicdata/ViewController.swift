//
//  ViewController.swift
//  Musicdata
//
//  Created by Teja PV on 3/6/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
//Used Alamofire and SwiftyJSON in the Pods
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Used to cache the images downloaded to reduce the memory usage of the app
    var imageCache = [String : UIImage]()
    //Initial Loading Indicator
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    //JSON Dictionary to pass to the next view controller
    var valueToPass:JSON!
    var imageToPass:UIImage!
    //Header and URL
    let HEADER = ["Content-Type":"application/json; charset = utf-8"]
    var Data_URL  = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
    var myNewDictArray: [JSON] = []
    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewDidLoad() {
        getDataFromServer()
    }
    //Initial Call from the server
    func getDataFromServer(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        Alamofire.request(Data_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER)
            .responseJSON { response in
                guard let data = response.data else {return}
                let json = JSON(data)
                print("The feed is",json["feed"])
                let results = json["feed"]
                if json["feed"] != JSON.null
                {
                    if let teamColors = results["results"].array
                    {
                        self.myNewDictArray = teamColors
                        print("The count of newDictArray is",self.myNewDictArray.count)
                        self.categoryTable.reloadData()
                    }
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myNewDictArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell{
            let jsonDict = self.myNewDictArray[indexPath.row]
            cell.artistId.text = jsonDict["artistName"].stringValue
            cell.artistName.text = jsonDict["copyright"].stringValue
            cell.releaseDate.text = jsonDict["releaseDate"].stringValue
            cell.jsonDict = jsonDict
            let imageUrlString = jsonDict["artworkUrl100"].stringValue
            let imageUrl:URL = URL(string: imageUrlString)!
            if let image = self.imageCache[imageUrlString]{
                cell.artistImage.image = image
            }else{
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                    if error != nil{
                        return
                    }
                    let image = UIImage(data: data!)
                    self.imageCache[imageUrlString] = image
                    DispatchQueue.main.async {
                        cell.artistImage.image = UIImage(data: data!)
                    }
                }).resume()
            }
            activityIndicator.stopAnimating()
            return cell
        }else{
            return TableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! TableViewCell
        valueToPass = currentCell.jsonDict
        imageToPass = currentCell.artistImage.image
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsVC{
            detailsVC.imagePassed = imageToPass
            detailsVC.valuePassed = valueToPass
        }
    }
    
}

