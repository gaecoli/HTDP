## hello Racket

> 说明：本章只会去了解一下Racket，以及一些支持的简答的语法，后续会分章节的讲解每一部分的语法。



### 下载DrRacket

 https://download.racket-lang.org/ 

#### 认识DrRacket

![1571046210064](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571046210064.png)

1. DrRacket的上半部分称为定义区域。在这个部分，可以创建程序，即为编辑。在定义区域中添加单词或者内容后，会立刻显示“Save”按钮。在点击Save后，DrRacket会询问你文件名称，以便于保存你编辑的程序。将定义区域与文件关联后，单击“Save”可确保将定义区域的内容保存起来。
2. 像所有编程语言一样，这里的程序也是由表达式组成。表达式可以是普通数字，也可以是以 (...) 这样样式的表达式，DrRacket通过一对括号之间的内容完成工作。
3. 当你写好表达式后，单击“RUN”，DrRacket将定义区域的内容识别然后再下面部分的交互区域显示结果。然后，DrRacket在交互区域会显示提示符(>) 继续等待命令。

### Racket基础语法

在学习一门新的编程语法的时候，经典的语法就是输出"hello world"，那么我们首先来用DrRacket实现以下这个过程。

![1571046314786](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571046314786.png)

因为刚开始使用，所以不会涉及到复杂的语法，我们在选择语言中选择初级就好，然后点击运行按钮。

在交互区出现的(>)中输入

```lisp
"hello world"
```

或者在定义区域也可以输入上面的语法。

![1571046529757](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571046529757.png)

----------------------------------------------------------------------------------------------------------



接下来我们进行简单的数学运算，你可以讲DrRacket看做一个小孩子的成长，然后从简单的数学开始给他命令，让他计算。

![1571050258971](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571050258971.png)

我们发现在DrRacket中使用你的是前缀表达式这样的方法进行数学运算，当然也可以嵌套运算。

![1571050364332](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571050364332.png)

也可以选择这样的方式计算。

-----------------------------------------------------------------------------------------------------------------------

在简单的四则运算会了之后，我们就开始进行一些稍微复杂的数学运算；例如：

![1571050765375](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571050765375.png)

从上面我们看到，我们求平方，次方，以及三角函数，定义宏并使用宏过程中，定义过的变量不可重复定义，而且这些数学问题都是支持的。

> 你的数学老师可能支持额外的括号，但是DrRacket并不支持多余的括号，例如：
>
> (+ (1) (1))

![1571050951212](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571050951212.png)

------------------------------------------------------------------------------------------------

### 简单的字符串操作

如果编程只是支持数字与算术的话，那感觉这和数学一样的枯燥，幸好在Racket中也像其他的语言一样支持文本，图像以及逻辑运算。

在BLS中，文本是用双引号`""`括起来的，也就是字符串。刚才的"hello world"其实我们就看到一次字符串的操作；那么我们继续了解一些字符串的基本操作。

1. **string-append（字符串追加操作）**

![1571051388401](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571051388401.png)

2. **string-length（获取字符串长度）**

![1571051528919](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571051528919.png)

3. **number->string和string->number（数字与字符串之间转换）**

![1571051621599](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571051621599.png)

4. **and or not（逻辑运算）**

![1571051779643](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571051779643.png)



--------

对图像的支持：

在使用图像的时候，我们需要导入一个模块"2htdp/image"

![1571053079370](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571053079370.png)

导入模块之后，就可以使用图像了。

![1571053250321](C:\Users\Lee\AppData\Roaming\Typora\typora-user-images\1571053250321.png)

