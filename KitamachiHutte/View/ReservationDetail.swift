//
//  ReservationDetail.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/19.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase

struct ReservationDetail: View {
    
    private let reservationHours = ["18:00", "18:30", "19:00", "19:30", "20:00"]
    private let orderCourseMenu = ["座席のみ", "季節のコース", "特上コース", "おまかせ"]
    private let reservationNumbers = [1, 2, 3, 4]
    
    @State private var reservationHour: Int = 0
    @State private var orderCourse: Int = 0
    @State private var reservation: Int = 0
    
    @State private var selectionDate = Date()
    
    @State private var other = ""
    
    @State private var toSave = false
    @State private var isSave = false
    @State private var isfailed = false
    
    @Binding var selection: Int
    
    @EnvironmentObject var orderStore: OrderStore
    
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        var dayComponent = DateComponents()
        var todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        dayComponent.day = 200
        let startfixed = calendar.date(byAdding: dayComponent, to: Date())
        let startComponents = Calendar.current.dateComponents([.year, .month, .day], from: startfixed!)
        
        dayComponent.day = 207
        let endfixed = calendar.date(byAdding: dayComponent, to: Date())
        let endComponents = Calendar.current.dateComponents([.year, .month, .day], from: endfixed!)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from: endComponents)!
    }()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("予約日")
                        .padding(.leading).lineLimit(1)
                        .frame(minWidth: 80)
                    DatePicker("予約日", selection: self.$selectionDate, in: self.dateRange, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .frame(minWidth: 150, idealWidth:200, maxWidth: 300, minHeight: 200)
                        .clipped()
                }
                
                HStack {
                    Text("予約時間")
                        .padding(.leading)
                    Picker(selection: self.$reservationHour, label: Text("予約時間")) {
                        ForEach(0 ..< self.reservationHours.count) {
                            Text(self.reservationHours[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                HStack {
                    Text("予約人数")
                        .padding(.leading)
                    Picker(selection: self.$reservation, label: Text("予約人数")) {
                        ForEach(0 ..< self.reservationNumbers.count) {
                            Text("\(self.reservationNumbers[$0])人")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding(.trailing)
                }
                
                HStack {
                    Text("予約内容")
                        .padding(.leading)
                    Picker(selection: self.$orderCourse, label: Text("予約内容")) {
                        ForEach(0 ..< self.orderCourseMenu.count) {
                            Text(self.orderCourseMenu[$0])
                        }
                    }.labelsHidden()
                    .frame(minWidth: 200, minHeight: 50)
                    .clipped()
                }
                
                TextField("その他ご要望", text: self.$other)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Divider()
                
                Button(action: {
                    self.toSave = true
                }) {
                    Text("予約する")
                }.padding(50)
            }
            
            Spacer().alert(isPresented: $toSave) {
                Alert(
                    title: Text("予約しますか？"),
                    message: Text(""),
                    primaryButton: .default(Text("確定"), action: {
                        if GlobalSetting.reservationID == "" {
                            self.save()
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                self.isfailed = true
                            }
                        }
                    }),
                    secondaryButton: .cancel(Text("キャンセル")))
            }
            
            Spacer().alert(isPresented: $isSave) {
                Alert(
                    title: Text("予約が完了しました"),
                    message: Text(""),
                    dismissButton: .default(Text("確認")))
            }
            
            Spacer().alert(isPresented: $isfailed) {
                Alert(
                    title: Text("すでに予約が存在します"),
                    message: Text("変更希望の場合は一度予約取消をお願い致します。"),
                    dismissButton: .default(Text("確認")))
            }
        }.onAppear(perform: {
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            
            dayComponent.day = 200
            let startfixed = calendar.date(byAdding: dayComponent, to: Date())
            selectionDate = startfixed!
        })
    }
    
    private func save() {
        let newID = UUID().uuidString
        let name = GlobalSetting.reservationName
        
        let newData = OrderEntity(id: newID, date: selectionDate, hour: reservationHour, number: reservation + 1, menu: orderCourse, other: other, name: name)
        
        saveToFirebase(newData: newData)
        
        GlobalSetting.reservationID = newID
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.isSave = true
            self.clear()
            self.selection = 1
        }
    }
    
    private func clear() {
        selectionDate = Date()
        reservationHour = 0
        reservation = 0
        orderCourse = 0
        other = ""
    }
    
    private func saveToFirebase(newData: OrderEntity) {
        let db = Firestore.firestore()
        
        db.collection("reservation").addDocument(data: [
            "id": newData.id,
            "name": newData.name,
            "date": newData.dateForShow,
            "hour": newData.hourDetail,
            "number": newData.number,
            "menu": newData.menuDetail,
            "other": newData.other,
            "dateForOrder": newData.date
        ]) { (error) in
            if error != nil {
                print("There was an issue saving data to firestore")
            } else {
                print("Successfully saved data")
            }
        }
    }
}

struct ReservationDetail_Previews: PreviewProvider {
    @State static var selection = 2
    
    static var previews: some View {
        ReservationDetail(selection: $selection)
    }
}
