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
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .left
        label.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            label.font = isSelected ? UIFont.systemFont(ofSize: 13, weight: .medium) : UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
