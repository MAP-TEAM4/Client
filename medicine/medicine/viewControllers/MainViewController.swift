//
//  MainViewController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import UIKit
import SnapKit
import Then


class MainViewController: UIViewController, ViewProtocol {
    private let logoLabel = UILabel().then {
        $0.text = "앱 이름"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    private let searchButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("검색", for: .normal)
    }
    
    private let notificationButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("알림 설정", for: .normal)
    }
    
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
        searchButton.addAction(UIAction { _ in
            self.pushView(VC: SearchViewController())
        }, for: .touchUpInside)
        
        notificationButton.addAction(UIAction { _ in
            self.pushView(VC: NotiListViewController())
        }, for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    func setUpValue() {
        requestMedicineList()
    }
    
    func setUpView() {
        self.view.addSubview(logoLabel)
        self.view.addSubview(searchButton)
        self.view.addSubview(notificationButton)
    }
    
    func setConstraints() {
        let leftMargin: CGFloat = 20
        let rightMargin: CGFloat = -20
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(notificationButton).offset(-100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(50)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-170)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(50)
        }
    }
}

extension MainViewController {
    func requestMedicineList() {
        MedicineListService.shared.getMedicineAll { data in
            MedicineList.shared.medicineList = data
        }
    }
}
