//
//  CalculatorBrain.swift
//  CalculatorByHangling
//
//  Created by JungHyesu on 2016. 9. 21..
//  Copyright © 2016년 hangling. All rights reserved.
//
//MVC패턴의 Model

import Foundation

//func multiply(_ op1: Double, op2: Double) -> Double {
//    return op1 * op2
//}

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    private var operations : Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOpertaion({ $0 * $1 }),
        "÷" : Operation.BinaryOpertaion({ $0 / $1 }),
        "+" : Operation.BinaryOpertaion({ $0 + $1 }),
        "−" : Operation.BinaryOpertaion({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    //스위프트는 enum은 함수를 가질 수도 있음, 저장 변수는 가질 수 없음, 상속 안됨
    private enum Operation {
        case Constant(Double) //상수연산
        case UnaryOperation((Double)->(Double)) //단항연산
        case BinaryOpertaion((Double, Double) -> Double) //이항연산
        case Equals
    }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            
            switch operation {
                case .Constant(let value): accumulator = value
                case .UnaryOperation(let foo): accumulator = foo(accumulator)
                case .BinaryOpertaion(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                case .Equals:
                    excutePendingBinaryOperation()
                }
            }
            
        }
    
    private func excutePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil

    }
        
//        switch symbol {
//            case "π": accumulator = M_PI
//            case "√": accumulator = sqrt(accumulator)
//            default : break
//        }
    }
    private var pending : PendingBinaryOperationInfo?
    
    //구조체 선언, 참조타입이 아니라 값타입.
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand : Double //첫번째 피연산자
    }
    
    //read only computed property
    var result: Double {
        get {
            return accumulator
        }
    }
}
