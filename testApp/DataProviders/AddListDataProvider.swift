//
//  AddListDataProvider.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import Foundation

class AddListDataProvider {
    var delegate: AddListDataProviderDelegate?
    var advertIdList : [Int] = [] {
        didSet{
            if advertIdList.count == AdvertIds.count{
                self.delegate?.didFinish(self)
            }
        }
    }
    var AdvertIds = Set<Int>()
    var errorDelegate : ErrorDelegate?
    
    func readJsonFromRequest(apiKey: String,categoryId : Int = 1) {
        let categiesUrl = URL(string: "https://developers.ria.com/auto/search?api_key=\(apiKey)&category_id=\(categoryId)&with_photo=1")
        URLSession.shared.dataTask(with: categiesUrl!) { (data, response, err) in
            var responceCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                responceCode = Int(httpResponse.statusCode)
            }
            if responceCode == 200 {
                guard let data = data else { return }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    var r = json["result"] as? [String: Any]
                    let sr = r!["search_result"] as? [String:Any] ?? ["": ""]
                    let ids = sr["ids"] as? [String] ?? [""]
                    for item in ids {
                            self.AdvertIds.insert(Int(item)!)
                    }
                    for item in self.AdvertIds {
                        self.advertIdList.append(item)
                    }
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            } else {
                print ("bad responce! code: ",responceCode)
                self.errorDelegate?.showError(type: httpError.limitOveral)
            }
        }.resume()
        
    }
}
