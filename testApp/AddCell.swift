//
//  AddCell.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class AddCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var priceD: UILabel!
    @IBOutlet weak var priceU: UILabel!
    @IBOutlet weak var mileage: UILabel!
    @IBOutlet weak var engineCapacity: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var addDate: UILabel!
  
    @IBOutlet var icons: [UIImageView]!
    
    @IBOutlet weak var carImage: UIImageView!
    let identifier = "AddCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carImage.backgroundColor = .yellow
        
    }
    func populate(with add: AddData){
        self.title.text = add.title + " " + String(add.year)
        self.priceU.text = "/\(add.UAH) грн"
        self.priceD.text = "\(add.USD)$"
        self.mileage.text = add.race
        self.transmission.text = add.gearboxName
        self.engineCapacity.text = add.engineCapacity
        self.city.text = add.locationCityName
//        let date =
//        if date.count >= 18 {
//            _ = date.dropLast(8)
//        }
        self.addDate.text = String(add.addDate.dropLast(8))
    }

}
