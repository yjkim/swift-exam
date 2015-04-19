//
//  BNRItemStore.swift
//  Homepwner
//
//  Created by ryan on 4/12/15.
//  Copyright (c) 2015 kim young jin. All rights reserved.
//

import UIKit

class BNRItemStore: NSObject {
    
    private(set) var allItems = [BNRItem]()
    
    class var sharedStore: BNRItemStore {
        struct Static {
            static let instance: BNRItemStore = BNRItemStore()
        }
        return Static.instance
    }
    
    // It's impossible to instantiate this class outside of this file
    private override init() {
        super.init()
        
    }
    
    func createItem() -> BNRItem? {
        let item = BNRItem.randomItem()
        self.allItems.append(item)
        return item
    }
    
    func removeItem(item: BNRItem) {
        self.allItems = self.allItems.filter({$0 !== item})
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex:Int) {
        if (fromIndex == toIndex) {
            return
        }
        // 객체가 이동할 포인터를 얻어 다시 삽입한다.
        let item = self.allItems[fromIndex]
        
        // item을 배열에서 삭제한다
        self.allItems.removeAtIndex(fromIndex)
        
        // 배열에서 item을 새 위치에 삽입한다
        self.allItems.insert(item, atIndex: toIndex)
        
    }
}
