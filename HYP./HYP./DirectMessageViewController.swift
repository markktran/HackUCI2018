//
//  DirectMessageViewController.swift
//  HYP.
//
//  Created by Mark Tran on 2/4/18.
//  Copyright © 2018 Mark Tran. All rights reserved.
//

import UIKit

class DirectMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func initiateTrade(_ sender: UIButton) {
        showInputDialog()
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Supreme Box Logo Tee", message: "Enter information: ", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in}
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Meeting Location"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Meeting Date"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Meeting Time"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Negotiated Price"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     
     101/35
     98/51
    */

}
