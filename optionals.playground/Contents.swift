import UIKit


var optionalInt: Int?
optionalInt = 23

//  IF LET
if let unwrappedInt = optionalInt {
   print("value found \(unwrappedInt)")
} else {
   print("value not found")
}




/*
 GUARD STATEMENT
    if optional is nil then exit the function
*/
func myFunc(number: Int?) {
    guard let number = number else {
        print("Exiting Function")
        return
    }
    print("num is \(number)")
}


/*
     FORCE UNWRAPPING
        use as a last resort
        crashes if nil
*/
let forcedNumber = optionalInt!


/*
    Optional Chaining
        var val = s?.prop // val is an optional
*/

struct MyStruct {
    var prop: String
}

var s: MyStruct? = MyStruct(prop: "hello")
var val = s?.prop
print(val ?? "no value")
