//
//  MyReservationView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/27.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct MyReservationView: View {
    
    private var reservationDetai = ["予約名：", "予約日：", "時間：", "人数：", "内容：", "要望："]
    
    @EnvironmentObject var orderStore: OrderStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text(GlobalSetting.reservationID)
            
            HStack {
                Text("予約名：")
                if let data = orderStore.orders {
                    if data.count != 0 {
                        Text(data[0].name)
                    }
                }
            }
            
            HStack {
                Text("予約日：")
                if let data = orderStore.orders {
                    if data.count != 0 {
                        Text(data[0].dateForShow)
                    }
                }
            }
            
            HStack {
                Text("時間：")
                if let data = orderStore.orders {
                    if data.count != 0 {
                        Text(data[0].hourDetail)
                    }
                }
            }
            
            HStack {
                Text("人数：")
                if let data = orderStore.orders {
                    if data.count != 0 {
                        Text(String(data[0].number))
                    }
                }
            }
            
            HStack {
                Text("内容：")
                if let data = orderStore.orders {
                    if data.count != 0 {
                        Text(data[0].menuDetail)
                    }
                }
            }
            
            HStack {
                Text("要望：")
                if let data = orderStore.orders {
                    if data.count != 0 {
                        Text(data[0].other)
                    }
                }
            }
         
        })
    }
}

struct MyReservationView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyReservationView()
    }
}
