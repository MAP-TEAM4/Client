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
    
    func filterMedicineNames(word: String) -> [String] {
        let word = word.lowercased()
        var fileteredNames: [String] = []
        
        if (word == "") {
            medicineList.forEach { medicine in
                fileteredNames.append(medicine.itemName)
            }
            return fileteredNames
        }
        
        medicineList.forEach { medicine in
            let name = medicine.itemName
            if (name.lowercased().contains(word)) {
                fileteredNames.append(name)
            }
        }
        return fileteredNames
    }
}
