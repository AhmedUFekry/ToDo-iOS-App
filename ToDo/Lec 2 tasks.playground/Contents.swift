//factorial
func Factorial (num: Int) -> Int{
    var fact = 1
    for item in 1...num {
       fact = fact * item
    }
    return fact
}
Factorial(num: 5)

//power
func Power(num: Int , power: Int ) -> Int{
    var result = num
    for _ in 1..<power{
        result = result * num
    }
    return result
}
Power(num: 2, power: 2)

//sort

func sortArray(arra : [Int]?) -> [Int]{
    guard let arr = arra else { return [] }
    var sortedArr : [Int] = arr
    for _ in 0..<arr.count {
        for item in 0..<arr.count {
            if item != (arr.count - 1){
                if sortedArr[item] > sortedArr[item + 1] {
                    var firstElement = sortedArr[item]
                    var secondElement = sortedArr[item + 1]
                    sortedArr[item] = secondElement
                    sortedArr[item + 1] = firstElement
                }
            }else if item == (arr.count - 2){
                var lastElement = sortedArr[item]
                var preLastElement = sortedArr[item - 1]
                sortedArr[item - 1] = lastElement
                sortedArr[item] = preLastElement
            }
            
        }
    }

    return sortedArr
}

var arrayy = [4,5,38,7,1,0,5,77,12]
var emptyArr : [Int] = []
 sortArray(arra:emptyArr)

//min & max using inout
func minMax( num1: inout Int , num2: inout Int) -> ( Int , Int) {
    var min : Int = 0
    var max : Int = 0
    if num1 > num2 {
        min = num2
        max = num1
        print("min = " , min)
        print("max = " , max)
    }else if num1 < num2 {
        min = num1
        max = num2
        print("min = " , min)
        print("max = " , max)
    }else{
        print("two numbers are equal")
    }
    return (min , max)
}
var x = 5
var y = 6
minMax(num1: &x, num2: &y)

func swap (num1: inout Int , num2: inout Int){
    
    var temp : Int
    temp = num1
    num1 = num2
    num2 = temp
    
    
}

var t = 5
var f = 8

swap(num1: &t, num2: &f)

t
f

