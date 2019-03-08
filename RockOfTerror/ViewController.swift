//
//  ViewController.swift
//  RockOfTerror
//
//  Created by Vova Abdula on 2/27/19.
//  Copyright © 2019 Vova Abdula. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: Outlets and properties
    
    @IBOutlet weak var textStoryLabel: UILabel!
    @IBOutlet weak var nextStoryButton: UIButton!
    private var datasArray : [Data] = []
    private var currentTime: Int = 0
    private var items: [String] = []
    private var currentPage: Int = 0
    private var ownAlertController : UIAlertController
    private let testState: Bool = true
    private var inventoryShowState: Bool = true
    private var temporaryString: String = String()
    private var powerOfMonkHart: Int? = nil

    // MARK: -
    // MARK: Initializers
    
    internal required init?(coder aDecoder: NSCoder) {
        self.ownAlertController = UIAlertController(title: "OK", message: "Ready to work with JSON data file", preferredStyle: .actionSheet)
        super.init(coder: aDecoder)
        let action = UIAlertAction(title: "Exit", style: .default){ (action) in

        }
        self.ownAlertController.addAction(action)
    
        print("1 init")
        DecoderJSON().decode(dataArray: &datasArray, "StoryData.json")
    }
    
    override func viewDidLoad() {
        self.currentPage = 0
        guard let startInfo = self.datasArray.first else {
            print("some problem with finding first element")
            return
        }
        self.setPage(startInfo.stateID)
        
        super.viewDidLoad()
        
    }

    // MARK: -
    // MARK: Actions and functions
    
    @IBAction func nextButton(_ sender: Any) {
        self.present(self.ownAlertController, animated: true, completion: nil)
    }
    
    @IBAction func SwipeGesture(_ sender: Any) {
        if self.inventoryShowState {
            self.temporaryString = self.textStoryLabel.text!
            var itemsText = "Доступний інвентар та примітки: \n"
            self.items.forEach{ itemName in
                itemsText += (itemName + "\n")
            }
            self.textStoryLabel.text = itemsText
            self.inventoryShowState = false
        } else {
            self.textStoryLabel.text = self.temporaryString
            self.inventoryShowState = true
        }
        
    }
    
    
    private func setPage(_ pageNumber: Int)  {
        if pageNumber == 0 {
            self.items = []
            self.currentTime = 0
        }
        guard let startInfo = self.datasArray.first(where: { (info) -> Bool in
            return (info.stateID == pageNumber)
        }) else {
            print("some problem with finding first element")
            return
        }
        self.textStoryLabel.text = startInfo.text
        if startInfo.center ?? false {
            self.textStoryLabel.textAlignment = .center
        } else {
            self.textStoryLabel.textAlignment = .justified
        }
        if pageNumber == 0 {self.currentTime = 0}
        
        if self.items.contains("Поранена нога") {
            self.currentTime += 2*Int(startInfo.time)
        } else {
            self.currentTime += Int(startInfo.time)
        }
        
        guard self.currentTime >= 0 else {
            let uControl = UIAlertController(title: "Що робити?", message: "Зійшло сонце - Ви не встигли", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "спробувати ще раз", style: .default, handler: { (act) in
                self.currentPage = 0
                self.setPage(0)
            } )
            uControl.addAction(action)
            self.ownAlertController = uControl
            self.temporaryString = self.textStoryLabel.text!
            return
        }
        
        if startInfo.items.contains("серце ченця стало сильнішим") {
            if let power = self.powerOfMonkHart {
                self.powerOfMonkHart = power + 1
                self.items.append("Cерце ченця стало сильнішим, його сила - \(self.powerOfMonkHart!)")
            }
        } else if startInfo.items.contains("знайдено серце ченця") {
            self.powerOfMonkHart = 0
            self.items.append("Знайдено серце ченця, сила - \(self.powerOfMonkHart!)")
        } else {
            self.items.append(contentsOf: startInfo.items)
        }
        if let text = startInfo.buttonText {
            self.setButtonTitle(text)
        } else {
            let hour: Int = (self.currentTime/60)
            let minutes = self.currentTime - (hour * 60)
            let text = "Зараз \(((hour)<6) ? (12-hour) : (24-hour)):\(minutes). \n Треба встигнути до сходу сонця"
            if self.testState {
                self.setButtonTitle(text + " номер стор.: \(pageNumber)")
            } else {
                self.setButtonTitle(text)
            }
        }
        let uControl = UIAlertController(title: "Що робити?", message: "Оберіть дію", preferredStyle: .actionSheet)
        
        startInfo.jumpers.forEach { (jumper) in
            let action = UIAlertAction(title: jumper.textJumper, style: .default, handler: { (act) in
                self.currentPage = jumper.idJumper
                self.setPage(jumper.idJumper)
            } )
            uControl.addAction(action)
        }
        startInfo.hiddenActivations.forEach { (hiddenjumpers) in
            if self.items.contains(hiddenjumpers.item) {
                uControl.addAction(addAction(hiddenjumpers.textJumper, Int(hiddenjumpers.idJumper)))
            }
            if hiddenjumpers.item == "time" {
                if (hiddenjumpers.condition == ">") && (self.currentTime>hiddenjumpers.timer) {
                    uControl.addAction(addAction(hiddenjumpers.textJumper + " n=\(hiddenjumpers.idJumper)", Int(hiddenjumpers.idJumper)))
                } else if (hiddenjumpers.condition == "<") && (self.currentTime<=hiddenjumpers.timer) {
                        uControl.addAction(addAction(hiddenjumpers.textJumper + " n=\(hiddenjumpers.idJumper)", Int(hiddenjumpers.idJumper)))
                    }
            }
            if hiddenjumpers.item == "смерть в реальному світі" {
                uControl.addAction(addAction(hiddenjumpers.textJumper + " n=\(hiddenjumpers.idJumper)", Int(hiddenjumpers.idJumper)))
            }
        } 
        self.ownAlertController = uControl
        self.temporaryString = self.textStoryLabel.text!
    }
    
    private func setButtonTitle(_ textForButton: String){
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.nextStoryButton.setTitle(NSLocalizedString(textForButton, comment: ""), for: state)
        }
    }
    
    private func addAction(_ title: String, _ idJumper: Int) -> UIAlertAction{
        return UIAlertAction(title: title, style: .default, handler: { (act) in
            self.currentPage = idJumper
            self.setPage(idJumper)
        })
    }
    
}

