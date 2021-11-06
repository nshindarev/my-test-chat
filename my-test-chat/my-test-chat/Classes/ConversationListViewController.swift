//
//  ConversationListViewController.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 02.11.2021.
//

import UIKit

class ConversationListViewController: UIViewController {

    // ========================  Data Source structure + data  =========================
    //
    var conversations = [
        ConversationsSection(online: true,
                             conversations: [Conversation(userName: "Daria Chupyrkina",
                                                         date: "16:20",
                                                         lastMessage: "Hi, how u doin'?"),
                                            
                                            Conversation(userName: "Arslan Nevlyaev",
                                                         date: "17:50",
                                                         lastMessage: "Hi, how u doin'?")]),
        ConversationsSection(online: false,
                             conversations: [Conversation(userName: "Zhenya Zlatina",
                                                         date: "09:30",
                                                         lastMessage:"Hi, how u doin'?")])

    ]
    
    struct ConversationsSection{
        let online: Bool
        let conversations: [Conversation]
        
    }
    struct Conversation {
        let userName: String
        let date: String
        let lastMessage: String
    }
    
    // =================================== UI Fields ===================================
    @IBOutlet weak var tableConversations: UITableView!
    
    private var cellIdentifier = String(describing: ChatCellTableViewCell.self)
    
    let userimage = UIImageView(image: UIImage(named: "avatar"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableConversations.register(UINib(nibName: String(describing: ChatCellTableViewCell.self),  bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableConversations.dataSource = self
        
        
//        let profileButton = UIBarButtonItem(image: UIImage(named: "avatar"), style: .plain, target: self, action: #selector(ConversationListViewController.onAvatarPressed))
//
//        self.navigationItem.rightBarButtonItem  = profileButton
//        self.navigationItem.leftBarButtonItem  = profileButton
        
        setupConstraints()
        setUpGestureRecognizer()
    }
    
//    @objc
//    func onAvatarPressed (){
//        print("pressed avatar")
//    }
    
    
    func setupConstraints() {
        navigationItem.hidesSearchBarWhenScrolling = false
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(userimage)
        userimage.clipsToBounds = true
        userimage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userimage.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16),
            userimage.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            userimage.heightAnchor.constraint(equalToConstant: 32),
            userimage.widthAnchor.constraint(equalTo: userimage.heightAnchor)
        ])
    }
    
    func setUpGestureRecognizer() {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profile))
            userimage.isUserInteractionEnabled = true
            userimage.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func profile() {
        print("pressed avatar")
    }


}


// MARK: ===================== DataSource =====================
extension ConversationListViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversations.count    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations[section].conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = conversations[indexPath.section]
        let conversation: Conversation = section.conversations[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatCellTableViewCell else {return UITableViewCell()}
        cell.configure(with: .init(name: conversation.userName, msg: conversation.lastMessage, date: conversation.date))
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (conversations[section].online ? "Online":"History")
    }
}

