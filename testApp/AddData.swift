//
//  AddData.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

struct AddData: Decodable {
    let locationCityName: String
    let USD : Int
    let UAH : Int
    let addDate : String
    let race : String
    let gearboxName : String
    let year : Int
    let title : String
    let imageURL : String
    let engineCapacity: String
    
    init(json : [String: Any]){
        USD = json["USD"] as? Int ?? 0
        UAH = json["UAH"] as? Int ?? 0
        title = json["title"] as? String ?? ""
        addDate = json["addDate"] as? String ?? ""
        let autoData = json["autoData"] as? [String:Any]
        race = autoData!["race"] as? String ?? ""
        gearboxName = autoData!["gearboxName"] as? String ?? ""
        let photo = json["photoData"] as? [String: Any]
        locationCityName = json["locationCityName"] as? String ?? ""
        year = autoData!["year"] as? Int ?? 0
        imageURL = photo!["seoLinkM"] as? String ?? ""
        engineCapacity = autoData!["fuelName"] as? String ?? ""
    }
}
