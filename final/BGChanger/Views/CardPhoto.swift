//
//  CardPhoto.swift
//  BGChanger
//
//  Created by M Alfin Syahruddin on 18/05/23.
//

import SwiftUI

struct CardPhoto: View {
    var title: String
    var image: UIImage
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.75))
            
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
            }
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.25))
            .cornerRadius(8)
        }
        .padding(10)
        .background(.white.opacity(0.25))
        .cornerRadius(12)
    }
}
