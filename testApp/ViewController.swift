//
//  ViewController.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let autoIdList : [Int] = [22605321,22120467,21674958,22483876,22598634,22118840,22373506,21916108,22488599,22576592]    
    @IBOutlet weak var tableView: UITableView!
    let apiKey = "irANvvm417wSVw1hpjkeJ0mIzerpuCCvymjGVayg"
    var images : [UIImage] = []
    var imageIndex = 0
    var flag = false {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
    }
    var AddsData : [AddData] = []{
        didSet{
            if AddsData.count == autoIdList.count {
                for i in 0..<AddsData.count {
                   getImage(at: AddsData[i].imageURL )
                }
                flag = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
//            AddCell.carImage.image = self.images[indexPath.row]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoIdList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let AddCell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddCell {
            DispatchQueue.global().async {
                self.requestAutoId(autoId: self.autoIdList[indexPath.row])
                
                    DispatchQueue.main.async {
                        if !self.AddsData.isEmpty, indexPath.row < self.AddsData.count{
                        AddCell.populate(with: self.AddsData[indexPath.row])
                        tableView.reloadInputViews()
                        }
                    }
                
            }
            if flag == true {
                AddCell.carImage.image = images[indexPath.row]
            }
            AddCell.icons.forEach({$0.backgroundColor = .red})
            if images.count > indexPath.row {
            AddCell.carImage.image = images[indexPath.row]
                tableView.layoutSubviews()
            }
            cell = AddCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let height = tableView.frame.height < tableView.frame.width ? tableView.frame.height : (tableView.frame.height / 2)
        return height
    }
    
    func requestAutoId(autoId : Int) {
        let categiesUrl = URL(string: "https://developers.ria.com/auto/info?api_key=\(apiKey)&auto_id=\(autoId)")
        URLSession.shared.dataTask(with: categiesUrl!) { (data, response, err) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                let carAddInfo = AddData(json: json)
                if self.AddsData.count < self.autoIdList.count {self.AddsData.append(carAddInfo)}
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    func getImage(at imgurl: String){
        let url = URL(string: imgurl)
            if let data = try? Data(contentsOf: url!) {
                self.images.append(UIImage(data: data)!)
            }
  
    }
}


