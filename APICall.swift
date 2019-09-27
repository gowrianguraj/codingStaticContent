//
//  APICall.swift
//  SwiftyImageCacheDemo
//
//  Created by gowri anguraj on 27/09/19.
//

import UIKit
class APICall : UIViewController {
    
    func callAPI() {
        let urlString = URL(string: "Http://gateway.marvel.com/v1/public/characters?ts=1&apikey=76341f1dd7916149a0f211e9ee12e0c3&hash=dc314c8ed2aa9f3786bb7f0bdf1e68e9")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let data = data {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print(jsonString)
                            
                            let json = try! JSONSerialization.jsonObject(with:data, options :[]) as! [String:Any]
                            if let respdict = json as? [String : Any] {
                                //respone in dictionary format
                                print(respdict)
                                if let content = json["thumbnail"] as? [[String:String]] {
                                    for category in content {
                                        let id = category["extension"]
                                        let name =  category["path"]
                                        let parentId =  category["name"]
                                        print(id! , name!, parentId!)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
            }
            task.resume()
    }
}

}
