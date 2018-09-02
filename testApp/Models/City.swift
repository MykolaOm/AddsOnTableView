//
//  City.swift
//  testApp
//
//  Created by Nikolas Omelianov on 02.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import Foundation

struct City {
    let name : String
    let latitude : Double
    let longitude : Double
    /** let geoApiKey = z08sxTeQAddYWAMRAMFHkwsFv2cepIEl */
    /**http://open.mapquestapi.com/geocoding/v1/address?key=\(geoApi)&location=Vinnitsia*/
    init(json: [String: Any]){
        let r = json["result"] as? [Int: Any]
        let arr = r![0] as? [String: Any]
        let prl = arr!["providerLocation"] as? [String: Any]
        name = (prl!["location"] as? String)!
        let loc = arr!["locations"] as? [Int:Any]
        let data = loc![0] as? [String: Any]
        let coord = data!["latLng"] as? [String: Any]
        latitude = (coord!["latitude"] as? Double)!
        longitude = (coord!["longitude"] as? Double)!
    }
}

