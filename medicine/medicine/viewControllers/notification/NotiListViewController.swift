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
    private var combinationMedic: Set<String> = []
    private var pregnancyMedic: [String] = []
    private var oldmanMedic: [String] = []
    
    private var storedMedicines: [String] = []
    
    private let medicineTableView = UITableView()
    
    private let addMedicineButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("복용 약품 추가", for: .normal)
        $0.setCustom()
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
        requestUserMedicineNoti()
    }
    
    // MARK: - Action Setting Method
    private func setAction() {
        addMedicineButton.addAction(UIAction { _ in
            self.pushView(VC: SearchMedicineNameViewController())
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
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
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
    
    func requestUserMedicineNoti() {
        var slicedNames: [String] = []
        storedMedicines.forEach { medicine in
            let startIdx = medicine.index(medicine.startIndex, offsetBy: 2)
            let sliced = medicine[startIdx...]
            slicedNames.append("\(sliced)")
        }
        
        UserMedicineService.shared.getUserMedicineNoti(storedMedicines: slicedNames) { data in
            print(data)
            data.combinationNoti.enumerated().forEach { (i, medic) in
                if (medic == "null") { return }
                let medic = "💊 \(medic)"
                self.combinationMedic.insert(medic)
                self.combinationMedic.insert(self.storedMedicines[i])
                
                if (data.pregnancyNoti[i]) {
                    self.pregnancyMedic.append(medic)
                }
                
                if (data.oldmanNoti[i]) {
                    self.oldmanMedic.append(medic)
                }
            }
            self.medicineTableView.reloadData()
        }
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
        
        // 셀 약품 이름 설정
        let medicineName = storedMedicines[indexPath.row]
        cell.nameLabel.text = medicineName
        
        // 셀 알림 시간 설정
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
        
        // 셀 약품 주의 사항 설정
        var drugPrecautionsText = ""
        if (Array(self.combinationMedic).contains(medicineName)) {
            drugPrecautionsText += "❗️ 병용 금기  "
        }
        if (self.pregnancyMedic.contains(medicineName)) {
            drugPrecautionsText += "🤰🏻 임부 금기  "
        }
        if (self.oldmanMedic.contains(medicineName)) {
            drugPrecautionsText += "👴🏻 노인 금기  "
        }
        if (drugPrecautionsText == "") {
            drugPrecautionsText += "✓ 안심"
            cell.drugPrecautionLabel.textColor = .systemGreen
        }
        cell.drugPrecautionLabel.text = drugPrecautionsText
        
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
        return 100
    }
}
