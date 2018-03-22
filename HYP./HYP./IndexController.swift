//
//  IndexController.swift
//  HYP.
//
//  Created by Mark Tran on 2/3/18.
//  Copyright © 2018 Mark Tran. All rights reserved.
//

import UIKit
import SQLite3
class IndexController: UIViewController, UITextViewDelegate {

    var db : OpaquePointer?
    var itemList = [Item]()
    var message = ""
    var n = 9
    
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var nameText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ItemsDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("ERROR")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Items(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, desc TEXT, price INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString : sqlite3_errmsg(db)!)
            print("Error creating table: \(errmsg)")
        }
        
        readValues(num: n)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        readValues(num: n)
    }
    

    @IBAction func leftButton(_ sender: UIButton) {
        readValues(num: n)
    }
    
    func readValues(num: Int){
        
        itemList.removeAll()

        let queryString = "SELECT * FROM Items"

        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let type = String(cString: sqlite3_column_text(stmt, 2))
            let desc = String(cString: sqlite3_column_text(stmt, 3))
            let price = sqlite3_column_int(stmt, 4)
            
            itemList.append(Item(id: Int(id), name: String(describing: name),
                                 type: String(describing: type), desc: String(describing: desc), price: Int(price)))
        }
        
        descText.text = itemList[n].desc
        priceText.text = "$" + String(itemList[n].price)
        nameText.text = itemList[n].name
        
        if(n >= itemList.count-1) {
            n = 9
        } else {
            n = n + 1
        }
        
        print(n)
    }
    
    
    
    
    

}
