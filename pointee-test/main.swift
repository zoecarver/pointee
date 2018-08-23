//
//  main.swift
//  pointee-test
//
//  Created by Zoe IAMZOE.io on 8/21/18.
//  Copyright © 2018 Zoe IAMZOE.io. All rights reserved.
//

import Foundation
import pointee

struct Foo {
    var bar = 1
}

func example () {
    var foo = Foo() // Create instance of `Foo`
    
    foo.bar += 2
    
    let rawPtr = foo& |> Void.self // Cast to Void poiner (aka raw pointer)
    var fooClassPtr = rawPtr |> Foo.self // Cast back to `Foo` pointer
    
    // Chain casting
    let bar = fooClassPtr
        |> Foo.self
        |>> Void.self
        |> Int.self
        |>> Void.self
        |> String.self
        |>> Int8.self
    
    print(bar*) // 3 - gets the value of `bar`
    bar *= 4 // which we can then set
    
    print(fooClassPtr*) // Foo(bar: 4)
    
    fooClassPtr = rawPtr |>> Foo.self // BitCast `rawPtr` back to `Foo` pointer
    
    foo.bar += 3
    
    print(fooClassPtr*) // Foo(bar: 7)
}

example()

