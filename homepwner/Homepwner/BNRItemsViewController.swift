//
//  BNRItemsViewController.swift
//  Homepwner
//
//  Created by ryan on 4/12/15.
//  Copyright (c) 2015 kim young jin. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController {
    
    var _headerView: UIView?
    @IBOutlet var headerView: UIView! {
        get {
            if _headerView == nil {
                 NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)
            }
            return _headerView
        }
        set {
            _headerView = newValue
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(style: UITableViewStyle.Plain)
        
        let navItem = self.navigationItem
        navItem.title = "Homepwner"
        
        // BNRItemsViewController 에 
        // addNewItem: 메시지를 보낼 새 바 버튼 아이템을 만든다.
        let bbi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewItem:")
        
        // 이 바 버튼 아이템을 navigationItem의 오른쪽 아이템으로 설정한다
        navItem.rightBarButtonItem = bbi
        
        navItem.leftBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Initializer
    
    override convenience init(style: UITableViewStyle) {
        // 상위 클래스의 지정 초기화 메소드를 호출한다.
        self.init()
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        self.tableView.tableHeaderView = self.headerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - dataSourceDelegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.sharedStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 기본 모양을 가진 UITableViewCell 인스턴스를 만든다.
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        // 셀에 allItems 배열 n 번째 항목의 description을 텍스트로 설정한다.
        // 이 셀은 테이블뷰의 n번째 행에 나타난다
        let items = BNRItemStore.sharedStore.allItems
        let item = items[indexPath.row]
        if let textLabel = cell.textLabel {
            textLabel.text = item.description
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 테이블뷰가 삭제 명령을 보내도록 요청하면...
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let items = BNRItemStore.sharedStore.allItems
            let item = items[indexPath.row]
            BNRItemStore.sharedStore.removeItem(item)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = BNRDetailViewController()
        
        let items = BNRItemStore.sharedStore.allItems
        let selectedItem = items[indexPath.row]
        
        // 상세뷰 컨트롤러에 선택된 item 객체에 대한 포인터를 준다
        detailViewController.item = selectedItem
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        BNRItemStore.sharedStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    

    // MARK: - IBActions
    
    @IBAction func addNewItem(sender: AnyObject) {
        // 0번 섹션의 마지막 행의 인덱스 패스를 만든다
        //let lastRow = self.tableView.numberOfRowsInSection(0)
        
        // BNRItem을 새로 만들고 저장소에 추가한다
        let newItem = BNRItemStore.sharedStore.createItem()
        
        // 배열에서 이항목의 위치를 계산한다
        var lastRow = -1
        for i in 0..<BNRItemStore.sharedStore.allItems.count {
            if BNRItemStore.sharedStore.allItems[i] === newItem {
                lastRow = i
                break
            }
        }
        
        if 0 <= lastRow {
            
            let indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
            
            // 테이블에 새로운 행을 삽입한다
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // 현재 편집 모드에 있다면 ...
        if (self.editing) {
            // 사용자에게 상태를 알리기 위해 버튼 텍스트를 변경한다
            sender.setTitle("Edit", forState: UIControlState.Normal)
            
            // 편집 모드를 닫는다
            self.setEditing(false, animated: true)
        } else {
            // 사용자에게 상태를 알리기 위해 버튼 텍스트를 변경한다
            sender.setTitle("Done", forState: UIControlState.Normal)
            // 편집 모드로 들어간다
            self.setEditing(true, animated: true)
        }
    }
    
    
}
