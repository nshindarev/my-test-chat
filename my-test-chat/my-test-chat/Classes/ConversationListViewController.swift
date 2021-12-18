//
//  ConversationListViewController.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 02.11.2021.
//

import UIKit
import MessageKit

class ConversationListViewController: UIViewController {
    
    // ================================  Structures ==============================

    struct ConversationList{
        var onlineConversations: [Sender: [Message]] = [:]
        var offlineConversations: [Sender: [Message]] = [:]
    }
    
    public struct Sender: SenderType, Hashable{
        var online: Bool
        var senderId: String
        var displayName: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(senderId.hashValue)
        }
        static func == (lhs: Sender, rhs: Sender) -> Bool {
            return lhs.senderId == rhs.senderId && lhs.displayName == rhs.displayName
        }
    }
    
    public struct Message: MessageType{
        var sender: SenderType
        var messageId: String
        var sentDate: Date
        var kind: MessageKind
    }
    
    //================================ DATA FIELDS  =================================
    var messages: ConversationList

    func appendConversation(newSender: Sender, newMsg: [Message]) {
        
        var conversations = newSender.online ? self.messages.onlineConversations : self.messages.offlineConversations
        conversations[newSender]?.append(contentsOf: newMsg)
    }
    func appendConversation(newSender: Sender, newMsg: Message) {
        
        var conversations = newSender.online ? self.messages.onlineConversations : self.messages.offlineConversations
        conversations[newSender]?.append(newMsg)
    }
    
    // ===============================     UI      =====================================
    @IBOutlet weak var tableConversations: UITableView!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    private var cellIdentifier = String(describing: ChatCellTableViewCell.self)
    private let userimage = UIImageView(image: UIImage(named: "avatar"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui table view
        tableConversations.register(UINib(nibName: String(describing: ChatCellTableViewCell.self),  bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableConversations.dataSource = self
        tableConversations.delegate = self
        

        // ui profile button
        setupConstraints()
        setUpGestureRecognizer()
        
        // ui profile label
        navBarTitle.titleView = navTitleWithImageAndText(titleText: "Name Surname", imageName: "online-indicator")
    }
    
    // ------------------------ AVATAR IMAGE INIT -----------------------------
    
    func setupConstraints() {
        navigationItem.hidesSearchBarWhenScrolling = false
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(userimage)
        userimage.clipsToBounds = true
        userimage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userimage.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -32),
            userimage.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            userimage.heightAnchor.constraint(equalToConstant: 32),
            userimage.widthAnchor.constraint(equalTo: userimage.heightAnchor)
        ])
    }
    
    func setUpGestureRecognizer() {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onAvatarTapped))
            userimage.isUserInteractionEnabled = true
            userimage.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func onAvatarTapped() {

        let next = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(next, animated: true, completion: nil)
    }
    
    func navTitleWithImageAndText(titleText: String, imageName: String) -> UIView {

        // Creates a new UIView
        let titleView = UIView()

        // Creates a new text label
        let label = UILabel()
        label.text = titleText
        label.sizeToFit()
        label.center = titleView.center
        label.textAlignment = NSTextAlignment.center

        // Creates the image view
        let image = UIImageView()
        image.image = UIImage(named: imageName)

        // Maintains the image's aspect ratio:
        let imageAspect = image.image!.size.width / image.image!.size.height

        // Sets the image frame so that it's immediately before the text:
        let imageX = (label.frame.origin.x - label.frame.size.height * imageAspect) - 16;
        let imageY = label.frame.origin.y

        let imageWidth = label.frame.size.height * imageAspect
        let imageHeight = label.frame.size.height

        image.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)

        image.contentMode = UIView.ContentMode.scaleAspectFit

        // Adds both the label and image view to the titleView
        titleView.addSubview(label)
        titleView.addSubview(image)

        // Sets the titleView frame to fit within the UINavigation Title
        titleView.sizeToFit()

        return titleView
    }
    
    


}

// MARK: ===================== DataSource =====================
extension ConversationListViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? Array(messages.onlineConversations).count : Array(messages.offlineConversations).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section == 0 ? messages.onlineConversations : messages.offlineConversations
        let companion = Array(section.keys)[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatCellTableViewCell else {return UITableViewCell()}
        guard let lastMessage: ConversationListViewController.Message = section[companion]?.last else {return UITableViewCell()}
        
        cell.configure(with: lastMessage)
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (messages[section].online ? "Online":"History")
    }
}

extension ConversationListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        
        
        // insert: second user name
        navigationController?.pushViewController(vc, animated: true)
    }
}

