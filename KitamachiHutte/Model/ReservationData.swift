//
//  ReservationData.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/29.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

class ReservationData : Identifiable, ObservableObject {
    @Published public var id: String       // ID
    @Published public var date: String    // 予約日
    @Published public var hour: String  // 予約時間
    @Published public var number: Int // 予約人数
    @Published public var menu: String    // 予約内容
    @Published public var other: String       // 要望
    @Published public var name: String  // 予約者名
    
    @Published public var dateForOrder: Date
    
    init(id: String, date: String, hour: String, number: Int, menu: String, other: String, name: String, dateForOrder: Date) {
        self.id = id
        self.date = date
        self.hour = hour
        self.number = number
        self.menu = menu
        self.other = other
        self.name = name
        self.dateForOrder = dateForOrder
    }
}
