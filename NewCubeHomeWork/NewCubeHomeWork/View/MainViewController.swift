//
//  MainViewController.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var selectCase: Int?
    var viewModel = FriendAndInviteViewModel()
    
    private let customNavBar = CustomInviteNavBar()
    private let contentTableView = FriendListTableView()
    private let categoryTabView = CategoryTabView()
    
    private var customNavBarHeightConstraint: Constraint?
    private var tableViewTopConstraint: Constraint?
    private var filteredFriendListData: [FriendListDetail] = []
    
    private var isSearching = false
    private var isSearchBarActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCategoryTabView()
        setupBasicView()
        setupRefreshActions()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.selectCase = selectCase
        categoryTabView.selectCase = selectCase
    }
}


extension MainViewController {
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        customNavBar.selectCase = self.selectCase
        customNavBar.isUserInteractionEnabled = true
        view.addSubview(customNavBar)
        
        customNavBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            self.customNavBarHeightConstraint = make.height.equalTo(175).constraint
        }
        
        contentTableView.isHidden = (selectCase == 0)
        view.addSubview(contentTableView)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.searchBar.delegate = self
        
        contentTableView.snp.makeConstraints { make in
            self.tableViewTopConstraint = make.top.equalTo(customNavBar.snp.bottom).offset(15).constraint
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupCategoryTabView() {
        categoryTabView.selectCase = self.selectCase ?? 0
        categoryTabView.setupCollectionView()
        customNavBar.addSubview(categoryTabView)
        
        categoryTabView.snp.makeConstraints { make in
            make.left.equalTo(customNavBar).offset(32)
            make.right.equalTo(customNavBar).offset(-32)
            make.bottom.equalTo(customNavBar).offset(0)
            make.height.equalTo(50)
        }
    }
    
    func setupBasicView() {
        let emptyStateView = EmptyStateView()
        emptyStateView.isHidden = (selectCase != 0)
        view.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupRefreshActions() {
        contentTableView.onRefresh = { [weak self] in
            self?.viewModel.refreshFriendList()
        }
        
        contentTableView.onLoadMore = { [weak self] in
            self?.viewModel.loadMoreFriendList()
        }
    }
    
    func animateSearchBarActivation(active: Bool) {
        if active {
            customNavBarHeightConstraint?.update(offset: 60)
            tableViewTopConstraint?.update(offset: -60)
        } else {
            let expandedHeight = customNavBar.calculatedExpandedHeight()
            customNavBarHeightConstraint?.update(offset: expandedHeight)
            tableViewTopConstraint?.update(offset: 15)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension MainViewController {
    
    func bindViewModel() {
        viewModel.onPersonDataUpdated = { [weak self] personData in
            guard let personData = personData.first else { return }
            self?.customNavBar.nameLabel.text = personData.name
            self?.customNavBar.idLabel.text = personData.kokoid
            self?.customNavBar.setupUI()
            self?.viewModel.fetchFriendData()
        }
        
        viewModel.onFriendAndInviteData = { [weak self] _ in
            guard let self = self else { return }
            self.filteredFriendListData = self.applySearch()
            self.contentTableView.reloadData()
            self.contentTableView.endRefreshing()
            
            if !self.viewModel.hasMoreData {
                self.contentTableView.endWithNoMoreData()
            } else {
                self.contentTableView.resetNoMoreData()
            }
            
            let indexPath = IndexPath(item: 0, section: 0)
            self.categoryTabView.updateSliderPosition(for: indexPath)
        }
        
        viewModel.onFilterDataUpdated = { [weak self] _ in
            guard let self = self else { return }
            self.customNavBar.setupInviteBoxes(inviteDataList: self.viewModel.inviteList)
            self.view.layoutIfNeeded()
            
            let initHeight = self.customNavBar.calculatedExpandedHeight()
            self.customNavBar.snp.remakeConstraints { make in
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
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
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
}


extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = true
        animateSearchBarActivation(active: true)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        contentTableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        animateSearchBarActivation(active: false)
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !searchText.isEmpty
        filteredFriendListData = applySearch()
        contentTableView.reloadData()
    }
    
    func applySearch() -> [FriendListDetail] {
        let keyword = contentTableView.searchBar.text ?? ""
        guard isSearching, !keyword.isEmpty else {
            return viewModel.friendList
        }
        return viewModel.friendList.filter { $0.name.contains(keyword) }
    }
}
