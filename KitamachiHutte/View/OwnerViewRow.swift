//
//  OwnerViewRow.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/29.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//


import SwiftUI

struct OwnerViewRow: View {
   
    var reservation: ReservationData
    
    var body: some View {
        VStack {
            HStack {
                Text(self.reservation.date)
                Text(self.reservation.hour)
            }
            HStack {
                Text(self.reservation.name)
                Text("\(self.reservation.number)人")
            }
            Text(self.reservation.menu)
            Text(self.reservation.other)
        }.padding()
    }
}

