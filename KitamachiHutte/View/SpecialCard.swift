//
//  SpecialCard.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/16.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct SpecialCard: View {
    var special: Special
    
    var body: some View {
        self.special.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 280)
            .overlay(TextOverlay(special: self.special))
            .clipped()
    }
}

struct SpecialCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(dataStore.specials) { special in
                SpecialCard(special: special)
            }
        }
    }
}
