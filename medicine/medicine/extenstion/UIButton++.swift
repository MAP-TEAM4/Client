//
//  UIButton++.swift
//  medicine
//
//  Created by 김동규 on 2022/06/10.
//

import UIKit

extension UIButton {
    func setCustom() {
        self.layer.cornerRadius = 7
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.backgroundColor = .systemPink
    }
}
