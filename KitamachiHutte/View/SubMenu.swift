//
//  SubMenu.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/19.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct SubMenu: View {
    @State var moveToNameView = false
    @State var moveToMyReservationView = false
    @State var moveToOwnerView = false
    
    @Binding var selection: Int
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    NavigationLink(destination: NameView(selection: $selection), isActive: self.$moveToNameView) {
                        EmptyView()
                    }
                    NavigationLink(destination: MyReservationView(), isActive: self.$moveToMyReservationView) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: OwnerView(), isActive: self.$moveToOwnerView) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        self.moveToNameView = true
                    }) {
                        Text("名前を登録")
                            .padding(.vertical, 20)
                    }
                    
                    Button(action: {
                        
                        self.moveToMyReservationView = true
                        
                    }) {
                        Text("予約状況の確認")
                            .padding(.vertical, 20)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SubMenu_Previews: PreviewProvider {
    @State static var selection = 2
    
    static var previews: some View {
        SubMenu(selection: $selection)
    }
}
