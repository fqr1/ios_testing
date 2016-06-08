//
//  mainController.swift
//  testing
//
//  Created by Fabián Quintero Romo on 19/03/16.
//  Copyright © 2016 Fabián Quintero Romo. All rights reserved.
//

import UIKit

class mainController: UITableViewController {

    override func viewDidLoad() {
        
        let nib = UINib(nibName: "mainCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "mainCell")

        
    }
    
    // MARK: - Table view data source
    
    let options = ["ssh","Coordinates"]
    
    let storyboards = ["ssh":"sshStoryboard","Coordinates":"coordinatesStoryboard"]

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath)
        
        //cell.textLabel?.text = options[indexPath.row]
        
        let label = cell.viewWithTag(1) as? UILabel
        label?.text = options[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected \(options[indexPath.row]) item")
        
        let storyboard = UIStoryboard(name: options[indexPath.row], bundle: nil)
        let v = storyboard.instantiateViewControllerWithIdentifier(storyboards[options[indexPath.row]]!)
        
       

        
        self.navigationController?.pushViewController(v, animated: true)
    }
    

    

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
