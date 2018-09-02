//
//  CityInfoDataProvider.swift
//  testApp
//
//  Created by Nikolas Omelianov on 02.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import Foundation

class CityInfoDataProvider {
    var city : City?
    let geoApiKey = "z08sxTeQAddYWAMRAMFHkwsFv2cepIEl"
    func requestAutoId(cityName : String) {
        let categiesUrl = URL(string: "http://open.mapquestapi.com/geocoding/v1/address?key=\(geoApiKey)&location=\(cityName)")
        URLSession.shared.dataTask(with: categiesUrl!) { (data, response, err) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                self.city = City(json: json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
}
