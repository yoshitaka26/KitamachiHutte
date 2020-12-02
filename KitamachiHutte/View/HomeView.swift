//
//  HomeView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/13.
//  Copyright © 2020 Yoshitaka. All rights reserved.


import SwiftUI

struct HomeView: View {
    
    var categories: [String: [Special]] {
        Dictionary(grouping: dataStore.specials, by: { $0.category.rawValue })
    }
    
    var featured: [Special] {
        dataStore.specials.filter { $0.isFeatured == true }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                PageView(self.featured.map { SpecialCard(special: $0)})
                    .frame(height: 280)
                
                ForEach(self.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
            }
            .navigationBarTitle(Text("メニュー"), displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
