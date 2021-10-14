### IOS智能应用开发lab1

202220013徐简

#### 实验结果：

仿照Apple官方iOS中的计算器编写一个自己的计算器App，利用Autolayout技术实现支持竖屏（portrait）和横屏（landscape）两种使用模型，分别如下图所示：

![image-20211014005329439](/Users/kirakiraakira/Library/Application Support/typora-user-images/image-20211014005329439.png)

![image-20211014005347536](/Users/kirakiraakira/Library/Application Support/typora-user-images/image-20211014005347536.png)

#### 代码结构

参考教学视频，实现`Calculator`类作为模型

```swift
enum Operation {
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
// 用一个枚举类型来记录运算符对应的函数，并将具体的实现储存在下面的dictionary中
```

```swift
//运算符实现
var operations=[
        "+": Operation.BinaryOp{
            op1,op2 in
            return op1+op2
        },
        "=": Operation.EqualOp,
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        "AC": Operation.UnaryOp{
            _ in
            return 0
        }
        ]
```

用两个结构体变量`Intermediate`来存储运算的中间结果，下面介绍几个进阶计算器的功能实现。

###### 记忆功能

mc键就是memory clean，记记忆存储清除的意思；

mr键就是memory read，记忆存储读取的意思；

m+键的意思就是在记忆存储里的加法运算，同理m-就是记忆存储里的减法运算。

比如你在计算过程中需要不断调用同一个数，输入起来比较麻烦，像圆周率3.1415926，你就可以事先输入，然后按m+键，再用的时候就按mr键显示出来。如果你按下3，再按m+，记忆存储里在后台已经计算好，你再按mr键，屏幕结果就是6.1415926，所以你想保存一个新的数字时，就要按mc键进行记忆清除。

```swift
var memoryNum:Double = 0
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
        }
//用全局变量memoryNum当作记忆功能的草稿纸，记忆功能运算符均为单变量运算符，因为运算操作始终是对于memoryNum进行的
```

###### 角度与弧度的转换

横屏状态下，左下角的按键用于切换使用角度还是弧度作为单位，区别于标准的实验，本项目点按按键后，按键上的文字发生变化，从而区别是角度还是弧度。

```swift
var mmode:Bool = true
func getRadOp(st:Bool,op:Double) -> Double {
    if st{
        return op/180.0*Double.pi
    }else{
        return op*180.0/Double.pi
    }
}
//用一个Bool形变量指示当前的输入模式，点按按键，该Bool变量取反，并通过getRadOp来得到对应模式下的操作数
```

###### 拓展模式

横屏模式下，点按第一列第二个按钮，得到拓展模式的运算符，该功能实现只需要connect点按按钮与改变按钮labelText即可。

```swift
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
```



#### UI设计

本项目仿照IOS标准布局与配色，使用autolayout，根据横屏与竖屏的不同尺寸（CR, RC)，布置按钮与显示框。



#### 功能展示

见录屏