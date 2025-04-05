//
//  FriendAndInviteVC.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/4.
//

import UIKit
import SnapKit

class FriendAndInviteVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let customNavBar = CustomInviteNavBar()
    private let viewModel = FriendAndInviteViewModel()
    private let contentTableView = FriendListTableView()
    private let categoryTabView = CategoryTabView()
    private var filteredFriendListData: [FriendListDetail] = []
    private var isSearching = false
    private var customNavBarHeightConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupCategoryTabView()
        setupRefreshActions()
        viewModel.fetchPersonData()
        viewModel.fetchFriendAndInviteData()
    }

    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white

        view.addSubview(customNavBar)
        view.addSubview(contentTableView)

        customNavBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            self.customNavBarHeightConstraint = make.height.equalTo(175).constraint
        }


        contentTableView.delegate = self
        contentTableView.dataSource = self

        contentTableView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentTableView.searchBar.delegate = self
    }

    private func setupCategoryTabView() {
        customNavBar.addSubview(categoryTabView)

        categoryTabView.snp.makeConstraints { make in
            make.left.equalTo(customNavBar).offset(32)
            make.right.equalTo(customNavBar).offset(-32)
            make.bottom.equalTo(customNavBar).offset(-10)
            make.height.equalTo(30)
        }

       
    }

    private func setupBindings() {
        viewModel.onPersonDataUpdated = { [weak self] person in
            guard let person = person.first else { return }
            self?.customNavBar.nameLabel.text = person.name
            self?.customNavBar.idLabel.text = person.kokoid
            self?.customNavBar.setupUI()
        }

        viewModel.onFriendAndInviteData = { [weak self] data in
            guard let self = self else { return }
            self.filteredFriendListData = self.applySearch()
            self.contentTableView.reloadData()
            self.contentTableView.endRefreshing()

            if !self.viewModel.hasMoreData {
                self.contentTableView.endWithNoMoreData()
            } else {
                self.contentTableView.resetNoMoreData()
            }
            customNavBar.setupInviteBoxes(viewModel: viewModel)
            view.layoutIfNeeded()
            let initHeight = customNavBar.calculatedExpandedHeight()
            customNavBar.snp.remakeConstraints() { make in
                make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
                
                self.customNavBarHeightConstraint = make.height.equalTo(initHeight).constraint
            }
        }
        
        customNavBar.inviteViewTapped = { [weak self] newHeight in
            self?.customNavBarHeightConstraint?.update(offset: newHeight)

            UIView.animate(withDuration: 0.3) {
                self?.view.layoutIfNeeded()
            }
        }
    }

    private func setupRefreshActions() {
        contentTableView.onRefresh = { [weak self] in
            self?.viewModel.refreshFriendAndInviteData()
        }

        contentTableView.onLoadMore = { [weak self] in
            self?.viewModel.loadMoreFriendList()
        }
    }

    private func applySearch() -> [FriendListDetail] {
        let keyword = contentTableView.searchBar.text ?? ""
        guard isSearching, !keyword.isEmpty else {
            return viewModel.friendList
        }
        return viewModel.friendList.filter { $0.name.contains(keyword) }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriendListData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contentTableView.friendListCellId, for: indexPath) as? FriendListCell else {
            return UITableViewCell()
        }

        let friend = filteredFriendListData[indexPath.row]
        cell.configure(with: friend)

        if friend.status == 2 {
            cell.invitedButton.setTitle("邀請中", for: .normal)
            cell.invitedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            cell.invitedButton.setImage(nil, for: .normal)
            cell.invitedButton.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
            cell.invitedButton.backgroundColor = .white
            cell.invitedButton.layer.borderColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1).cgColor
            cell.invitedButton.layer.borderWidth = 1.2
            cell.invitedButton.layer.cornerRadius = 2

            cell.invitedButton.snp.remakeConstraints { make in
                make.right.equalToSuperview()
                make.width.equalTo(60)
                make.height.equalTo(24)
                make.centerY.equalToSuperview()
            }
        }

        cell.friendStarImageView.isHidden = friend.isTop == "0"
        cell.selectionStyle = .none
        return cell
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !searchText.isEmpty
        filteredFriendListData = applySearch()
        contentTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredFriendListData = viewModel.friendList
        contentTableView.reloadData()
    }
}



