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
    private var storedMedicines: [String] = []
    
    private let medicineTableView = UITableView()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotiTimes()
    }
    
    // MARK: - Action Setting Method
    private func setAction() {
        addMedicineButton.addAction(UIAction { _ in
            self.pushView(VC: AddMedicineNameViewController())
        }, for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    internal func setUpValue() {
        medicineTableView.dataSource = self
        medicineTableView.delegate = self
        medicineTableView.register(
            NotiMedicineCell.self,
            forCellReuseIdentifier: NotiMedicineCell.cellIdentifier
        )
    }
    
    internal func setUpView() {
        _ = [
            addMedicineButton,
            medicineTableView
        ].map {
            self.view.addSubview($0)
        }
    }
    
    internal func setConstraints() {
        let leftMargin: CGFloat = 20
        let rightMargin: CGFloat = -20

        addMedicineButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(50)
        }
        
        medicineTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.bottom.equalTo(addMedicineButton).offset(-100)
        }
    }
}

extension NotiListViewController {
    func loadNotiTimes() {
        var keys: [String] = []
        let defaults = UserDefaults.standard
        defaults.dictionaryRepresentation().keys.forEach { key in
            if let firstChar = key.first, firstChar == "💊" {
                keys.append(key)
            }
        }
        storedMedicines = keys
        DispatchQueue.main.async {
            self.medicineTableView.reloadData()
        }
    }
    
    func deleteNotiTime(key: String) {
        let defaults = UserDefaults.standard
        let notificationCenter = UNUserNotificationCenter.current()
        let uuidString: String = defaults.array(forKey: key)?[0] as! String
        
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [uuidString])
        defaults.removeObject(forKey: key)
        loadNotiTimes()
    }
}

extension NotiListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedMedicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NotiMedicineCell.cellIdentifier, for: indexPath
        ) as? NotiMedicineCell else { return UITableViewCell() }
        
        cell.removeAllArrangedSubviews()
        
        let medicineName = storedMedicines[indexPath.row]
        
        guard var times = UserDefaults.standard.array(forKey: medicineName) else {
            return cell
        }
        
        times.removeFirst()
        
        let soretedTimes = (times as! [String]).sorted()
       
        soretedTimes.forEach({ time in
            let timeLabel = UILabel().then {
                $0.text = time
                $0.font = UIFont.systemFont(ofSize: 14)
            }
            cell.timeStackView.addArrangedSubview(timeLabel)
        })
        
        cell.nameLabel.text = medicineName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedName = storedMedicines[indexPath.row]
        let alert = Alert(title: "선택한 약품을 삭제하시겠습니까?", message: "설정한 알림이 모두 삭제됩니다") { _ in
            self.deleteNotiTime(key: selectedName)
        }
        self.present(alert.showAlert(), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
