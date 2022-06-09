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

class SearchViewController: UIViewController {
    let disposBag = DisposeBag()
    
    
    var mediArray : [[String:Any]] = []
   
    let InfoViewController = MedicineInfoViewController()
    
    //let getRequest = PostService.TagService()
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sampleCell")
        tableView.dataSource = self
        tableView.delegate = self
  
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
    var items = [String]()
    var samples = ["서울","부산","대구","대전"]
    
    private func setup() {
       
        medicineSearchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {t in
                self.self.items = self.samples.filter{ $0.hasPrefix(t) }
                self.TableView.reloadData()
                
            })
            .disposed(by: disposBag)
        
        
//        func search(query: String?) {
//            guard let query = query, !query.isEmpty else {return}
//            guard let url = URL(string: "http://ec2-52-79-100-20.ap-northeast-2.compute.amazonaws.com:8080/api/drug/info") else {return}
//
//            AF.request(
//                url,
//                method: .post,
//                parameters: ["drugName":"\(query)"],
//                encoder: JSONParameterEncoder.prettyPrinted)
//                .responseDecodable(of:MedicineInfoList.self){[weak self] response in
//                    guard case .success(let data) = response.result else {return print("error!!")}
//                }
//                .resume()
//
//        }
    }
    
 
}




extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
        cell.textLabel?.text = self.items
        cell.selectionStyle = .none

        return cell
    }


}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let infoVC = self.InfoViewController
//        infoVC.nameLabel.text = mediArray[indexPath.row].itemName
        
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}

