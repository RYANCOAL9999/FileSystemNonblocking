//
//  MyClass.swift
//  FileSystem-Nonblocking
//
//  Created by Steven Poon on 30/12/2015.
//  Copyright © 2015 Steven Poon. All rights reserved.
//

import Foundation


class MyClass : NSObject
{
    var abc = ViewController()
    var abcappdelegate = AppDelegate()
    var UIabc = UITextField()
    

    
    
    override init()
    {
        super.init()
        print("SwiftClass init")
        //let webview = UIWebView(frame: abc.view.bounds)
        //webview.loadRequest(NSURLRequest(URL: NSURL(string:"http://www.google.com")!))
        //[abc.view .addSubview(webview)]
        UIabc.text = "\\u00a0"
        
        
        
    }
    
}

public class A<T : Any>
{
    public init(n:Int)
    {
        print("A")
    }
}

public class B : A<Int>
{
    public override init(n:Int){
       super.init(n: n)
    }
}

public class C : B
{
    public override init(n:Int) {
        super.init(n: n)
    }
}



@objc class MySwiftClass : NSObject
{
    override init()
    {
        super.init()
        print("SwiftClass init")
        /*let abcdef = B(n:123)
        let x = C(n:123)
        let akkjk = A(n:123) as A<Any>*/
        
    }
    
    func sayHello() -> Void
    {
        print("hello")
    }
    
    func addX(x:Int, andY y:Int) -> Int
    {
        return x+y
    }
    
    func dictionaryWithKeys(keys: [String],andValues values:[String]) -> Dictionary<String,String>
    {
        var dictionary = Dictionary<String,String>()
        
        for var i = 0 ; i < keys.count; i++
        {
            dictionary[keys[i]] = values[i]
        }
        
        return dictionary
    }
 
    
    
}





