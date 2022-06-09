//
//  SearchMedicineNameViewController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/08.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SearchMedicineNameViewController: UIViewController, ViewProtocol {
    private let disposBag = DisposeBag()
    private var medicineNames: [String] = []
    
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
        setAction()
    }
    
    // MARK: - Action Setting Method
    private func setAction() {
        nameSearchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                self.medicineNames = MedicineList.shared.filterMedicineNames(word: text)
                self.nameTableView.reloadData()
            })
            .disposed(by: disposBag)
    }
    
    // MARK: - View Protocol Methods
    internal func setUpValue() {
        nameTableView.dataSource = self
        nameTableView.delegate = self
        
        self.navigationController?.navigationBar.tintColor = .systemPink
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

extension SearchMedicineNameViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = medicineNames[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = AddNotiTimeViewController()
        nextVC.medicineName = medicineNames[indexPath.row]
        self.pushView(VC: nextVC)
        nameTableView.deselectRow(at: indexPath, animated: true)
    }
}
