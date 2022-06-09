//
//  MedicineModel.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Foundation

struct MedicineModel: Decodable {
    let itemName: String
    let entpName: String
    let medicImageUrl: String
    let className: String
}

class MedicineList {
    static let shared = MedicineList()
    
    var medicineList: [MedicineModel] = []
}
