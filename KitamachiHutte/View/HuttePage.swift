//
//  HuttePage.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/18.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI
import MapKit

fileprivate let gradient = Gradient(colors: [.white, Color(red: 0.9, green: 0.9, blue: 0.9)])

fileprivate let liner = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)

fileprivate let location = CLLocationCoordinate2D(
    latitude: 35.761756,
    longitude: 139.651576)

struct HuttePage: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
//                    MapView(location: location).edgesIgnoringSafeArea(.init())
                    
                    Image("hutte")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .padding(.top, -60)
                    
                    Text("2021年春オープン予定")
                        .font(.largeTitle)
                        .bold()
                        
                    
                }
            }
            .navigationBarTitle("お店情報")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HuttePage_Previews: PreviewProvider {
    static var previews: some View {
        HuttePage()
    }
}
