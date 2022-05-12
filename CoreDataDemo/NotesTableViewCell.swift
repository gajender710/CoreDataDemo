//
//  NotesTableViewCell.swift
//  CoreDataDemo
//
//  Created by Gajender Jangir on 15/04/22.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let text=cellLabel.text
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
