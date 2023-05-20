//
//  ImageProcessor.swift
//  BGChanger
//
//  Created by M Alfin Syahruddin on 18/05/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var foregroundImage = UIImage(named: "steve-jobs")!
    @Published var backgroundImage = UIImage(named: "microsoft")!
    @Published var output = UIImage()
    @Published var showOutput = false
    
    func changeBackground() {
     
    }
}
