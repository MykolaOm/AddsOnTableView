//
//  AddTableVC.swift
//  testApp
//
//  Created by Nikolas Omelianov on 01.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class AddTableVC: UITableViewController, AddListDataProviderDelegate, ErrorDelegate{
    func showError() {
        errorCell = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    lazy var refresh : UIRefreshControl = {
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.tintColor = .blue
        refreshcontrol.addTarget(self, action: #selector(reload), for: .valueChanged )
        return refreshcontrol
    }()
    @objc private func reload(){
        tableView.reloadData()
        refresh.endRefreshing()
    }
    var errorCell = false
    
    func didFinish(_ sender: AddListDataProvider){
        getData()
    }
    var numberOfSections = 0
    var addListDataProvider : AddListDataProvider?
    var category = 1
    var apiKey : String?
    var categoryName: String?
    var addsData = [AddData]() {
        didSet {
            if addsData.count == addListDataProvider?.advertIdList.count{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    var images = Array(repeating: UIImage(), count: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        setNeedsStatusBarAppearanceUpdate()
        let cellNib = UINib(nibName: "AddCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "AddCell")
        tableView.refreshControl = refresh
        addListDataProvider = AddListDataProvider()
        addListDataProvider?.delegate = self
        addListDataProvider?.errorDelegate = self
        addListDataProvider?.readJsonFromRequest(apiKey: self.apiKey!, categoryId: self.category)
        tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let numRows = (errorCell == true ? 1 : addsData.count)
        return numRows
    }
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tVW = self.tableView.frame.width
        var tVH = self.tableView.frame.height
        if let barH = self.navigationController?.navigationBar.frame.height
        {  tVH -= barH  }
        var height = Int(tVH) < Int(tVW) ? tVH : tVH / 2
        if errorCell { height = 20}
            return height
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if errorCell {
            cell.textLabel?.text = "connection error"
        } else {
            if !addsData.isEmpty {
                if let AddCell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddCell {
                    if addsData.count > indexPath.row {
                        AddCell.populate(with: self.addsData[indexPath.row])
                    DispatchQueue.global().async {
                        let image = self.getImage(at: (self.addsData[indexPath.row].imageURL))
                        DispatchQueue.main.async {
                            AddCell.carImage.image = image
                        }
                    }
                    cell = AddCell
                    }
                }
            }
        }
        return cell
    }

    func requestAutoId(autoId : Int) {
        let categiesUrl = URL(string: "https://developers.ria.com/auto/info?api_key=\(self.apiKey!)&auto_id=\(autoId)")
        URLSession.shared.dataTask(with: categiesUrl!) { (data, response, err) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                let carAddInfo = AddData(json: json)
                if self.addsData.count < (self.addListDataProvider?.advertIdList.count)! {
                    self.addsData.append(carAddInfo)
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    func getImage(at imgurl: String)->UIImage {
        var image = UIImage()
        let url = URL(string: imgurl)
        if let data = try? Data(contentsOf: url!) {
            image = UIImage(data: data)!
        }
        return image
    }
    private func getData() {
        DispatchQueue.global().async {
            for i in (self.addListDataProvider?.advertIdList)! {
                self.requestAutoId(autoId: i )
            }
        }
    }
}
