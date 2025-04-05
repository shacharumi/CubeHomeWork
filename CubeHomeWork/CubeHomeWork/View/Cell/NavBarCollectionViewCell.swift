//
//  NavBarCollectionViewCell.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/5.
//

import Foundation
import UIKit

class NavBarCollectionViewCell: UICollectionViewCell {
    static let cellId = "NavBarCollectionViewCell"

    let label = UILabel()
    private let badgeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.textAlignment = .left
        label.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        contentView.addSubview(label)

        badgeLabel.backgroundColor = UIColor(red: 1, green: 0.7, blue: 0.87, alpha: 1)
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.isHidden = true
        contentView.addSubview(badgeLabel)

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        badgeLabel.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(-40)
            make.centerY.equalTo(label.snp.top)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(18)
        }
    }

    override var isSelected: Bool {
        didSet {
            label.font = isSelected
                ? UIFont.systemFont(ofSize: 13, weight: .medium)
                : UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }

    func configure(category: String, badgeCount: Int?) {
        label.text = category

        if let count = badgeCount {
            badgeLabel.isHidden = false
            badgeLabel.text = count >= 99 ? " 99+ " : "\(count)"
        } else {
            badgeLabel.isHidden = true
        }
        
        if badgeCount == 0 {
            badgeLabel.isHidden = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
