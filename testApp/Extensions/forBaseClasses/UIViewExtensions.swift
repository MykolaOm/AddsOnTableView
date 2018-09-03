//
//  UIViewExtensions.swift
//  testApp
//
//  Created by Nikolas Omelianov on 03.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

extension UIView {
    func pinToEdges(view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
