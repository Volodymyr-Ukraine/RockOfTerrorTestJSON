//
//  Data.swift
//  RockOfTerror
//
//  Created by Vova Abdula on 2/28/19.
//  Copyright © 2019 Vova Abdula. All rights reserved.
//

import Foundation

struct Data: Codable {
    var stateID: Int
    var items: [String]
    var text: String
    var time: Int16
    var center: Bool?
    var buttonText: String?
    var jumpers: [JumperActivation]
    var hiddenActivations: [HiddenActivation]
}

