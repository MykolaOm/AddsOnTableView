//
//  CategoryVC.swift
//  testApp
//
//  Created by Nikolas Omelianov on 29.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    let addListDataProvider = AddListDataProvider()
    let vcp = VehicleCategoryProvider()
    var actView : UIActivityIndicatorView?
    var stv : UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Выбор категории"
        vcp.delegate = self
        actView = UIActivityIndicatorView(frame: self.view.frame)
        actView?.color = .red
        self.view.addSubview(actView!)
        actView?.startAnimating()
        updData()
    }
    override func viewDidAppear(_ animated: Bool) {
        if !ReachabilityTest.isConnectedToNetwork() {
           showAlert(message: "No internet connection")
        }
    }
    private func updData(){
        vcp.getData(apiKey: ApiAccess.Key.auto)
        setButtonStack()
    }
    private func buttonFactory(amount : [VehicleCategory] ) {
        for i in 0..<amount.count {
            let button = UIButton()
            button.setTitle(amount[i].name, for: .normal)
            button.tag = amount[i].value!
            button.setTitleColor(.blue, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            stv?.addArrangedSubview(button)
        }
    }
    @objc private func buttonAction(sender: UIButton!) {
          let vc = AddTableVC()
          vc.category = sender.tag
          vc.errorCell = false
          vc.categoryName = self.vcp.vehicleCategories[sender.tag-1].name
          self.navigationController?.pushViewController(vc, animated: true)
    }
    private func setButtonStack(){
        stv = UIStackView()
        stv?.translatesAutoresizingMaskIntoConstraints = false
        stv?.center = self.view.center
        stv?.axis = .vertical
        stv?.distribution = .fillEqually
        self.view.addSubview(stv!)
        let anc = self.view.frame.width < self.view.frame.height ?  self.view.frame.width : self.view.frame.height
        stv?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stv?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stv?.widthAnchor.constraint(equalToConstant: anc).isActive = true
        stv?.heightAnchor.constraint(equalToConstant: anc).isActive = true
    }
    private func showAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CategoryVC : CategoryDownloaderDelegate {
    func didFinishDownloading(_ sender: VehicleCategoryProvider) {
        DispatchQueue.main.async {
            self.buttonFactory(amount: self.vcp.vehicleCategories )
            self.actView?.removeFromSuperview()
        }
    }
}
