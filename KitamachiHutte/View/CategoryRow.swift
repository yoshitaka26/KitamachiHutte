//
//  CategoryRow.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/13.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct BentoCell: View {
    var items: Special
    
    var body: some View {
        VStack(alignment: .center) {
            items.image
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(items.caption)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryRow: View {
    var categoryName: String
    var items: [Special]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { bento in
                        NavigationLink(destination: BentoView(bento: bento)) {
                            BentoCell(items: bento)
                        }
                    }
                }
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(categoryName: "Flavor", items: dataStore.specials.filter { $0.category == .new })
    }
}
