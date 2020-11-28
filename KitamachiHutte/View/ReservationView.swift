//
//  ReservationView.swift
//  KitamachiHutte
//
//  Created by Yoshitaka on 2020/11/19.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import SwiftUI

struct ReservationView: View {
    
    @ObservedObject var keyboard = KeyboardObserver()
    
    @State public var currentOffset: CGFloat = CGFloat.zero
    @State public var openOffset: CGFloat = CGFloat.zero
    @State public var closeOffset: CGFloat = CGFloat.zero
    
    @Binding var selection: Int
    
    public func setInitPosition(viewWidth: CGFloat) {
        self.currentOffset = (viewWidth/2) * -1 + ((viewWidth * 0.5) / 2) * -1
        self.closeOffset = self.currentOffset
        self.openOffset = ((viewWidth / 2) * -1)+((viewWidth * 0.5) / 2)
    }
    
    public func toggleHamburgerMenu() {
        if (self.currentOffset == self.openOffset) {
            self.currentOffset = self.closeOffset
        } else {
            self.currentOffset = self.openOffset
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    ReservationDetail(selection: $selection)
                        .navigationBarTitle(Text("予約"), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            self.toggleHamburgerMenu()
                        }) {
                            Image(systemName: "list.dash")
                        })
                    
                    SubMenu(selection: $selection)
                        .background(Color.white)
                        .frame(width: geometry.size.width * 0.5)
                        .onAppear(perform: {
                            self.setInitPosition(viewWidth: geometry.size.width)
                        })
                        .offset(x: self.currentOffset)
                        .animation(.default)
                }
            }
            .onAppear {
                self.keyboard.startObserve()
            }.onDisappear {
                self.keyboard.stopObserve()
            }.padding(.bottom, 60)
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    @State static var selection = 2
    
    static var previews: some View {
        ReservationView(selection: $selection)
    }
}
