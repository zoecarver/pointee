//
//  Main.swift
//  pointee
//
//  Created by Zoe IAMZOE.io on 8/21/18.
//  Copyright © 2018 Zoe IAMZOE.io. All rights reserved.
//

import Foundation
import Darwin

precedencegroup Cast {
    associativity: left
    higherThan: AssignmentPrecedence
}

postfix operator *
postfix operator &

prefix operator -
prefix operator --

infix operator |> : Cast
infix operator |>> : Cast

public func *= <T> (left: UnsafeMutablePointer<T>, right: T) {
    left.pointee = right
}

public postfix func * <T> (left: T.Type) -> UnsafeMutablePointer<T> {
    let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size * 5)
    return ptr
}

public postfix func * <T> (left: UnsafeMutablePointer<T>) -> T {
    return left.pointee
}

public postfix func & <T> (right: inout T) -> UnsafeMutablePointer<T> {
    return UnsafeMutablePointer<T>(&right)
}

public prefix func -- <T> (right: inout UnsafeMutablePointer<T>) {
    right.deinitialize()
    right.deallocate()
}

public prefix func - <T> (right: inout UnsafeMutablePointer<T>) {
    right.deallocate()
}

public func |> <T, U> (left: UnsafeMutablePointer<T>, right: U.Type) -> UnsafeMutablePointer<U> {
    let opaquePtr = OpaquePointer(left)
    return UnsafeMutablePointer<U>(opaquePtr)
}

public func |> <U> (left: UnsafeMutableRawPointer, right: U.Type) -> UnsafeMutablePointer<U> {
    let opaquePtr = OpaquePointer(left)
    return UnsafeMutablePointer<U>(opaquePtr)
}

public func |> <T> (left: UnsafeMutablePointer<T>, right: Void.Type) -> UnsafeMutableRawPointer {
    return UnsafeMutableRawPointer(left)
}

public func |>> <U> (left: UnsafeMutableRawPointer, right: U.Type) -> UnsafeMutablePointer<U> {
    return unsafeBitCast(left, to: UnsafeMutablePointer<U>.self)
}

public func |>> <T, U> (left: UnsafeMutablePointer<T>, right: U.Type) -> UnsafeMutablePointer<U> {
    return unsafeBitCast(left, to: UnsafeMutablePointer<U>.self)
}
