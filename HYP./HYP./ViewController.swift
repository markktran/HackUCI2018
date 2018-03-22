//
//  ViewController.swift
//  HYP.
//
//  Created by Mark Tran on 2/3/18.
//  Copyright © 2018 Mark Tran. All rights reserved.
//

import UIKit
import SQLite3



class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let type = ["Shoes", "Top", "Bottom", "Accessories"]
    var selected = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = type[row]
    }
    
    var itemList = [Item]()
    var db : OpaquePointer?
    

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var textFieldDesc: UITextView!
    @IBOutlet weak var pickerType: UIPickerView!
    
    @IBAction func buttonSave(_ sender: UIButton) {
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let price = textFieldPrice.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let desc = textFieldDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(price?.isEmpty)!{
            textFieldPrice.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(desc?.isEmpty)!{
            textFieldDesc.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        var stmt : OpaquePointer?
        
        let queryString = "INSERT INTO Items(name, type, desc, price) VALUES (?,?,?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, (name as! NSString).utf8String, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, (selected as NSString).utf8String, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding type: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, (desc as! NSString).utf8String, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding desc: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 4, (price! as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding price: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting Item: \(errmsg)")
            return
        }
        
        
        textFieldPrice.text = ""
        textFieldName.text = ""
        textFieldDesc.text = ""
        selected = ""
        
        print("Item saved")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ItemsDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("ERROR")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Items(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, desc TEXT, price INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString : sqlite3_errmsg(db)!)
            print("Error creating table: \(errmsg)")
        }
    }
}
