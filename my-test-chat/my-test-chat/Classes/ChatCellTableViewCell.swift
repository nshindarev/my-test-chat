//
//  ChatCellTableViewCell.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 02.11.2021.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {

//    struct Message: MessageType{
//        var sender: SenderType
//        var messageId: String
//        var sentDate: Date
//        var kind: MessageKind
//    }
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    func configure (with model: ConversationListViewController.Message){
        // DATE
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        lblDate.text = formatter.string(from: model.sentDate)

        // TEXT
        switch model.kind {
        case .text(let messageText):
            lblMessage.text  = messageText
        default:
            lblMessage.text = "* sent you a content *"
        }
        
        lblFullName.text = model.sender.displayName
    }
    
}
