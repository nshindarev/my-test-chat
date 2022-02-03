//
//  ChatCellTableViewCell.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 02.11.2021.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {

    struct Model{
        let name: String
        let msg: String?
        let date: String
    }
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    func configure (with model: Model){
        lblFullName.text = model.name
        lblDate.text = model.date
        lblMessage.text = model.msg ?? "No messages yet"
    }
    
}
