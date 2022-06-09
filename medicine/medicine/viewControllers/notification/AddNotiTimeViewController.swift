//
//  AddNotiTimeViewController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/08.
//

import UIKit
import SnapKit
import Then
import UserNotifications

class AddNotiTimeViewController: UIViewController, ViewProtocol {
    var medicineName = ""
  
    private var timeIndetifier = 0
    private var notificationTimes: [Date?] = []
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "복용 알림 시간을 추가해주세요"
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    }
    
    private let verticalStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    private let addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.setPreferredSymbolConfiguration(
            .init(pointSize: 18, weight: .regular, scale: .large),
            forImageIn: .normal
        )
        $0.tintColor = .systemGreen
        $0.setTitle("   시간 추가", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.contentHorizontalAlignment = .leading
    }
    
    private let completeButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("설정 완료", for: .normal)
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
        // 알림 시간 생성
        addButton.addAction(UIAction { _ in
            var timeCount = 0
            
            for time in self.notificationTimes {
                if (time != nil) {
                    timeCount += 1
                }
            }
            
            if (timeCount > 4) {
                let alert = Alert(
                    isAddCancel: false,
                    title: "",
                    message: "알림 시간을 최대 5개까지 가능합니다"
                ) { _ in }
                self.present(alert.showAlert(), animated: true)
                return
            }
            
            let addTimeStack = UIStackView().then {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.spacing = 10
                $0.tag = self.timeIndetifier
            }
            
            let deleteButton = UIButton().then {
                $0.tintColor = .systemRed
                $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
                $0.setPreferredSymbolConfiguration(
                    .init(pointSize: 18, weight: .regular, scale: .large),
                    forImageIn: .normal
                )
            }
            
            let timeDatePicker = UIDatePicker().then {
                $0.datePickerMode = .time
                $0.tintColor = .systemBlue
                
                self.notificationTimes.append($0.date)
                self.timeIndetifier += 1
            }
            
            let spacerView = UIView().then {
                $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            }
            
            // 알림 시간 변경
            timeDatePicker.addAction(UIAction { _ in
                self.notificationTimes[addTimeStack.tag] = timeDatePicker.date
            }, for: .valueChanged)
            
            // 알림 시간 삭제
            deleteButton.addAction(UIAction { _ in
                self.notificationTimes[addTimeStack.tag] = nil
                self.verticalStack.removeArrangedSubview(addTimeStack)
                addTimeStack.removeFromSuperview()
            }, for: .touchUpInside)
  
            addTimeStack.addArrangedSubview(deleteButton)
            addTimeStack.addArrangedSubview(timeDatePicker)
            addTimeStack.addArrangedSubview(spacerView)
            self.verticalStack.addArrangedSubview(addTimeStack)
        }, for: .touchUpInside)
        
        // 등록 완료
        completeButton.addAction(UIAction { _ in
            var isSettingTimes = false
            
            for time in self.notificationTimes {
                if (time != nil) {
                    isSettingTimes = true
                    break
                }
            }
            
            if (!isSettingTimes) {
                let alert = Alert(
                    isAddCancel: false,
                    title: "알림 시간을 추가해주세요",
                    message: ""
                ) { _ in }
                self.present(alert.showAlert(), animated: true)
                return
            }
            
            self.createUserNotification()
        }, for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    internal func setUpValue() {
        nameLabel.text = "💊 \(medicineName)"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    internal func setUpView() {
        verticalStack.addArrangedSubview(addButton)
        self.view.addSubview(nameLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(verticalStack)
        self.view.addSubview(completeButton)
    }
    
    internal func setConstraints() {
        let leftMargin: CGFloat = 25
        let rightMargin: CGFloat = -25
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).offset(50)
            make.centerX.equalToSuperview()
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(60)
            make.leading.equalToSuperview().offset(leftMargin)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-170)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(50)
        }
    }
}

extension AddNotiTimeViewController {
    func createUserNotification() {
        // 알림 권환 확인
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                print(error)
                return
            }

            if !granted {
                print("Not Granted")
                return
            }
        }
        // 알림 설정
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }()
        
        let uuidString = UUID().uuidString
        var scheduleTimes: Set<String> = []
        
        notificationTimes.forEach { scheduleTime in
            guard let scheduleTime = scheduleTime else { return }
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "💊 \(self.medicineName) 복용 시간입니다!"

            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: scheduleTime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

            self.notificationCenter.add(request) { error in
                if let error = error { print(error) }
            }
            
            let timeString = dateFormatter.string(from: scheduleTime)
            scheduleTimes.insert(timeString)
        }
        
        DispatchQueue.global().async {
            self.storeNotification(scheduleTimes: scheduleTimes, uuidString: uuidString)
        }
    }
    
    func storeNotification(scheduleTimes: Set<String>, uuidString: String) {
        let times = [uuidString] + Array(scheduleTimes)
        let defaults = UserDefaults.standard
        let key = "💊 \(medicineName)"
        
        if defaults.object(forKey: key) == nil {
            defaults.set(times, forKey: key)
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
            return
        }
        
        DispatchQueue.main.async {
            let alert = Alert(
                isAddCancel: false,
                title: "이미 등록되어 있는 약품입니다",
                message: "해당 약품 삭제 후 재등록해주세요"
            ) { _ in }
            self.present(alert.showAlert(), animated: true)
        }
    }
}
