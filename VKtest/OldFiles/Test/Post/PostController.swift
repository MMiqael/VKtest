//
//  TestController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 29.01.2021.
//

import UIKit

struct PostStruct {
    var avatar: UIImage
    var name: String
    var time: String
    var message: String
    var image: UIImage
}

class PostController: UITableViewController {
    
    var array = [PostStruct(avatar: UIImage(systemName: "person")!,name: "Alex", time: "today at 13:00", message: "I waked up at 9:00 am", image: UIImage(systemName: "person")!),
                 PostStruct(avatar: UIImage(systemName: "gear")!,name: "Leo", time: "5 hours ago", message: "Hello World!", image: UIImage(systemName: "gear")!)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostModelCell

        let index = array[indexPath.row]
        
        cell.avatarView.avatar.image = index.avatar
        cell.nameLabel.text = index.name
        cell.timeLabel.text = index.time
        cell.messageLabel.text = index.message
        cell.photoImageView.image = index.image
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
