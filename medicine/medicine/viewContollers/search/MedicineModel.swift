//
//  MedicineInfo.swift
//  medicine
//
//  Created by 김영민 on 2022/06/03.
//

import Foundation

struct MedicineModel: Decodable {
    let itemName: String
    let entpyName: String
    let medicImageUrl: String
    let className: String
}

class MedicineList {
    static let shared = MedicineList()
    
    var medicineList: [MedicineModel] = []
    
}
