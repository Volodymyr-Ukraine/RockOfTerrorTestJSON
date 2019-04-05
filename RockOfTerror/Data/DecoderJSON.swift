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
        guard let path = Bundle.main.path(forResource: "\(inputJSONText)", ofType: "json") else {
            print("File JSON not found")
            return
        }
        let expandedPath = URL(fileURLWithPath: path)
        print(expandedPath)
        let text = try! String(contentsOf: expandedPath)
        let decoder = JSONDecoder()
        do {
            dataArray = try decoder.decode([Data].self, from: text.data(using: .utf8)!) as! T
        } catch {
            print("error in decoding JSON")
        }
    }
}
