//
//  File.swift
//  testApp
//
//  Created by Nikolas Omelianov on 03.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import Foundation

enum httpError: Error {
    case limitOveral
    case badRequest
    case unknown
    
    var description: String {
        switch self {
        case .limitOveral:
            return "Error code 429"
        case .badRequest:
            return "Error code 403"
        default:
            return "Error code 404"
        }
    }
}
