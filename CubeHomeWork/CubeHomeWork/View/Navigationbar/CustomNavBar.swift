//
//  CustomNavBar.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/5.
//

import Foundation
import UIKit

class CustomNavBar: UIView {
    
    let nameLabel = UILabel()
    let idLabel = UILabel()
    var onBackButtonTapped: (() -> Void)?
    var viewModel: NoFriendViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
        
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
        
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nameLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        
        idLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        idLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        
        infoBackButton.setImage(UIImage(named: "InfoBackImage"), for: .normal)
        
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
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(icNavPinkWithdrawImage.snp.bottom).offset(35)
            make.height.equalTo(18)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel)
            make.height.equalTo(18)
        }
        
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
}
