//
//  ReadJSON.swift
//  RockOfTerror
//
//  Created by Vova Abdula on 2/28/19.
//  Copyright © 2019 Vova Abdula. All rights reserved.
//

import Foundation

class DecoderJSON: Codable{
    
    func decode<T: Codable> (dataArray: inout T, _ inputJSONText: String) {
        let homeDirectory = "/Users/vova/Documents/Git_inout/RockOfTerror/RockOfTerror/RockOfTerror/Data"
        let path = "\(homeDirectory)/\(inputJSONText)"
        let expandedPath = URL(fileURLWithPath: path)
        print(expandedPath)
        let text = try! String(contentsOf: expandedPath)
        let decoder = JSONDecoder()
        do {
            dataArray = try decoder.decode([Data].self, from: text.data(using: .utf8)!) as! T
            // let data = try decoder.decode(Data.self, from: text.data(using: .utf8)!)
            print("ura")
            //print(dataArray)
        } catch {
            print("error")
        }
    }
}
