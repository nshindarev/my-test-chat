//
//  ConversationListViewController.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 02.11.2021.
//

import UIKit

class ConversationListViewController: UIViewController {

    @IBOutlet weak var tableConversations: UITableView!
    
    var conversations = [
        Conversation(userName: "Daria Chupyrkina",
                     date: "16:20",
                     lastMessage: "Hi, how u doin'?"),
        
        Conversation(userName: "Arslan Nevlyaev",
                     date: "17:50",
                     lastMessage: "Hi, how u doin'?"),
        
        Conversation(userName: "Zhenya Zlatina",
                     date: "09:30",
                     lastMessage:"Hi, how u doin'?")]
    
    private var cellIdentifier = String(describing: ChatCellTableViewCell.self)
    
    struct Conversation {
        let userName: String
        let date: String
        let lastMessage: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableConversations.register(UINib(nibName: String(describing: ChatCellTableViewCell.self),  bundle: nil), forCellReuseIdentifier: cellIdentifier)

        
        //        tableConversations.delegate = self
        tableConversations.dataSource = self
    }
}

extension ConversationListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conversation: Conversation = conversations[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatCellTableViewCell else {return UITableViewCell()}
        cell.configure(with: .init(name: conversation.userName, msg: conversation.lastMessage, date: conversation.date))
        
        return cell
    }
}

//extension ConversationListViewController: UITableViewDelegate{
//    // handle cell interactions
//}
