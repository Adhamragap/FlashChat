//
//  MessageCellTableViewCell.swift
//  Flash Chat iOS13
//
//  Created by adham ragap on 07/05/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var MessageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageBubble.layer.cornerRadius = MessageBubble.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
