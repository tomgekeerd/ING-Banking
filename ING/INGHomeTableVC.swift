//
//  INGHomeTableVC.swift
//  ING
//
//  Created by Tom de ruiter on 09/09/2016.
//  Copyright © 2016 Rydee. All rights reserved.
//

import UIKit

class INGHomeTableVC: UITableViewController {
    
    // Data
    
    var normalAccounts = [AnyObject]()
    var savingAccounts = [AnyObject]()

    // Constants 
    
    var numberOfSavingAccounts = -1
    var numberOfNormalAccounts = -1
    
    // API

    let ing = INGAPI(username: "my_username", andPassword: "my_password")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch the data
        
        ing.getSavingAccounts { (response, error) in
            if error != nil {
                print("Failed the request")
            } else {
                if let data = response {
                    self.savingAccounts = data["accounts"] as? [AnyObject] ?? []
                    self.numberOfSavingAccounts = self.savingAccounts.count
                    self.doneFetchingData()
                }
            }
        }
        
        ing.getPaymentAccounts { (response, error) in
            if error != nil {
                print("Failed the request")
            } else {
                if let data = response {
                    self.normalAccounts = data["accounts"] as? [AnyObject] ?? []
                    self.numberOfNormalAccounts = self.normalAccounts.count
                    self.doneFetchingData()
                }
            }
        }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Functions
    
    func numberOfAccounts(accountType: String) -> Int {
        switch accountType.lowercaseString {
        case "normal":
            return numberOfNormalAccounts
        case "saving":
            return numberOfSavingAccounts
        case "totaldifferentaccounts":
            if numberOfNormalAccounts > 0 && numberOfSavingAccounts > 0 {
                return 2
            } else if numberOfNormalAccounts == 0 || numberOfSavingAccounts == 0 {
                return 1
            } else if numberOfNormalAccounts == 0 && numberOfSavingAccounts == 0 {
                return 0
            }
        default:
            ()
        }
        return 0
    }
    
    func hasAccount(accountType: String) -> Bool {
        switch accountType.lowercaseString {
        case "normal":
            if numberOfNormalAccounts > 0 {
                return true
            } else {
                return false
            }
        case "saving":
            if numberOfSavingAccounts > 0 {
                return true
            } else {
                return false
            }
        default:
            ()
        }
        return false
    }
    
    func doneFetchingData() {
        if numberOfNormalAccounts != -1 && numberOfSavingAccounts != -1 {
            reloadAllData()
        }
    }
    
    func reloadAllData() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let numberOfAcc = numberOfAccounts("totaldifferentaccounts")
        if numberOfAcc != -1 {
            return numberOfAcc
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch numberOfAccounts("totaldifferentaccounts") {
        case 0:
            return 0
        case 1:
            if hasAccount("normal") {
                return numberOfAccounts("normal")
            } else if hasAccount("saving") {
                return numberOfAccounts("saving")
            }
        case 2:
            if section == 0 {
                return numberOfAccounts("normal")
            } else if section == 1 {
                return numberOfAccounts("saving")
            }
        default:
            ()
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as!INGHomeTableViewCell

        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class INGHomeTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var accountNumberLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
}