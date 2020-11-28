//
//  BentoView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/18.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct BentoView: View {
    var bento: Special
    
    var body: some View {
        VStack(alignment: .center) {
            bento.image
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(bento.caption).font(.title)
            Text(bento.text).font(.caption)
        }
    }
}

struct BentoView_Previews: PreviewProvider {
    static var previews: some View {
        BentoView(bento: dataStore.specials[0])
    }
}
