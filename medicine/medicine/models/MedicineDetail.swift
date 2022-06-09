//
//  MedicineDetail.swift
//  medicine
//
//  Created by 김영민 on 2022/06/10.
//

import Foundation

struct MedicineDetail : Decodable {
    let itemName : String
    let mixtureItemName : String?
    let pregnancyBan : Bool
    let oldBan : Bool
    let sideEffect : String
    let medicImageUrl : String
}
