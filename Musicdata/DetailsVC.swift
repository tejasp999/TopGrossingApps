//
//  DetailsVC.swift
//  Musicdata
//
//  Created by Teja PV on 3/6/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class DetailsVC: UIViewController {
    var valuePassed:JSON!
    var imagePassed:UIImage!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var appURL: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var artistURL: UILabel!
    @IBOutlet weak var artistName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistURL.text = "Artist URL :" + " " + valuePassed["artistUrl"].stringValue
        self.artistName.text = "Artist Name :" + " " + valuePassed["artistName"].stringValue
        self.appIcon.image = imagePassed
        self.releaseDate.text = "Release date :" + " " + valuePassed["releaseDate"].stringValue
        self.appURL.text = "App URL :" + " " + valuePassed["url"].stringValue
        // Do any additional setup after loading the view.
    }
    func loadProduct(jsonDict : JSON, imageSetter : UIImage){
        
    }

}
