//
//  ViewController.swift
//  medicine
//
//  Created by 김영민 on 2022/05/11.
//

import UIKit
import SnapKit


class SearchViewController: UIViewController {
    
    let sampleArr = ["노이로민정","마인트롤정","졸피뎀","멜록시캄","케토프로펜","올자핀정 2.5mg"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        layout()
        title = "약물 검색"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var TableView : UITableView = {
       let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sampleCell")
        tableView.dataSource = self
        tableView.isHidden = true
        
        return tableView
    }()
    
    private lazy var medicineSearchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "약을 검색하세요."
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private func layout() {
        
        view.addSubview(TableView)
        navigationItem.searchController = medicineSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        TableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}

extension SearchViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
        cell.textLabel?.text = sampleArr[indexPath.row]
        return cell
    }
    

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        TableView.isHidden = false
        
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        TableView.isHidden = true
    }
}
