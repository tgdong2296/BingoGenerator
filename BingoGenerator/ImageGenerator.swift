//
//  ImageGenerator.swift
//  BingoGenerator
//
//  Created by Giang Dong Trinh on 23/12/2020.
//

import Foundation
import UIKit

class ImageGenerator {
    static let shared = ImageGenerator()
    
    let xCard: CGFloat = 0
    let yCard: CGFloat = 0
    let widthCard: CGFloat = 335
    let heightCard: CGFloat = 550
    
    let xBoard: CGFloat = 18
    let yBoard: CGFloat = 185
    let widthBoard: CGFloat = 300
    let heightBoard: CGFloat = 300
    
    let imageWidth: CGFloat = 1340
    let imageHeight: CGFloat = 2092
    
    var scaleRatio: CGFloat = 4
    
    var xNumber: CGFloat {
        return imageWidth / widthCard * xBoard
    }
    
    var yNumber: CGFloat {
        return imageHeight / heightCard * yBoard
    }
    
    var numberMargin: CGFloat {
        return 300 / 5 * 4
    }
    
    let a4Width: CGFloat = 1015 * 4
    let a4Height: CGFloat = 1435.5 * 4
    
    func generateCardToPrint(cards: [UIImage]) -> UIImage {
        let card_1_point = CGPoint(x: 0, y: 0)
        let card_2_point = CGPoint(x: card_1_point.x + imageWidth + 20, y: 0)
        let card_3_point = CGPoint(x: card_2_point.x + imageWidth + 20, y: 0)
        let card_4_point = CGPoint(x: 0, y: card_1_point.y + imageHeight + 1342)
        let card_5_point = CGPoint(x: card_4_point.x + imageWidth + 20, y: card_1_point.y + imageHeight + 1342)
        let card_6_point = CGPoint(x: card_5_point.x + imageWidth + 20, y: card_1_point.y + imageHeight + 1342)
        
        let baseImage = UIImage(named: "a4_form")!
        let form_1: UIImage! = cardToImage(card: cards[0], atPoint: card_1_point, baseImage: baseImage)
        let form_2: UIImage! = cardToImage(card: cards[1], atPoint: card_2_point, baseImage: form_1)
        let form_3: UIImage! = cardToImage(card: cards[2], atPoint: card_3_point, baseImage: form_2)
        let form_4: UIImage! = cardToImage(card: cards[3], atPoint: card_4_point, baseImage: form_3)
        let form_5: UIImage! = cardToImage(card: cards[4], atPoint: card_5_point, baseImage: form_4)
        let form_6: UIImage! = cardToImage(card: cards[5], atPoint: card_6_point, baseImage: form_5)
        
        return form_6
    }
    
    func generateImages(numberItems: Int, baseImage: UIImage, size: CGFloat) -> [UIImage] {
        var images: [UIImage] = []
        
        let matrixies = NumberGenerator.shared.generateNumberMatrix(numberOfMatrix: numberItems)
        
        for (matrixIndex, matrix) in matrixies.enumerated() {
            print("[Generating][Card] \(matrixIndex)")
            let card = generateCard(inImage: baseImage, size: size, matrix: matrix)
            images.append(card)
        }
        
        return images
    }
    
    func generateCard(inImage: UIImage, size: CGFloat, matrix: [[Int]]) -> UIImage {
        var resultImage: UIImage = inImage
        for (rowIndex, row) in matrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {
                let text = column < 10 ? "0\(column)" : "\(column)"
                let horizontalMargin: CGFloat = 245
                let verticalMargin: CGFloat = 250
                let x: CGFloat = (xNumber + 45) + horizontalMargin * CGFloat(columnIndex)
                let y: CGFloat = (yNumber + 45) + verticalMargin * CGFloat(rowIndex)
                resultImage = textToImage(drawText: text as NSString,
                                          inImage: resultImage,
                                          atPoint: CGPoint(x: x, y: y),
                                          size: size)!
            }
        }
        return resultImage
    }
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint: CGPoint, size: CGFloat) -> UIImage? {

        // Setup the font specific variables
        let textColor = UIColor(named: "219AB9") ?? .black
        let textFont = UIFont(name: "LondrinaSolid-Regular", size: size) ?? UIFont.systemFont(ofSize: size)

        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)

        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]

        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))

        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)

        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)

        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        // End the context now that we have the image we need
        UIGraphicsEndImageContext()

        //Pass the image back up to the caller
        return newImage
    }
    
    func cardToImage(card: UIImage, atPoint: CGPoint, baseImage: UIImage) -> UIImage? {
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(baseImage.size, false, scale)

        // Put the image into a rectangle as large as the original image
        baseImage.draw(in: CGRect(x: 0, y: 0, width: baseImage.size.width, height: baseImage.size.height))

        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: card.size.width, height: card.size.height)

        // Draw the text into an image
        card.draw(in: rect)

        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        // End the context now that we have the image we need
        UIGraphicsEndImageContext()

        //Pass the image back up to the caller
        return newImage
    }
}
