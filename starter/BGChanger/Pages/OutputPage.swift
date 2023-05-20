//
//  OutputPage.swift
//  BGChanger
//
//  Created by M Alfin Syahruddin on 18/05/23.
//

import SwiftUI


struct OutputPage: View {
    var image: UIImage
    
    var body: some View {
        PageContainer {
            Text("Output")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
            
            Spacer()
        }
    }
}
