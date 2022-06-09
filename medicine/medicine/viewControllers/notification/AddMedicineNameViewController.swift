//
//  AddMedicineNameViewController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/08.
//

import UIKit
import SnapKit
import Then

class AddMedicineNameViewController: UIViewController, ViewProtocol {
    let testNames = ["휴온스탈니플루메이트정", "휴자틴정150mg(니자티딘)", "세르젠정(살리실산이미다졸)", "리소젠정(리소짐염산염)", "리세론플러스정", "리버골드에프연질캡슐", "다나펜큐연질캡슐", "노말큐연질캡슐", "노바디크정5밀리그램(암로디핀베실산염)"]
    
    private let nameSearchBar = UISearchBar().then {
        $0.placeholder = "약품 이름을 검색해주세요"
        $0.returnKeyType = .done
    }
    
    private let nameTableView = UITableView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setConstraints()
    }
    
    // MARK: - View Protocol Methods
    internal func setUpValue() {
        nameSearchBar.searchTextField.delegate = self
        nameTableView.dataSource = self
        nameTableView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = nameSearchBar
    }
    
    internal func setUpView() {
        self.view.addSubview(nameTableView)
    }
    
    internal func setConstraints() {
        nameTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension AddMedicineNameViewController: UISearchTextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
}

extension AddMedicineNameViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = testNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = AddNotiTimeViewController()
        nextVC.medicineName = testNames[indexPath.row]
        self.pushView(VC: nextVC)
        nameTableView.deselectRow(at: indexPath, animated: true)
    }
}
