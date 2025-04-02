//
//  ViewController.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/2.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let categories = ["好友", "聊天"]
    var collectionView: UICollectionView!
    let sliderView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)

        let customNavBar = UIView()
        customNavBar.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
        view.addSubview(customNavBar)

        let icNavPinkWithdrawImage = UIImageView(image: UIImage(named: "icNavPinkWithdraw"))
        let icNavPinkTransferImage = UIImageView(image: UIImage(named: "icNavPinkTransfer"))
        let icNavPinkScanImage = UIImageView(image: UIImage(named: "icNavPinkScan"))
        let dividerLine = UIView()
        dividerLine.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        let nameLabel = UILabel()
        let idLabel = UILabel()
        let infoBackButton = UIButton()
        let pinkPoint = UIImageView(image: UIImage(named: ""))
        let personImage = UIImageView(image: UIImage(named: "personImage"))
        let layout = UICollectionViewFlowLayout()
        let contentView = UIView()
        let friendEmptyImage = UIImageView(image: UIImage(named: "friendEmpty"))
        let emptyLabeltitle = UILabel()
        let emptyLabelContent = UILabel()
        let emptyLabelExtra = UILabel()
        let addFriendButton = UIView()
        let addFrendLabel = UILabel()
        let addFriendIcon = UIImageView(image: UIImage(named: "addFriendIcon"))
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TabCell.self, forCellWithReuseIdentifier: "cell")

        sliderView.backgroundColor = .systemPink
        view.addSubview(contentView)
        
        contentView.addSubview(friendEmptyImage)
        contentView.addSubview(emptyLabeltitle)
        contentView.addSubview(emptyLabelContent)
        contentView.addSubview(emptyLabelExtra)
        contentView.addSubview(addFriendButton)
        contentView.addSubview(addFrendLabel)
        contentView.addSubview(addFriendIcon)




        customNavBar.addSubview(icNavPinkWithdrawImage)
        customNavBar.addSubview(icNavPinkTransferImage)
        customNavBar.addSubview(icNavPinkScanImage)
        customNavBar.addSubview(collectionView)
        customNavBar.addSubview(sliderView)
        customNavBar.addSubview(dividerLine)
        customNavBar.addSubview(nameLabel)
        customNavBar.addSubview(idLabel)
        customNavBar.addSubview(infoBackButton)
        customNavBar.addSubview(pinkPoint)
        customNavBar.addSubview(personImage)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        friendEmptyImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(172)
            make.width.equalTo(245)
        }
        
        emptyLabeltitle.text = "就從加好友開始吧：）"
        emptyLabeltitle.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        emptyLabeltitle.textAlignment = .center
        emptyLabeltitle.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(44)
            make.right.equalTo(contentView).offset(-44)
            make.top.equalTo(friendEmptyImage.snp.bottom).offset(41)
            make.height.equalTo(29)
        }
        
        emptyLabelContent.text = "與好友們一起用 KOKO 聊起來！ 還能互相收付款、發紅包喔：）"
        emptyLabelContent.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        emptyLabelContent.textAlignment = .center
        emptyLabelContent.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(68)
            make.right.equalTo(contentView).offset(-67)
            make.top.equalTo(emptyLabeltitle.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        addFriendButton.snp.makeConstraints { make in
            make.top.equalTo(emptyLabelContent.snp.bottom).offset(25)
            make.left.equalTo(contentView).offset(92)
            make.right.equalTo(contentView).offset(91)
            make.height.equalTo(40)
        }
        
        emptyLabelExtra.text = "幫助好友更快找到你？設定 KOKO ID"
        emptyLabelExtra.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        emptyLabelExtra.textAlignment = .center
        emptyLabelExtra.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(43)
            make.right.equalTo(contentView).offset(-43)
            make.bottom.equalTo(contentView).offset(-5)
            make.height.equalTo(18)
        }
        
        customNavBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }

        icNavPinkWithdrawImage.snp.makeConstraints { make in
            make.left.equalTo(customNavBar).offset(20)
            make.height.width.equalTo(24)
            make.top.equalTo(customNavBar).offset(10)
        }
        icNavPinkTransferImage.snp.makeConstraints { make in
            make.left.equalTo(icNavPinkWithdrawImage.snp.right).offset(19.3)
            make.height.width.equalTo(24)
            make.top.equalTo(customNavBar).offset(10)
        }
        icNavPinkScanImage.snp.makeConstraints { make in
            make.right.equalTo(customNavBar).offset(-20)
            make.height.width.equalTo(24)
            make.top.equalTo(customNavBar).offset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(customNavBar).offset(30)
            make.top.equalTo(icNavPinkWithdrawImage.snp.bottom).offset(30.2)
            make.height.equalTo(18)
        }
        nameLabel.text = "test"
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nameLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(30)
            make.height.equalTo(18)
        }
        idLabel.text = "test"
        idLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        idLabel.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)

        infoBackButton.setImage(UIImage(named: "infoBackImage"), for: .normal)
        infoBackButton.snp.makeConstraints { make in
            make.left.equalTo(idLabel.snp.right)
            make.height.width.equalTo(18)
        }
        
        pinkPoint.snp.makeConstraints { make in
            make.left.equalTo(infoBackButton.snp.right).offset(15)
            make.height.width.equalTo(4)
        }
        
        personImage.snp.makeConstraints { make in
            make.right.equalTo(customNavBar).offset(-30)
            make.width.equalTo(52)
            make.height.equalTo(54)
            make.top.equalTo(nameLabel)
        }
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(customNavBar).offset(32)
            make.bottom.equalTo(dividerLine.snp.top).offset(-9)
            make.width.equalTo(customNavBar)
            make.height.equalTo(18)
        }

        sliderView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(3)
            make.height.equalTo(4)
            make.width.equalTo(20)
            make.left.equalTo(collectionView.snp.left)
        }

        dividerLine.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(customNavBar)
            make.height.equalTo(1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TabCell
        cell.label.text = categories[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = CGFloat(indexPath.item)
        UIView.animate(withDuration: 0.3) {
            self.sliderView.snp.updateConstraints { make in
                make.left.equalTo(self.collectionView.snp.left).offset(index * 62)
            }
            self.view.layoutIfNeeded()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 62, height: 30)
    }
}

class TabCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
