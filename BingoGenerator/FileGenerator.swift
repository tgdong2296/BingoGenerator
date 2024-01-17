//
//  FileGenerator.swift
//  BingoGenerator
//
//  Created by Giang Dong Trinh on 23/12/2020.
//

import Foundation
import UIKit

class FileGenerator {
    static let shared = FileGenerator()
    
    func generateFiles(numberItems: Int, baseImage: UIImage, size: CGFloat, completion: ([UIImage]) -> ()) {
        let images = ImageGenerator.shared.generateImages(numberItems: numberItems, baseImage: baseImage, size: size)
        
        for index in stride(from: 0, to: images.count, by: 6) {
            let cards: [UIImage] = Array(images[index...(index + 5)])
            
            let imageName = "CARD_\(index).png"
            print("[Generating][A4] \(imageName)")
            let cardPrint = ImageGenerator.shared.generateCardToPrint(cards: cards)
            
            let url = saveImage(imageName: imageName, image: cardPrint)
            if let url = url {
                print("[SUCCESS][\(imageName)] \(url)")
            } else {
                print("[ERROR][\(imageName)]")
            }
        }
        
//        for (index, image) in images.enumerated() {
//            let imageName = "CARD_\(index).png"
//            let url = saveImage(imageName: imageName, image: image)
//            if let url = url {
//                print("[SUCCESS][\(imageName)] \(url)")
//            } else {
//                print("[ERROR][\(imageName)]")
//            }
//        }
        completion(images)
    }
    
    func saveImage(imageName: String, image: UIImage) -> URL? {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return nil }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch let error {
            print("error saving file with error", error)
        }
        return nil
    }
}
