//
//  DataBase.swift
//  RockOfTerror
//
//  Created by Vova Abdula on 2/28/19.
//  Copyright © 2019 Vova Abdula. All rights reserved.
//

import Foundation

class DataBase {
    
    // MARK: -
    // MARK: Properties
    
    private var stateID: Int
    var items: [String]
    private var text: String
    var time: Int16
    var jumpers: [JumperActivation] = []
    var hiddenJumers: [HiddenActivation] = []
    
    // MARK: -
    // MARK: Init
    
    init(iD: Int,
         items: [String] = [],
         text: String,
         time: Int16 = 0,
         jumpers: [JumperActivation]=[],
         hiddenJump: [HiddenActivation]=[]) {
        self.stateID = iD
        self.items = items
        self.text = text
        self.time = time
        self.jumpers = jumpers
        self.hiddenJumers = hiddenJump
    }
    
    // MARK: -
    // MARK: Properties
    
    public func getID() -> Int{
        return self.stateID
    }
    
    public func getText() -> String{
        return self.text
    }
    
    
}
