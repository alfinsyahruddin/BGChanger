//
//  Page.swift
//  BGChanger
//
//  Created by M Alfin Syahruddin on 18/05/23.
//

import SwiftUI

struct PageContainer<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        .init(hex: "38B7FF"),
                        .init(hex: "1B8DE0")
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                content()
            }
            .padding(16)
        }
    }
}
