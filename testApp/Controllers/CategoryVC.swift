//
//  CategoryVC.swift
//  testApp
//
//  Created by Nikolas Omelianov on 29.08.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    var stv : UIStackView?
    override func viewDidLoad() {
        super.viewDidLoad()
        stv = UIStackView()//frame: self.view.frame
        stv?.translatesAutoresizingMaskIntoConstraints = false
        stv?.center = self.view.center
        stv?.backgroundColor = .yellow
//        stv?.alignment = .center
        stv?.axis = .vertical
stv?.distribution = .fillEqually
        let am = VehicleCategory(name: "LOL", value: 1)
        let ma = VehicleCategory(name: "OLO", value: 2)
        let ama = VehicleCategory(name: "LO222L", value: 3)
        let maa = VehicleCategory(name: "OLO", value: 4)
        let am1 = VehicleCategory(name: "LOL", value: 5)
        let ma1 = VehicleCategory(name: "OLO", value: 6)
        let ama1 = VehicleCategory(name: "LO222L", value: 7)
        let maa1 = VehicleCategory(name: "OLO", value: 8)
        let maam = [am,ma,ama,maa,am1,ma1,ama1,maa1]
        print("did load")
        buttonFactory(amount: maam)
        self.view.addSubview(stv!)
        let anc = self.view.frame.width < self.view.frame.height ?  self.view.frame.width : self.view.frame.height
        stv?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                stv?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stv?.widthAnchor.constraint(equalToConstant: anc).isActive = true
        stv?.heightAnchor.constraint(equalToConstant: anc).isActive = true
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
    func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            
          self.navigationController?.pushViewController(ViewController(), animated: true)
        }
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
