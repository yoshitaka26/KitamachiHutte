//
//  MyReservationView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/27.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase

struct MyReservationView: View {
    
    private var reservationDetai = ["予約名：", "予約日：", "時間：", "人数：", "内容：", "要望："]
    
    @State private var isSave = false
    
    @EnvironmentObject var orderStore: OrderStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Text("予約名：")
                if let data = checkIfMyReservation(reservationData: orderStore.orders) {
                    Text(data.name)
                }
            }
            
            HStack {
                Text("予約日：")
                if let data = checkIfMyReservation(reservationData: orderStore.orders) {
                    Text(data.date)
                    
                }
            }
            
            HStack {
                Text("時間：")
                if let data = checkIfMyReservation(reservationData: orderStore.orders) {
                    Text(data.hour)
                }
            }
            
            HStack {
                Text("人数：")
                if let data = checkIfMyReservation(reservationData: orderStore.orders) {
                    Text(String(data.number))
                }
            }
            
            HStack {
                Text("内容：")
                if let data = checkIfMyReservation(reservationData: orderStore.orders) {
                    Text(data.menu)
                }
            }
            
            HStack {
                Text("要望：")
                if let data = checkIfMyReservation(reservationData: orderStore.orders) {
                    Text(data.other)
                }
            }
            
            Button(action: {
                if GlobalSetting.reservationID != "" {
                    deleteReservation(id: GlobalSetting.documentID)
                    GlobalSetting.reservationID = ""
                    GlobalSetting.documentID = ""
                    self.isSave = true
                }
            }) {
                Text("予約取消")
            }.padding(50)
        }.onAppear {
            loadReservationDetail()
        }
        
        Spacer().alert(isPresented: $isSave) {
            Alert(
                title: Text("予約が取り消されました"),
                message: Text(""),
                dismissButton: .default(Text("確認"), action: {
                    print("delete")
                }))
            
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
                        } else {
                            print("failed")
                        }
                    }
                    DispatchQueue.main.async {
                        orderStore.orders = reservationData
                    }
                }
            }
            
        }
    }
    
    private func checkIfMyReservation(reservationData: [ReservationData]) -> ReservationData? {
        let myReservation = reservationData.filter { $0.id == GlobalSetting.reservationID }
        
        if myReservation.count == 1 {
            return myReservation[0]
        } else {
            return nil
        }
    }
    
    private func deleteReservation(id : String) {
        let db = Firestore.firestore()
        
        let documentID = GlobalSetting.documentID
        
        db.collection("reservation").document(documentID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

struct MyReservationView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyReservationView()
    }
}
