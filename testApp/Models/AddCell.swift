//
//  AddCell.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class AddCell: UITableViewCell,Configurable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var priceD: UILabel!
    @IBOutlet weak var priceU: UILabel!
    @IBOutlet weak var mileage: UILabel!
    @IBOutlet weak var engineCapacity: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var addDate: UILabel!
    var aV : UIActivityIndicatorView?
    @IBOutlet var icons: [UIImageView]!
    
    @IBOutlet weak var carImage: UIImageView! {
        didSet{
            if aV != nil{
                aV?.stopAnimating()
            }
        }
    }
    let identifier = "AddCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aV = UIActivityIndicatorView(frame: carImage.frame)
        aV?.color = .blue
        aV?.alpha = 0.7
        aV?.startAnimating()
        self.addSubview(aV!)
    }
    func populate(with add: AddData){
        self.title.text = add.title + " " + String(add.year)
        let prcU = setprice(input: String(add.UAH))
        self.priceU.text = " / \(prcU) грн"
        let prcD = setprice(input: String(add.USD))
        self.priceD.text = "\(prcD) $"
        self.priceD.textColor = .green
        self.mileage.text = " " + add.race
        self.transmission.text = " " + add.gearboxName
        self.engineCapacity.text = " " + add.engineCapacity
        self.city.text = " " + add.locationCityName
        let date = String(add.addDate.dropLast(8))
        self.addDate.text = " " + setDate(str: date)
        self.addDate.alpha = 0.7
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text?.removeAll()
        priceU.text?.removeAll()
        priceD.text?.removeAll()
        mileage.text?.removeAll()
        engineCapacity.text?.removeAll()
        city.text?.removeAll()
        transmission.text?.removeAll()
        addDate.text?.removeAll()
        carImage.image = nil
        aV = nil
        icons = nil
    }
    
    private func setprice(input: String) -> String {
        var newString = input
        if input.count > 3 {
            newString.insert(" ", at: newString.index(newString.startIndex, offsetBy: input.count - 3 ))
        }
        return newString
    }
    private func setDate(str : String) -> String {
        var newString = str
        newString = str.replacingOccurrences(of: "-", with: ".")
        return newString
    }
}
