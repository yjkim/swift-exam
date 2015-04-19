//
//  BNRItem.swift
//  Homepwner
//
//  Created by ryan on 4/12/15.
//  Copyright (c) 2015 kim young jin. All rights reserved.
//

import UIKit

class BNRItem {
    var itemName: String
    var serialNumber: String
    var valueInDollars: Int
    let dateCreated: NSDate
    var description: String {
        return "\(self.itemName) (\(self.serialNumber)): Worth $\(self.valueInDollars), recorded on \(self.dateCreated)"
    }
    
    class func randomItem() -> BNRItem {
        func randomLetter() -> String {
            let startingUnicodeScalaValue = UnicodeScalar("A").value
            let numberOfLetters = 26
            let randomUnicodeScalaValue = Int(startingUnicodeScalaValue) + Int(rand()) % numberOfLetters
            return String(UnicodeScalar(randomUnicodeScalaValue))
        }
        func randomDigit() -> String {
            let startingUnicodeScalaValue = UnicodeScalar("0").value
            let numberOfPossibleDigits = 10
            let randomUnicodeScalaValue = Int(startingUnicodeScalaValue) + Int(rand()) % numberOfPossibleDigits
            return String(UnicodeScalar(randomUnicodeScalaValue))
        }
        
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        let adjectiveIndex = Int(rand()) % randomAdjectiveList.count
        let nounIndex = Int(rand()) % randomNounList.count
        
        let randomName = randomAdjectiveList[adjectiveIndex] + " " + randomNounList[nounIndex]
        let randomValue = Int(rand()) % 100
        
        let randomSerialNumber = randomLetter() + randomDigit() + randomLetter() + randomDigit() + randomLetter()
        let newItem = BNRItem(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        return newItem
    }
    
    init(itemName: String, valueInDollars: Int, serialNumber: String) {
        self.itemName = itemName
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = NSDate()
    }
    
    convenience init(itemName: String) {
        self.init(itemName: itemName, valueInDollars: 0, serialNumber: "")
    }
    
    convenience init() {
        self.init(itemName: "Item")
    }
    
    deinit {
        println("Destory: \(self.description)")
    }
}
