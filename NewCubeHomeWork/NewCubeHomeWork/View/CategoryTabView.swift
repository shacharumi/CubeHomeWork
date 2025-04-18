//
//  CategoryTabView.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import UIKit
import SnapKit

class CategoryTabView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private let sliderView = UIView()
    var selectCase: Int? = 0
    var categories: [(title: String, badge: Int?)] = [
        ("好友", 2),
        ("聊天", 99)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(NavBarCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        sliderView.backgroundColor = .systemPink
        sliderView.layer.cornerRadius = 2
        sliderView.clipsToBounds = true
        
        addSubview(collectionView)
        addSubview(sliderView)
    }
    func setupCollectionView() {
        
        if selectCase == 0 {
            categories = [
                ("好友", 0),
                ("聊天", 0)
            ]
        } else if selectCase == 0 {
            categories = [
                ("好友", 0),
                ("聊天", 99)
            ]
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sliderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(4)
            make.width.equalTo(20)
            make.left.equalTo(collectionView.snp.left).offset(4)
        }
    }
    
    func updateSliderPosition(for indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let cellFrame = cell.frame
        self.sliderView.snp.updateConstraints { make in
            make.left.equalTo(self.collectionView.snp.left).offset(cellFrame.origin.x + 4)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NavBarCollectionViewCell
        cell.label.font = indexPath.row == 0
        ? UIFont.systemFont(ofSize: 13, weight: .medium)
        : UIFont.systemFont(ofSize: 13, weight: .regular)
        cell.badgeLabel.isHidden = (selectCase == 0)
        
        let item = categories[indexPath.row]
        cell.configure(category: item.title, badgeCount: item.badge)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSliderPosition(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryTitle = categories[indexPath.row].title
        let font = UIFont.systemFont(ofSize: 13, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        let textWidth = (categoryTitle as NSString).size(withAttributes: attributes).width + 20
        return CGSize(width: max(textWidth, 62), height: 30)
    }
    
}
