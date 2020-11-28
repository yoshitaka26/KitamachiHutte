//
//  NameView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/19.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct NameView: View {
    
    @State private var name = GlobalSetting.reservationName
    
    @State private var isSave = false
    
    @Binding var selection: Int
    
    var body: some View {
        
        VStack {
            Text("名前")
                .padding(.bottom, 5)
            Text("\(name)").padding(.bottom, 10)
            
            TextField("名前の登録", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                GlobalSetting.reservationName = name
                self.isSave = true
            }) {
                Text("登録")
            }.padding(50)
        }.onAppear(perform: {
            name = GlobalSetting.reservationName
        })
        
        Spacer().alert(isPresented: $isSave) {
            Alert(
                title: Text("名前が更新されました"),
                message: Text(""),
                dismissButton: .default(Text("確認"), action: {
                    self.selection = 1
                }))
            
        }
    }
}

struct NameView_Previews: PreviewProvider {
    @State static var selection = 2
    
    static var previews: some View {
        NameView(selection: $selection)
    }
}
