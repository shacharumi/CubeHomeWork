//
//  CustomInviteNavBar.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import Foundation
import UIKit

class CustomInviteNavBar: UIView {
    let nameLabel = UILabel()
    let idLabel = UILabel()
    var inviteViewTapped: ((CGFloat) -> Void)?
    var selectCase: Int? = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let icNavPinkWithdrawImage = UIImageView(image: UIImage(named: "icNavPinkWithdraw"))
        let icNavPinkTransferImage = UIImageView(image: UIImage(named: "icNavPinkTransfer"))
        let icNavPinkScanImage = UIImageView(image: UIImage(named: "icNavPinkScan"))
        let dividerLine = UIView()
        let infoBackButton = UIButton()
        let pinkPoint = UIImageView()
        let personImage = UIImageView(image: UIImage(named: "personImage"))

        dividerLine.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        pinkPoint.backgroundColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1)
        pinkPoint.layer.cornerRadius = 5
        pinkPoint.clipsToBounds = true

        addSubview(icNavPinkWithdrawImage)
        addSubview(icNavPinkTransferImage)
        addSubview(icNavPinkScanImage)
        addSubview(dividerLine)
        addSubview(nameLabel)
        addSubview(idLabel)
        addSubview(infoBackButton)
        addSubview(pinkPoint)
        addSubview(personImage)

        icNavPinkWithdrawImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
            make.top.equalToSuperview().offset(10)
        }

        icNavPinkTransferImage.snp.makeConstraints { make in
            make.left.equalTo(icNavPinkWithdrawImage.snp.right).offset(19.3)
            make.height.width.equalTo(24)
            make.top.equalToSuperview().offset(10)
        }

        icNavPinkScanImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(24)
            make.top.equalToSuperview().offset(10)
        }

        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nameLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(icNavPinkWithdrawImage.snp.bottom).offset(35)
            make.height.equalTo(18)
        }

        idLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        idLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel)
            make.height.equalTo(18)
        }

        infoBackButton.setImage(UIImage(named: "InfoBackImage"), for: .normal)
        infoBackButton.snp.makeConstraints { make in
            make.left.equalTo(idLabel.snp.right).offset(1)
            make.centerY.equalTo(idLabel)
            make.height.width.equalTo(18)
        }

        pinkPoint.snp.makeConstraints { make in
            make.left.equalTo(infoBackButton.snp.right).offset(15)
            make.centerY.equalTo(idLabel)
            make.height.width.equalTo(10)
        }

        personImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(52)
            make.height.equalTo(54)
            make.bottom.equalTo(idLabel)
        }

        dividerLine.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    var inviteViews: [UIView] = []
    private var originalFrames: [CGRect] = []
    private var isCollapsed = false
    private var isAnimating = false

    func setupInviteBoxes(inviteDataList: [FriendListDetail]) {
        clearInviteViews()
        for i in 0..<(inviteDataList.count) {
            let inviteView = UIView()
            inviteView.backgroundColor = .white
            inviteView.layer.cornerRadius = 10
            inviteView.layer.shadowColor = UIColor.black.cgColor
            inviteView.layer.shadowOpacity = 0.1
            inviteView.layer.shadowRadius = 5
            inviteView.layer.shadowOffset = CGSize(width: 0, height: 2)
            inviteView.tag = i

            let imageView = UIImageView(image: UIImage(named: "friendLisetDefault"))
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill

            let nameLabel = UILabel()
            nameLabel.numberOfLines = 0

            let name = inviteDataList[i].name
            let normalText = "\n邀請你成為好友：）"
            let fullText = name + normalText

            let attributedText = NSMutableAttributedString(string: fullText)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4

            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.count))

            attributedText.addAttributes([
                .foregroundColor: UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ], range: NSRange(location: 0, length: name.count))

            attributedText.addAttributes([
                .foregroundColor: UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 13, weight: .regular)
            ], range: NSRange(location: name.count, length: normalText.count))

            nameLabel.attributedText = attributedText
            
            inviteView.addSubview(imageView)
            inviteView.addSubview(nameLabel)

            let agreeButton = UIButton()
            agreeButton.setImage(UIImage(named: "agreeButton"), for: .normal)
 

            let deleteButton = UIButton()
            deleteButton.setImage(UIImage(named: "deleteButton"), for: .normal)
            inviteView.addSubview(deleteButton)
            inviteView.addSubview(agreeButton)
            
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(40)
            }

            nameLabel.snp.makeConstraints { make in
                make.left.equalTo(imageView.snp.right).offset(15)
                make.centerY.equalToSuperview()
            }
            
            deleteButton.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-15)
                make.height.width.equalTo(30)
                make.centerY.equalToSuperview()
            }
            
            agreeButton.snp.makeConstraints { make in
                make.right.equalTo(deleteButton.snp.left).offset(-15)
                make.height.width.equalTo(30)
                make.centerY.equalToSuperview()
            }
          
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(inviteViewTapped(_:)))
            inviteView.addGestureRecognizer(tapGesture)
            inviteView.isUserInteractionEnabled = true

            addSubview(inviteView)

            inviteView.snp.makeConstraints { make in
                make.top.equalTo(idLabel.snp.bottom).offset(CGFloat(i) * 80 + 35)
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
                make.height.equalTo(70)
            }
            inviteViews.append(inviteView)
        }
    }

    func clearInviteViews() {
        for view in inviteViews {
            view.removeFromSuperview()
        }
        inviteViews.removeAll()
    }

    
    @objc private func inviteViewTapped(_ gesture: UITapGestureRecognizer) {
        guard !isAnimating else { return }

        isAnimating = true

        if isCollapsed {
            expandViews()
        } else {
            collapseViews()
        }

        isCollapsed.toggle()
    }

    private func collapseViews() {
        guard inviteViews.count > 1 else {
            isAnimating = false
            return
        }

        let firstView = inviteViews[0]
        let baseY = firstView.frame.origin.y
        let collapsedHeight = baseY + CGFloat(inviteViews.count * 20) + 100

        UIView.animate(withDuration: 0.3, animations: {
            for i in 1..<self.inviteViews.count {
                let view = self.inviteViews[i]
                let offsetY = CGFloat(i * 5)
                let newY = baseY + offsetY
                let deltaY = newY - view.frame.origin.y
                view.transform = CGAffineTransform(translationX: 0, y: deltaY)
                self.insertSubview(view, belowSubview: firstView)
                self.inviteViewTapped?(collapsedHeight)

            }
        }, completion: { _ in
            self.isAnimating = false
        })
    }

    private func expandViews() {
        UIView.animate(withDuration: 0.3, animations: {
            for view in self.inviteViews {
                view.transform = .identity
            }
            if let last = self.inviteViews.last {
                let bottomY = last.frame.maxY
                self.inviteViewTapped?(bottomY + 70)
            }
        }, completion: { _ in
            self.isAnimating = false
        })
    }
    
    func calculatedExpandedHeight() -> CGFloat {
        guard let last = inviteViews.last else { return 175 }
        return last.frame.maxY + 70
    }
}

