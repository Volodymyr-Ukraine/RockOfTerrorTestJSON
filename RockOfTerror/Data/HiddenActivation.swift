//
//  HiddenActivation.swift
//  RockOfTerror
//
//  Created by Vova Abdula on 2/28/19.
//  Copyright © 2019 Vova Abdula. All rights reserved.
//

import Foundation

struct HiddenActivation: Codable {
    var idJumper: Int8
    var condition: String
    var timer: Int16
    var item: String
    var textJumper: String
}
/*
 "hiddenActivations": [
 {
 "timer": 0,
 "item": "sword",
 "condition": "=",
 "textJumper": "that way",
 "idJumper": 25
 },
 // */
