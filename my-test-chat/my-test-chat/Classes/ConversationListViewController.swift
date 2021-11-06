//
//  ConversationListViewController.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 02.11.2021.
//

import UIKit

class ConversationListViewController: UIViewController {

    // ------------------------  Data Source structure + data  ------------------------
    
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
    
    // ------------------------------------------------------------------------
    
    @IBOutlet weak var tableConversations: UITableView!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    private var cellIdentifier = String(describing: ChatCellTableViewCell.self)
    private let userimage = UIImageView(image: UIImage(named: "avatar"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui table view
        tableConversations.register(UINib(nibName: String(describing: ChatCellTableViewCell.self),  bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableConversations.dataSource = self

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
        print("pressed avatar")
        
//
//        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
//        self.navigationController?.pushViewController(secondViewController, animated: true)

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

