//
//  BNRDetailViewController.swift
//  Homepwner
//
//  Created by ryan on 4/20/15.
//  Copyright (c) 2015 kim young jin. All rights reserved.
//

import UIKit

class BNRDetailViewController: UIViewController {

    var item: BNRItem? {
        didSet {
            
            self.navigationItem.title = item?.itemName
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    init () {
        super.init(nibName: "BNRDetailViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = self.item {
            self.nameField.text = item.itemName
            self.serialNumberField.text = item.serialNumber
            self.valueField.text = "\(item.valueInDollars)"
            
            // 날짜를 간단한 문자열로 변환하기 위해 NSDateFormatter가 필요하다
            struct StaticDateFormatter {
                static var _dateFormatter: NSDateFormatter?
                static var dateFormatter: NSDateFormatter {
                    if _dateFormatter == nil {
                        _dateFormatter = NSDateFormatter()
                        _dateFormatter?.dateStyle = NSDateFormatterStyle.MediumStyle
                        _dateFormatter?.timeStyle = NSDateFormatterStyle.NoStyle
                        
                    }
                    return _dateFormatter!
                }
            }
            let dateFormatter = StaticDateFormatter.dateFormatter
            
            self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 퍼스트 리스폰더 해제됨
        self.view.endEditing(true)
        
        // 변경내용을 item 에 저장한다'
        if let item = self.item {
            item.itemName = self.nameField.text
            item.serialNumber = self.serialNumberField.text
            if let integer = self.valueField.text.toInt() {
                item.valueInDollars = integer
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
