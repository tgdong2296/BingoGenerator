//
//  ViewController.swift
//  BingoGenerator
//
//  Created by Giang Dong Trinh on 23/12/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var generateButton: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator.stopAnimating()
        textField.placeholder = "6 tickets in 1 page"
    }

    @IBAction func handleGenerateAction(_ sender: UIButton) {
        guard
            let baseImage = UIImage(named: "bingo_card"),
            let text = textField.text,
            let numberCard = Int(text)
        else {
            let alert = UIAlertController(title: "ERROR", message: "Invalid Input Data", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { _ in 
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        indicator.startAnimating()
        textField.isEnabled = false
        generateButton.isEnabled = false
        
        DispatchQueue.global().async {
            FileGenerator.shared.generateFiles(numberItems: numberCard, baseImage: baseImage, size: 120) { images in
                DispatchQueue.main.async {
                    print("LOG + FINISHED")
                    self.textField.isEnabled = true
                    self.generateButton.isEnabled = true
                    self.imageView.image = images.first
                    self.indicator.stopAnimating()
                }
            }
        }
    }
}


