//
//  FriendListTableView.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/13.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh

class FriendListTableView: UITableView {

    let friendListCellId = FriendListCell.friendListCellId
    let searchBar = UISearchBar()
    private let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 51))
    
    var onRefresh: (() -> Void)?
    var onLoadMore: (() -> Void)?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
        setupHeader()
        setupRefresh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
        setupHeader()
        setupRefresh()
    }

    private func setupTableView() {
        backgroundColor = .white
        separatorStyle = .none
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 60
        register(FriendListCell.self, forCellReuseIdentifier: friendListCellId)
    }

    private func setupHeader() {
        searchBar.backgroundImage = UIImage()

        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "searchBarIcon"), for: .normal)

        headerView.addSubview(button)
        headerView.addSubview(searchBar)

        button.snp.makeConstraints { make in
            make.right.equalTo(headerView.snp.right).offset(-10)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.left.equalTo(headerView).offset(10)
            make.right.equalTo(button.snp.left).offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
        }

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
            textField.attributedPlaceholder = NSAttributedString(string: "想轉一筆給誰呢？", attributes: attributes)
        }

        self.tableHeaderView = headerView
    }

    private func setupRefresh() {
        mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.onRefresh?()
        })

        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.onLoadMore?()
        })
    }

    func endRefreshing() {
        mj_header?.endRefreshing()
        mj_footer?.endRefreshing()
    }

    func endWithNoMoreData() {
        mj_footer?.endRefreshingWithNoMoreData()
    }

    func resetNoMoreData() {
        mj_footer?.resetNoMoreData()
    }
}
