//
//  VehicleCategory.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

struct VehicleCategory: Decodable {
    let name: String?
    let value : Int?
}
class VehicleCategoryProvider {
    var delegate : CategoryDownloaderDelegate?
    var vehicleCategories = [VehicleCategory]() {
        didSet{
            delegate?.didFinishDownloading(self)
        }
    }
    
    private func readJsonFromRequest(apiKey: String) {
        let categiesUrl = URL(string: "https://developers.ria.com/auto/categories/?api_key=\(apiKey)")
        URLSession.shared.dataTask(with: categiesUrl!) { (data, response, err) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.vehicleCategories = try decoder.decode([VehicleCategory].self, from: data)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    func getData(apiKey: String){
        DispatchQueue.global().async {
            self.readJsonFromRequest(apiKey: apiKey)
        }
    }
}
