//
//  HomeView.swift
//  BGChanger
//
//  Created by M Alfin Syahruddin on 18/05/23.
//

import SwiftUI
import Combine

struct HomePage: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        PageContainer {
            Text("BG Changer")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            HStack(spacing: 16) {
                CardPhoto(
                    title: "Your Photo",
                    image: vm.foregroundImage
                )
                
                CardPhoto(
                    title: "Background",
                    image: vm.backgroundImage
                )
            }
            
         
            Button(action: {
                vm.changeBackground()
            }) {
                Text("Change")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline.weight(.bold))
                    .foregroundColor(.white)
                    .background(Color(hex: "FFB800"))
                    .clipShape(Capsule())
            }
            
            .contentShape(Rectangle())
            
            Spacer()
        }
        .sheet(isPresented: $vm.showOutput) {
            OutputPage(
                image: vm.output
            )
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
