//
//  ViewController.swift
//  R2020Bokete01
//
//  Created by 中塚富士雄 on 2020/06/11.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos


class ViewController: UIViewController {
   
    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
    super.viewDidLoad()
       
        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization{(status) in switch(status){
            
        case.authorized: break
        case.denied: break
        case.notDetermined: break
        case.restricted: break
            
            
            }
            
        }
   
        getImages(keyword: "funny")
        
    }
    func getImages(keyword:String){
        
        let url = "https://pixabay.com/api/?key=2963093-768f9ffc11d874c5a568a82ee&q=\(keyword)"
        
        AF.request(url,method: .get,parameters: nil ,encoding: JSONEncoding.default).responseJSON{
            (response) in
            
            switch response.result{
                
            case.success:
                let json:JSON = JSON(response.data as Any)
            
                let imageString = json["hits"][self.count]["webformatURL"].string
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
            case.failure(let error):
                
                print(error)
                
            }
            
        }
    }
    
    @IBAction func nextOdai(_ sender: Any) {
        count = count + 1
 
        if searchTextField.text == ""{
            
            getImages(keyword: "funny")
            
        }else{
            
            getImages(keyword: searchTextField.text!)
            
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
       
        if searchTextField.text == ""{
            
            getImages(keyword: "funny")
            
        }else{
            
            getImages(keyword: searchTextField.text!)
            
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    
    
    
    
}

