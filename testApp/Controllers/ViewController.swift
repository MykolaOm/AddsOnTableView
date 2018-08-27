//
//  ViewController.swift
//  testApp
//
//  Created by Nikolas Omelianov on 26.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func ChangeCategory(_ sender: UIBarButtonItem) {
        let alerts = setAction(for: (vehicleCategoryProvider?.vehicleCategories)!, completion: completionHandler)
        let sheet = UIAlertController(title: "Choose category", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        for i in alerts{ sheet.addAction(i)}
        sheet.addAction(cancelAction)

        present(sheet, animated: true, completion: nil)
    }
    var autoIdList = Array(repeating: [0], count: 10)
    var counter = 2
    var Category = 1 {
        didSet {
            runAnimation()
        }
    } // Current
    var loadingAnimation : LoadingAnimation?
    var addListDataProvider : AddListDataProvider?
    var vehicleCategoryProvider : VehicleCategoryProvider?
    @IBOutlet weak var tableView: UITableView!
    let apiKey = "irANvvm417wSVw1hpjkeJ0mIzerpuCCvymjGVayg"
    var images : [[UIImage]] = Array(repeating: [], count: 10){
        didSet{
            if images[Category].count == 10 {
                counter += 1
                DispatchQueue.global().async {
                    for i in self.autoIdList[self.counter]{
                        self.requestAutoId(autoId: i )
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                runReq()
            }
        }
    }
    var imageIndex = 0
    var flag = false {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        autoIdList[Category] = [22605321,22120467,21674958,22483876,22598634,22118840,22373506,21916108,22488599,22576592]
        autoIdList[2] = [22583002,21789246,22224641,22591406,22025092,22588400,22411438,22595026,18207896,17487737]
        loadingAnimation = LoadingAnimation()
        tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        addListDataProvider = AddListDataProvider()
        vehicleCategoryProvider = VehicleCategoryProvider()
        vehicleCategoryProvider?.getData(apiKey: apiKey)
    }
    var AddsData : [[AddData]] = Array(repeating: [], count: 10){
        didSet{
            if AddsData[Category].count == autoIdList[Category].count {
                for i in 0..<AddsData[Category].count {
                   getImage(at: AddsData[Category][i].imageURL )
                }
                flag = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoIdList[Category].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let AddCell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddCell {
            DispatchQueue.global().async {
                self.requestAutoId(autoId: self.autoIdList[self.Category][indexPath.row])
                
                    DispatchQueue.main.async {
                        if !self.AddsData[self.Category].isEmpty, indexPath.row < self.AddsData[self.Category].count{
                            AddCell.populate(with: self.AddsData[self.Category][indexPath.row])
                        tableView.reloadInputViews()
                        }
                    }
            }
            if flag == true {
                if images[Category].count > indexPath.row{
                    AddCell.carImage.image = images[Category][indexPath.row]
                }
            }
            if images[Category].count > indexPath.row {
            AddCell.carImage.image = images[Category][indexPath.row]
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
//                if self.AddsData[self.Category].count < self.autoIdList[self.Category].count {
                self.AddsData[self.Category].append(carAddInfo)
//            }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    func getImage(at imgurl: String){
        let url = URL(string: imgurl)
        if let data = try? Data(contentsOf: url!) {
            self.images[Category].append(UIImage(data: data)!)
        }
    }
    func setAction(for type : [VehicleCategory], completion: @escaping (Int) -> Void ) -> [UIAlertAction]{
        var alerts = [UIAlertAction]()
        for i in type {
            alerts.append(UIAlertAction(title: i.name, style: .default){ _ in completion(i.value!)})
        }
        return alerts
    }
    func completionHandler(value: Int) {
        self.Category = value
        DispatchQueue.global().async { [weak self] in
            self?.addListDataProvider?.readJsonFromRequest(apiKey: (self?.apiKey)!, categoryId: (self?.Category)!)
            if !(self?.addListDataProvider?.AdvertIdList.isEmpty)! {
                self?.autoIdList[(self?.Category)!] = (self?.addListDataProvider?.AdvertIdList)!
            }
        }
    }
    func runAnimation(){
        self.view.addSubview((loadingAnimation?.addTickLayer())!)
        perform( #selector(removeAnimation), with: nil, afterDelay: 4)
        perform(#selector(runReq), with: nil, afterDelay: 1)
        
    }
    @objc func removeAnimation(){
        self.view.subviews.last?.removeFromSuperview()
    }
    @objc func runReq(){
        for i in autoIdList[Category]{
            requestAutoId(autoId: i )
        }
    }
}


