//
//  AddListDataProvider.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import Foundation

class AddListDataProvider {
    var AdvertIdList : [Int] = []
    var AdvertIds = Set<Int>()
    
    func readJsonFromRequest(apiKey: String,categoryId : Int = 1) {
        let categiesUrl = URL(string: "https://developers.ria.com/auto/search?api_key=\(apiKey)&category_id=\(categoryId)&with_photo=1")
        URLSession.shared.dataTask(with: categiesUrl!) { (data, response, err) in
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
                    self.AdvertIdList.append(item)
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
        
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
