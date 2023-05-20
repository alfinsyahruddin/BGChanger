//
//  ImageProcessor.swift
//  BGChanger
//
//  Created by M Alfin Syahruddin on 18/05/23.
//

import SwiftUI
import Combine
import Vision
import CoreImage.CIFilterBuiltins


class HomeViewModel: ObservableObject {
    @Published var foregroundImage = UIImage(named: "steve-jobs")!
    @Published var backgroundImage = UIImage(named: "microsoft")!
    @Published var output = UIImage()
    @Published var showOutput = false

    private let request = VNGeneratePersonSegmentationRequest()
    private let context = CIContext()
    
    func changeBackground() {
        guard let backgroundImage = backgroundImage.cgImage,
              let foregroundImage = foregroundImage.cgImage
        else {
            print("Missing required images")
            return
        }
                
        let requestHandler = VNImageRequestHandler(
            cgImage: foregroundImage,
            options: [:]
        )
        
        do {
            request.qualityLevel = .accurate
            try requestHandler.perform([request])
            
            guard let mask = request.results?.first else {
                print("Error generating person segmentation mask.")
                return
            }
            
            guard let output = blendImages(
                background: CIImage(cgImage: backgroundImage),
                foreground: CIImage(cgImage: foregroundImage),
                mask: CIImage(cvPixelBuffer: mask.pixelBuffer)
            ) else {
                print("Error blending images")
                return
            }
            
            if let result = convertImage(output) {
                self.output = result
                self.showOutput = true
            }
        } catch {
            print("Error processing person segmentation request")
        }        
    }
    
    private func blendImages(
        background: CIImage,
        foreground: CIImage,
        mask: CIImage
    ) -> CIImage? {
        let maskScaleX = foreground.extent.width / mask.extent.width
        let maskScaleY = foreground.extent.height / mask.extent.height
        let maskScaled = mask.transformed(
            by: __CGAffineTransformMake(maskScaleX, 0, 0, maskScaleY, 0, 0)
        )
        
        let backgroundScaleX = (foreground.extent.width / background.extent.width)
        let backgroundScaleY = (foreground.extent.height / background.extent.height)
        let backgroundScaled = background.transformed(
            by: __CGAffineTransformMake(backgroundScaleX, 0, 0, backgroundScaleY, 0, 0)
        )
        
        let blendFilter = CIFilter.blendWithMask()
        blendFilter.inputImage = foreground
        blendFilter.maskImage = maskScaled
        blendFilter.backgroundImage = backgroundScaled
        
        return blendFilter.outputImage
    }
    
    private func convertImage(_ image: CIImage) -> UIImage? {
        guard let cgImage = context.createCGImage(image, from: image.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
