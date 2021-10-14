//
//  ViewController.swift
//  Cal
//
//  Created by KiraKiraAkira on 2021/10/9.
//

import UIKit
//var mmode:Bool=true
class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.text!=""
        // Do any additional setup after loading the view.
    }
    var digitOnDisplay:String{
        get{
            return self.displayLabel.text!
        }
        set{
            self.displayLabel.text=newValue
        }
    }
    
    var inTypingMode = false
    var inDotMode = true
    
    @IBOutlet weak var AcControl: UIButton!
    @IBAction func numberTouched(_ sender: UIButton) {
        if AcControl.currentTitle!=="AC"{
            //sender.currentTitle!="AC"
            AcControl.setTitle("C", for:.normal)
        }
        if inTypingMode{
            digitOnDisplay=digitOnDisplay+sender.currentTitle!
        }else{
            digitOnDisplay=sender.currentTitle!
            inTypingMode=true
        }
        if(digitOnDisplay == "inf"||digitOnDisplay == "-inf"||digitOnDisplay == "nan"){
                    digitOnDisplay = "Error"
                }
        print("Number \(sender.currentTitle!) touched!")
    }
    let calculator = Calculator()
    
    @IBAction func dotTouched(_ sender: UIButton) {
        if AcControl.currentTitle!=="AC"{
            //sender.currentTitle!="AC"
            AcControl.setTitle("C", for:.normal)
        }
        if digitOnDisplay.contains(sender.currentTitle!) {
            //do nothing
        }else{
            digitOnDisplay=digitOnDisplay+sender.currentTitle!
        }
    }
    
    @IBAction func changeAC(_ sender: UIButton) {
        if sender.currentTitle!=="C"{
            //sender.currentTitle!="AC"
            sender.setTitle("AC", for:.normal)
        }
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        if sender.currentTitle! == "("{
                    calculator.pendingOp1 = calculator.pendingOp
                    return
                }
        if sender.currentTitle == ")"{
                    calculator.pendingOp = calculator.pendingOp1
                }
        
        print("Operator \(sender.currentTitle!) touched!")
        if let op = sender.currentTitle{
            
            if Double(digitOnDisplay)==nil{
                return
            }
            if let result=calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                digitOnDisplay=String(result)
            }
        }
        inTypingMode = false
        if(digitOnDisplay == "inf"||digitOnDisplay == "-inf"||digitOnDisplay == "nan"){
                    digitOnDisplay = "Error"
                }
    }
    
    @IBAction func grandom(_ sender: UIButton) {
        digitOnDisplay=String(drand48())
    }
    @IBAction func radornot(_ sender: UIButton) {
        calculator.radornot()
        if sender.currentTitle=="Rad" {
            sender.setTitle("Deg", for: .normal)
        }else{
            sender.setTitle("Rad", for: .normal)
        }
        
        //print()
    }
    @IBOutlet weak var btn_eex: UIButton!
    @IBOutlet weak var btn_10x: UIButton!
    @IBOutlet weak var btn_ln: UIButton!
    @IBOutlet weak var btn_log10: UIButton!
    @IBOutlet weak var btn_sin: UIButton!
    @IBOutlet weak var btn_cos: UIButton!
    @IBOutlet weak var btn_tan: UIButton!
    @IBOutlet weak var btn_sinh: UIButton!
    @IBOutlet weak var btn_cosh: UIButton!
    @IBOutlet weak var btn_tanh: UIButton!
    
    @IBAction func changeSecondfunc(_ sender: UIButton) {
        
        calculator.changeSecond()
        let defaultcolor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        let highlightcolor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        if sender.backgroundColor==defaultcolor{
            sender.backgroundColor=highlightcolor
            btn_eex.setTitle("e^x", for: .normal)
            btn_10x.setTitle("10^x", for: .normal)
            btn_ln.setTitle("ln", for: .normal)
            btn_log10.setTitle("log10", for: .normal)
            btn_sin.setTitle("sin", for: .normal)
            btn_cos.setTitle("cos", for: .normal)
            btn_tan.setTitle("tan", for: .normal)
            btn_sinh.setTitle("sinh", for: .normal)
            btn_cosh.setTitle("cosh", for: .normal)
            btn_tanh.setTitle("tanh", for: .normal)
        }else{
            sender.backgroundColor=defaultcolor
            btn_eex.setTitle("y^x", for: .normal)
            btn_10x.setTitle("2^x", for: .normal)
            btn_ln.setTitle("logy", for: .normal)
            btn_log10.setTitle("log2", for: .normal)
            btn_sin.setTitle("sin^-1", for: .normal)
            btn_cos.setTitle("cos^-1", for: .normal)
            btn_tan.setTitle("tan^-1", for: .normal)
            btn_sinh.setTitle("sinh^-1", for: .normal)
            btn_cosh.setTitle("cosh^-1", for: .normal)
            btn_tanh.setTitle("tanh^-1", for: .normal)
        }
    }
    
    
}

