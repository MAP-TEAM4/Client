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
    private let logoEmojiLabel = UILabel().then {
        $0.text = "💊"
        $0.font = UIFont.systemFont(ofSize: 48, weight: .bold)
    }
    private let logoTextLabel = UILabel().then {
        $0.text = "삐-약"
        $0.tintColor = .systemPink
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
    }
    
    private let searchButton = UIButton().then {
        $0.setTitle("🔎  약품 검색", for: .normal)
        $0.setCustom()
    }
    
    private let notificationButton = UIButton().then {
        $0.setTitle("⏰  알림 설정", for: .normal)
        $0.setCustom()
    }
    
    private let ocrButton = UIButton().then {
        $0.setTitle("📷  사진 검색", for: .normal)
        $0.setCustom()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setConstraints()
        setAction()
        requestMedicineList()
    }
    
    // MARK: - Action Setting Method
    private func setAction() {
        searchButton.addAction(UIAction { _ in
            self.pushView(VC: SearchViewController())
        }, for: .touchUpInside)
        
        notificationButton.addAction(UIAction { _ in
            self.pushView(VC: NotiListViewController())
        }, for: .touchUpInside)
        
        ocrButton.addAction(UIAction { _ in
            self.pushView(VC: PhotoViewController())
        }, for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    func setUpValue() {}
    
    func setUpView() {
        _ = [
            logoEmojiLabel,
            logoTextLabel,
            searchButton,
            notificationButton,
//            ocrButton
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        let leftMargin: CGFloat = 40
        let rightMargin: CGFloat = -40
        
        logoEmojiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(220)
            make.centerX.equalToSuperview()
        }
        
        logoTextLabel.snp.makeConstraints { make in
            make.top.equalTo(logoEmojiLabel).offset(60)
            make.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(logoTextLabel).offset(150)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(50)
        }
        
//        ocrButton.snp.makeConstraints { make in
//            make.top.equalTo(searchButton).offset(70)
//            make.leading.equalToSuperview().offset(leftMargin)
//            make.trailing.equalToSuperview().offset(rightMargin)
//            make.height.equalTo(50)
//        }
        
        notificationButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton).offset(70)
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
