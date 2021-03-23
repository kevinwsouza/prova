//
//  ViewController.swift
//  teste
//
//  Created by Kevin willian Jorge souza on 19/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    var number: [Numbers] = []
    var services = Service()
    var mult: Double = 0.0
    
    
    @IBOutlet weak var lbFirstString: UILabel!
    @IBOutlet weak var tfFirstNumber: UITextField!
    @IBOutlet weak var lbLastString: UILabel!
    @IBOutlet weak var tfLastNumber: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbResult.isHidden = true
        self.showSpinner()
        
        loadData()
    }
    
    
    @IBAction func btCalculate(_ sender: Any) {
        if let a = Double(tfFirstNumber.text!) , let b = Double(tfLastNumber.text!) {
            mult = (a * b)
            showResult()
        } else {
            let erro = "erro"
            lbResult.text = "\(erro)"
        }
        lbResult.isHidden = false
    }
    
    
    
    
    func loadData() {
        services.loadData { numbers in
            if let number = numbers{
                self.number = numbers!
                if let a = self.number.first?.myArray.first , let b = self.number.last?.myArray.last {
                    DispatchQueue.main.async {
                        self.removeSpinner()
                        self.tfFirstNumber.text = "\(a)"
                        self.tfLastNumber.text = "\(b)"
                    }
                }
            }
        }
    }   
    
    
    
    func showResult() {
        lbResult.text = "\(String(mult))"
        
    }
    
    
}

fileprivate var aView : UIView?
extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
