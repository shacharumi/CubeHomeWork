//
//  NoFriendViewController.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/2.
//

import UIKit
import SnapKit

class NoFriendViewController: UIViewController {
    
    private let viewModel = NoFriendViewModel()
    private let customNavBar = CustomNavBar()
    private var collectionView: UICollectionView!
    private let contentView = UIView()
    private let emptyLabeltitle = UILabel()
    private let emptyLabelContent = UILabel()
    private let emptyLabelExtra = UILabel()
    private let emptyLabelSettingID = UILabel()
    private let addFriendButton = UIView()
    private let addFrendLabel = UILabel()
    private let sliderView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onPersonDataUpdated = { [weak self] response in
            guard let self = self else { return }
            if let personData = response.first {
                self.customNavBar.nameLabel.text = personData.name
                self.customNavBar.idLabel.text = personData.kokoid
                self.setupUI()
            }
        }
    }

    private func setupUI() {
        setupBasicUI()
        setupEmptyStateUI()
        setupCollectionView()
    }
    
    private func setupBasicUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(customNavBar)
        view.addSubview(contentView)
        
        customNavBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(175)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupEmptyStateUI() {
        let friendEmptyImage = UIImageView(image: UIImage(named: "friendEmpty"))
        let addFriendIcon = UIImageView(image: UIImage(named: "addFriendIcon"))

        contentView.addSubview(friendEmptyImage)
        contentView.addSubview(emptyLabeltitle)
        contentView.addSubview(emptyLabelContent)
        contentView.addSubview(addFriendButton)
        contentView.addSubview(addFrendLabel)
        contentView.addSubview(addFriendIcon)

        let extraStackView = UIStackView(arrangedSubviews: [emptyLabelExtra, emptyLabelSettingID])
        extraStackView.axis = .horizontal
        extraStackView.spacing = 4
        extraStackView.alignment = .center
        extraStackView.distribution = .equalSpacing

        contentView.addSubview(extraStackView)

        friendEmptyImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(172)
            make.width.equalTo(245)
        }

        emptyLabeltitle.text = "就從加好友開始吧：）"
        emptyLabeltitle.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        emptyLabeltitle.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        emptyLabeltitle.textAlignment = .center
        emptyLabeltitle.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(44)
            make.right.equalTo(contentView).offset(-44)
            make.top.equalTo(friendEmptyImage.snp.bottom).offset(41)
            make.height.equalTo(29)
        }

        emptyLabelContent.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        emptyLabelContent.numberOfLines = 2
        emptyLabelContent.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emptyLabelContent.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        emptyLabelContent.textAlignment = .center
        emptyLabelContent.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(68)
            make.right.equalTo(contentView).offset(-67)
            make.top.equalTo(emptyLabeltitle.snp.bottom).offset(8)
            make.height.equalTo(40)
        }

        addFriendButton.snp.makeConstraints { make in
            make.top.equalTo(emptyLabelContent.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(192)
        }

        addFriendButton.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 86/255, green: 179/255, blue: 11/255, alpha: 1).cgColor,
            UIColor(red: 166/255, green: 204/255, blue: 66/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = addFriendButton.bounds
        addFriendButton.layer.insertSublayer(gradientLayer, at: 0)
        addFriendButton.layer.cornerRadius = 20
        addFriendButton.clipsToBounds = true

        addFrendLabel.text = "加好友"
        addFrendLabel.textColor = .white
        addFrendLabel.textAlignment = .center
        addFrendLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addFrendLabel.snp.makeConstraints { make in
            make.top.equalTo(addFriendButton).offset(9)
            make.bottom.equalTo(addFriendButton).offset(-9)
            make.left.equalTo(addFriendButton).offset(48)
            make.right.equalTo(addFriendButton).offset(-48)
        }

        addFriendIcon.snp.makeConstraints { make in
            make.left.equalTo(addFrendLabel.snp.right).offset(16)
            make.top.equalTo(addFriendButton).offset(8)
            make.bottom.equalTo(addFriendButton).offset(-8)
            make.width.equalTo(24)
        }

        emptyLabelExtra.text = "幫助好友更快找到你？"
        emptyLabelExtra.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        emptyLabelExtra.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        emptyLabelExtra.textAlignment = .center
        
        let attributedString = NSAttributedString(
            string: "設定 KOKO ID",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 13, weight: .regular)
            ]
        )
        emptyLabelSettingID.attributedText = attributedString
        emptyLabelSettingID.textAlignment = .left

        extraStackView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-20)
            make.height.equalTo(18)
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let cellId = NavBarCollectionViewCell.cellId
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(NavBarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        sliderView.backgroundColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1)
        sliderView.layer.cornerRadius = 2
        sliderView.clipsToBounds = true
        customNavBar.addSubview(collectionView)
        customNavBar.addSubview(sliderView)
        
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(customNavBar).offset(32)
            make.bottom.equalTo(customNavBar).offset(-10)
            make.width.equalTo(customNavBar)
            make.height.equalTo(18)
        }
        
        sliderView.snp.makeConstraints { make in
            make.bottom.equalTo(customNavBar.snp.bottom).offset(-1)
            make.height.equalTo(4)
            make.width.equalTo(20)
            make.left.equalTo(collectionView.snp.left).offset(4)
        }
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 0)
            self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        }
    }
}

extension NoFriendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NavBarCollectionViewCell.cellId, for: indexPath) as! NavBarCollectionViewCell
        if indexPath.row == 0 {
            cell.label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        } else {
            cell.label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
        cell.label.text = viewModel.categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let cellFrame = cell.frame
            UIView.animate(withDuration: 0.3) {
                self.sliderView.snp.updateConstraints { make in
                    make.left.equalTo(self.collectionView.snp.left).offset(cellFrame.origin.x + 4)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = viewModel.categories[indexPath.row]
        let font = UIFont.systemFont(ofSize: 13, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        let width = (category as NSString).size(withAttributes: attributes).width + 20
        return CGSize(width: max(width, 62), height: 30)
    }
}
