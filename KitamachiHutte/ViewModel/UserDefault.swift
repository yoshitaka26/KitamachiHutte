//
//  UserDefault.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/12.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum GlobalSetting {
    @UserDefault(key: "reservationName", defaultValue: "ゲスト")
    static var reservationName: String
    
    @UserDefault(key: "reservationID", defaultValue: "")
    static var reservationID: String
}
