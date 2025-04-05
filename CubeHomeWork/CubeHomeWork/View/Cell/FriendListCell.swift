//
//  FriendListCell.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/5.
//

import Foundation
import UIKit

class FriendListCell: UITableViewCell {
    static let friendListCellId = "FriendListCell"

    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let transferButton = UIButton()
    public let invitedButton = UIButton()
    public let friendStarImageView = UIImageView()
    private let divideLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        invitedButton.setTitle("", for: .normal)
        invitedButton.setImage(UIImage(named: "moreIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        invitedButton.setTitleColor(nil, for: .normal)
        invitedButton.backgroundColor = .clear
        invitedButton.layer.borderWidth = 0
        invitedButton.layer.borderColor = nil
        invitedButton.layer.cornerRadius = 0
        
        transferButton.setTitle("轉帳", for: .normal)
        transferButton.setTitleColor(UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1), for: .normal)
        transferButton.backgroundColor = .white
        transferButton.layer.borderColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1).cgColor
        transferButton.layer.borderWidth = 1.2
        transferButton.layer.cornerRadius = 2
        
        nameLabel.text = ""
        avatarImageView.image = UIImage(named: "friendLisetDefault")
        
        invitedButton.snp.remakeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.greaterThanOrEqualTo(24)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupUI() {
        friendStarImageView.image = UIImage(named: "friendStar")
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(named: "friendLisetDefault")
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        invitedButton.setTitle("", for: .normal)
        invitedButton.setImage(UIImage(named: "moreIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        invitedButton.layer.borderWidth = 0
        
        transferButton.setTitle("轉帳", for: .normal)
        transferButton.setTitleColor(UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1), for: .normal)
        transferButton.backgroundColor = .white
        transferButton.layer.borderColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1).cgColor
        transferButton.layer.borderWidth = 1.2
        transferButton.layer.cornerRadius = 2
        
        divideLine.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(transferButton)
        contentView.addSubview(invitedButton)
        contentView.addSubview(friendStarImageView)
        contentView.addSubview(divideLine)
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
        
        friendStarImageView.snp.makeConstraints { make in
            make.right.equalTo(avatarImageView.snp.left).offset(-6)
            make.centerY.equalTo(avatarImageView)
            make.width.height.equalTo(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
        
        invitedButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(24)
            make.height.equalTo(8)
            make.centerY.equalToSuperview()
        }
        
        transferButton.snp.makeConstraints { make in
            make.right.equalTo(invitedButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(47)
            make.height.equalTo(24)
        }
        
        divideLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(1)
            make.left.equalTo(nameLabel)
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func configure(with friend: FriendListDetail) {
        nameLabel.text = friend.name
        transferButton.tag = Int(friend.fid) ?? 0
    }
}
