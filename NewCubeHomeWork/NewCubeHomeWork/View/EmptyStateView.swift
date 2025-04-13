//
//  EmptyStateView.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import UIKit
import SnapKit

class EmptyStateView: UIView {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let extraLabel = UILabel()
    let settingIDLabel = UILabel()
    let addFriendButton = UIView()
    let addFriendLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("EmptyStateView init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let friendEmptyImage = UIImageView(image: UIImage(named: "friendEmpty"))
        let addFriendIcon = UIImageView(image: UIImage(named: "addFriendIcon"))
        let extraStackView = UIStackView(arrangedSubviews: [extraLabel, settingIDLabel])
        
        addSubview(friendEmptyImage)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(addFriendButton)
        addSubview(addFriendLabel)
        addSubview(addFriendIcon)
        addSubview(extraStackView)

        friendEmptyImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(172)
            make.width.equalTo(245)
        }

        titleLabel.text = "就從加好友開始吧：）"
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        titleLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(friendEmptyImage.snp.bottom).offset(41)
            make.left.right.equalToSuperview().inset(44)
            make.height.equalTo(29)
        }

        contentLabel.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .lightGray
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 2
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(68)
        }

        addFriendButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(192)
            make.height.equalTo(40)
        }
        
        addFriendButton.layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 86/255, green: 179/255, blue: 11/255, alpha: 1).cgColor,
            UIColor(red: 166/255, green: 204/255, blue: 66/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.frame = addFriendButton.bounds
        addFriendButton.layer.insertSublayer(gradient, at: 0)
        addFriendButton.layer.cornerRadius = 20
        addFriendButton.clipsToBounds = true

        addFriendLabel.text = "加好友"
        addFriendLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addFriendLabel.textColor = .white
        addFriendLabel.textAlignment = .center
        addFriendLabel.snp.makeConstraints { make in
            make.edges.equalTo(addFriendButton).inset(UIEdgeInsets(top: 9, left: 48, bottom: 9, right: 48))
        }

        addFriendIcon.snp.makeConstraints { make in
            make.left.equalTo(addFriendLabel.snp.right).offset(16)
            make.centerY.equalTo(addFriendButton)
            make.width.height.equalTo(24)
        }

        extraStackView.axis = .horizontal
        extraStackView.spacing = 4
        extraStackView.alignment = .center
        
        extraLabel.text = "幫助好友更快找到你？"
        extraLabel.font = UIFont.systemFont(ofSize: 13)
        extraLabel.textColor = .lightGray
        
        settingIDLabel.attributedText = NSAttributedString(
            string: "設定 KOKO ID",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(red: 236/255, green: 0, blue: 140/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 13)
            ]
        )
        
        extraStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
