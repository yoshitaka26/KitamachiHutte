//
//  ContentView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/12.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("メニュー")
                }.tag(0)
            
            HuttePage()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("お店情報")
            }.tag(1)
            
            ReservationView(selection: $selection)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("予約")
            }.tag(2)
            
        }
//        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(OrderStore())
    }
}
