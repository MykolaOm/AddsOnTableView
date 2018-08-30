//
//  CategoryVC.swift
//  testApp
//
//  Created by Nikolas Omelianov on 29.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController, CategoryDownloaderDelegate {
  
    func didFinishDownloading(_ sender: VehicleCategoryProvider) {
        DispatchQueue.main.async {
            self.buttonFactory(amount: self.vcp.vehicleCategories )
        }
        
    }
    let vcp = VehicleCategoryProvider()
    let apiKey = "irANvvm417wSVw1hpjkeJ0mIzerpuCCvymjGVayg"
    let actView = UIActivityIndicatorView()

    var stv : UIStackView?
    override func viewDidLoad() {
        super.viewDidLoad()
        vcp.delegate = self
        let actView = UIActivityIndicatorView()
        self.view.addSubview(actView)
        actView.startAnimating()
        vcp.getData(apiKey: apiKey)
        setButtonStack()      
    }
    func buttonFactory(amount : [VehicleCategory] ) { //, completion : @escaping (Int)->Void
        print(amount.count)
        for i in 0..<amount.count {
            let button = UIButton()
            button.setTitle(amount[i].name, for: .normal)
            button.tag = amount[i].value!
            button.backgroundColor = .red
//            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            stv?.addArrangedSubview(button)
        }
    }
    private func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
           // let vc = ViewController()
            //vc
          self.navigationController?.pushViewController(ViewController(), animated: true)
        }
    }
    private func setButtonStack(){
        stv = UIStackView()
        stv?.translatesAutoresizingMaskIntoConstraints = false
        stv?.center = self.view.center
        stv?.backgroundColor = .yellow
        stv?.axis = .vertical
        stv?.distribution = .fillEqually
        self.view.addSubview(stv!)
        let anc = self.view.frame.width < self.view.frame.height ?  self.view.frame.width : self.view.frame.height
        stv?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stv?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stv?.widthAnchor.constraint(equalToConstant: anc).isActive = true
        stv?.heightAnchor.constraint(equalToConstant: anc).isActive = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
