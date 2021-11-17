//
//  OwnerView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/29.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase

struct OwnerView: View {
    
    @EnvironmentObject var orderStore: OrderStore
    
    var body: some View {
        List {
            ForEach(orderStore.orders) { data in
                OwnerViewRow(reservation: data)
            }
        }
        .onAppear {
            loadReservationDetail()
        }
    }
    
    private func loadReservationDetail(){
        let db = Firestore.firestore()
        
        var reservationData = [ReservationData]()
        
        db.collectionGroup("reservation").addSnapshotListener { (querySnapshot, error) in
            
            if error != nil {
                print("There was an issue loading data from firestore")
            } else {
                print("Successfully loaded data")
                
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let id = data["id"] as? String, let name = data["name"] as? String, let date = data["date"] as? String, let hour = data["hour"] as? String, let number = data["number"] as? Int, let menu = data["menu"] as? String, let other = data["other"] as? String, let dateForOrder = data["dateForOrder"] as? Timestamp {
                            
                            if id == GlobalSetting.reservationID {
                                GlobalSetting.documentID = doc.documentID
                            }
                            
                            let reserveData = ReservationData(id: id, date: date, hour: hour, number: number, menu: menu, other: other, name: name, dateForOrder: dateForOrder.dateValue())
                            
                            reservationData.append(reserveData)
                        }
                    }
                    reservationData = reservationData.sorted(by: {(a, b) -> Bool in
                        return a.dateForOrder < b.dateForOrder
                    })
                    
                    orderStore.orders = reservationData
                }
            }
        }
    }
}

struct OwnerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
