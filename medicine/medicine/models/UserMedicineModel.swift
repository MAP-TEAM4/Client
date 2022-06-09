//
//  UserMedicineModel.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Foundation

struct UserMedicineNoti: Decodable {
    let pregnancyNoti: [Bool]
    let combinationNoti: [String]
    let oldmanNoti: [Bool]
    
    enum CodingKeys: String, CodingKey {
        case pregnancyNoti = "임부금기여부"
        case combinationNoti = "병용금기약품"
        case oldmanNoti = "노인주의여부"
    }
}
