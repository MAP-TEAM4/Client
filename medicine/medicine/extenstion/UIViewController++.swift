//
//  UIViewController++.swift
//  medicine
//
//  Created by 김동규 on 2022/06/08.
//

import UIKit

extension UIViewController {
    func pushView(VC: UIViewController) {
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
