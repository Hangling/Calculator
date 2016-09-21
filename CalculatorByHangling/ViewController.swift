//
//  ViewController.swift
//  CalculatorByHangling
//
//  Created by JungHyesu on 2016. 9. 21..
//  Copyright © 2016년 hangling. All rights reserved.
//
/*
 계산기 실습앱이 나오는 부분은 아이오에스 1강과 2강입니다.
 */

import UIKit

class ViewController: UIViewController {

    //옵셔널은 not set ,즉 nil로 초기화가 됨
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping: Bool = false
    
    //Swift 3.0에서 API디자인 가이드가 변경됨
    //Swift 2.3에서는 (sender: UIButton) 이었는데 3.0에서는 무조건 인자 앞에 언더바(_)를 명시해줘야함
    @IBAction private func touchdigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //print("touched \(digit) digit")
        
        if userIsInTheMiddleOfTyping {
        
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay+digit

        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
        
    }
    
    //computed property
    private var displayValue: Double {
        get {
            //값을 가져오기위해
            return Double(display.text!)!
        }
        set {
            //값을 설정하기위해
            display.text = String(newValue)
        }
    }
    
    //model에게 말을 하기 위해서 brain 인스턴스를 생성
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping  {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
            
            /*
             if mathmaticalSymbol == "π" {
             displayValue = M_PI
             //                display.text = String(M_PI)
             }else if mathmaticalSymbol == "√" {
             displayValue = sqrt(displayValue)
             }
             */
            
        }
        
        displayValue = brain.result
        
    }


}

