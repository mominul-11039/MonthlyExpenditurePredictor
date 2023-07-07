//
//  TextRecognizer.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 4/7/23.
//

import Foundation
import Vision
import VisionKit

final class TextRecognizer{
    let cameraScan: VNDocumentCameraScan
    init(cameraScan:VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    private let queue = DispatchQueue(label: "scan-codes",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
    
    func recognizeText(withCompletionHandler completionHandler:@escaping ([String])-> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at: $0).cgImage
            })
            let imagesAndRequests = images.map({(image: $0, request:VNRecognizeTextRequest())})
            
            let textPerPage = imagesAndRequests.map{image,request->String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    request.recognitionLevel = .accurate
                    request.recognitionLanguages = ["en"]
                    request.customWords = Constant.appLexiconDictionary
                    try handler.perform([request])
                    guard let observations = request.results else{return ""}
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                }
                catch{
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}

