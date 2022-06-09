//
//  NotiListViewController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/06.
//

import UIKit
import SnapKit
import Then
import UserNotifications

class NotiListViewController: UIViewController, ViewProtocol {
    private let addMedicineButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("복용 약품 추가", for: .normal)
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
        addMedicineButton.addAction(UIAction { _ in
            self.pushView(VC: AddMedicineNameViewController())
        }, for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    internal func setUpValue() {}
    
    internal func setUpView() {
        _ = [
            addMedicineButton
        ].map {
            self.view.addSubview($0)
        }
    }
    
    internal func setConstraints() {
        let leftMargin: CGFloat = 20
        let rightMargin: CGFloat = -20

        addMedicineButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(50)
        }
    }
}
