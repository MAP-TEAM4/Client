//
//  ViewController.swift
//  medicine
//
//  Created by 김영민 on 2022/05/11.


import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Alamofire
import Kingfisher

class SearchViewController: UIViewController {
    let disposBag = DisposeBag()

    
    var mediArray = MedicineList.shared.medicineList
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        
        setup()
        layout()
       
        title = "약물 검색"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var TableView : UITableView = {
       let tableView = UITableView()
      
    
        tableView.register(MediCell.self, forCellReuseIdentifier: "sampleCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowRadius = 10
        tableView.backgroundColor = .systemBackground
  
        return tableView
    }()
    
    private lazy var medicineSearchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "약을 검색하세요."
    
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
    
    var searchQuery : String?
    var items = [MedicineModel]()
    
   
    
    private func setup() {
       
        medicineSearchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {t in
                self.items = self.mediArray.filter{ $0.itemName.hasSuffix(t) || $0.itemName.contains(t)}
                self.TableView.reloadData()
                self.searchQuery = t
            })
            .disposed(by: disposBag)
    }
  
    func search(query: String?) {
        guard let query = query, !query.isEmpty else {return}
        guard let url = URL(string: "http://ec2-52-79-100-20.ap-northeast-2.compute.amazonaws.com:8080/api/drug/detail") else {return}

        AF.request(
            url,
            method: .post,
            parameters: ["drugName":"\(query)"],
            encoder: JSONParameterEncoder.prettyPrinted)
            .responseDecodable(of:MedicineDetail.self){ response in
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        return
                    }
                    
                    let infoVC = MedicineInfoViewController()
                    
                    print(data.itemName)
                    print(data.mixtureItemName)
                    print(data.pregnancyBan)
                    print(data.oldBan)
                    print(data.sideEffect)
                    print(data.medicImageUrl)
                    
                    infoVC.nameLabel.text = data.itemName
                    infoVC.tabooNameLabel.text = data.mixtureItemName
                    infoVC.pregnant = data.pregnancyBan
                    infoVC.old = data.oldBan
                    infoVC.sideEffectDetailLabel.text = data.sideEffect
                    infoVC.imageUrl = data.medicImageUrl
                    self.pushView(VC: infoVC)
                }
//                guard case .success(let data) = response.result else {return print("error!!")}
            }
            .resume()

    }
 
}




extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as!
        MediCell
        
        
        cell.nameLabel.text = self.items[indexPath.row].itemName
        cell.setup()
        cell.selectionStyle = .none
        return cell
    }

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("test")
        self.search(query: self.items[indexPath.row].itemName)
    }
}

