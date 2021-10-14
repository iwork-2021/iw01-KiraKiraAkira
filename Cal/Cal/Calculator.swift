//
//  Calculator.swift
//  Cal
//
//  Created by KiraKiraAkira on 2021/10/11.
//

import UIKit

func generateRN(t:Int) -> Double {
    srand48(t)
    return drand48()
    //return Double(arc4random())/0xffffffff
}
func getRadOp(st:Bool,op:Double) -> Double {
    if st{
        return op/180.0*Double.pi
    }else{
        return op*180.0/Double.pi
    }
}
var mmode:Bool = true
var second:Bool = true
var memoryNum:Double = 0
class Calculator: NSObject {
    var mem:String
    //var st:Bool
    override init() {
        mem=""
        //st=true
    }
    func radornot() {
        mmode = !mmode
        print(mmode)
    }
    func changeSecond()  {
        second = !second
        print(second)
    }
    
    enum Operation {
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    var operations=[
        "+": Operation.BinaryOp{
            op1,op2 in
            return op1+op2
        },
        "-": Operation.BinaryOp{
            op1,op2 in
            return op1-op2
        },
        "*": Operation.BinaryOp{
            op1,op2 in
            return op1*op2
        },
        "/": Operation.BinaryOp{
            op1,op2 in
            return op1/op2
        },
        "=": Operation.EqualOp,
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        "AC": Operation.UnaryOp{
            _ in
            return 0
        },
        "%": Operation.UnaryOp{
            op in
            return op/100.0
        },
        "." :Operation.Constant(3.14),
        /*
        "2^x":Operation.UnaryOp{
            op in
            return pow(2, op)
        },*/
        "x^2":Operation.UnaryOp{
            op in
            return pow(op, 2)
        },
        "x^3":Operation.UnaryOp{
            op in
            return pow(op, 3)
        },
        "e^x":Operation.UnaryOp{
            op in
            return pow(2.71, op)
        },
        "10^x":Operation.UnaryOp{
            op in
            return pow(10, op)
        },
        "x^y":Operation.BinaryOp{
            op1, op2 in
            return pow(op1, op2)
        },
        "1/x":Operation.UnaryOp{
            op in
            return 1.0/op
        },
        "x^1/2":Operation.UnaryOp{
            op in
            return pow(op, 1.0/2.0)
        },
        "x^1/3":Operation.UnaryOp{
            op in
            return pow(op, 1.0/3.0)
        },
        "x^1/y":Operation.BinaryOp{
            op1, op2 in
            return pow(op1, 1.0/op2)
        },
        "ln":Operation.UnaryOp{
            op in
            return log(op)/log(2.71828)
        },
        "log10":Operation.UnaryOp{
            op in
            return log(op)/log(10)
        },
        "x!":Operation.UnaryOp{
            op in
            func step(iop:Int) -> Int {
                var result=1
                for i in 1...iop{
                    result*=i
                }
                return result
            }
            return Double(step(iop: Int(floor(op))))
        },
        "sin":Operation.UnaryOp{
            op in
            //return sin(op/180.0*Double.pi)
            return  sin(getRadOp(st: mmode, op: op))
            
        },
        "cos":Operation.UnaryOp{
            op in
            return cos(getRadOp(st: mmode, op: op))
        },
        "tan":Operation.UnaryOp{
            op in
            return tan(getRadOp(st: mmode, op: op))
        },
        "e":Operation.Constant(2.71828),
        "EE":Operation.UnaryOp{
            op in
            return op*pow(10,op)
        },
        "sinh":Operation.UnaryOp{
            op in
            return sinh(op)
        },
        "cosh":Operation.UnaryOp{
            op in
            return cosh(op)
        },
        "tanh":Operation.UnaryOp{
            op in
            return tanh(op)
        },
        "π":Operation.Constant(Double.pi),
        "Rand":Operation.Constant(generateRN(t: Int(Date().timeIntervalSince1970))),
        "mr":Operation.UnaryOp{
            op in
            return memoryNum
        },
        "m-":Operation.UnaryOp{
            op in
            memoryNum-=op
            return op
        },
        "m+":Operation.UnaryOp{
            op in
            memoryNum+=op
            return op
        },
        "mc":Operation.UnaryOp{
            op in
            memoryNum = 0
            return op
        },
        "sin^-1":Operation.UnaryOp{
            op in
            return asin(op)
        },
        "cos^-1":Operation.UnaryOp{
            op in
            return acos(op)
        },
        "tan^-1":Operation.UnaryOp{
            op in
            return atan(op)
        },
        "sinh^-1":Operation.UnaryOp{
            op in
            return asinh(op)
        },
        "cosh^-1":Operation.UnaryOp{
            op in
            return acosh(op)
        },
        "tanh^-1":Operation.UnaryOp{
            op in
            return atanh(op)
        },
        "logy":Operation.BinaryOp{
            op1,op2 in
            return log(op1)/log(op2)
        },
        "log2":Operation.UnaryOp{
            op in
            return log2(op)
        },
        "y^x":Operation.BinaryOp{
            op1,op2 in
            return pow(op2, op1)
        },
        "2^x":Operation.UnaryOp{
            op in
            return pow(2, op)
        }
    ]
    
    
    struct Intermediate {
        var firstOp: Double
        var waitingOperation: (Double,Double)->Double
    }
    var pendingOp : Intermediate? = nil
    var pendingOp1 : Intermediate? = nil
    func performOperation(operation: String,operand: Double) -> Double? {
        if let op=operations[operation]{
            switch op {
            case .BinaryOp(let function):
                pendingOp=Intermediate(firstOp: operand,waitingOperation:function)
                return nil
            case .Constant(let value):
                return value
            case .EqualOp:
                return pendingOp!.waitingOperation(pendingOp!.firstOp,operand)
            case .UnaryOp(let function):
                return function(operand)
            }
        }
        return nil
    }
}
