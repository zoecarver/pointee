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

/// Assigns a value to an `UnsafeMutablePointer`
///
/// - Parameters:
///     - left: pointer
///     - right: pointee
public func *= <T> (left: UnsafeMutablePointer<T>, right: T) {
    left.pointee = right
}

/// Create pointer of type. The allocation size of the pointer is determined using `MemoryLayout`.
///
/// - Parameters:
///     - right: pointee type
public postfix func * <T> (right: T.Type) -> UnsafeMutablePointer<T> {
    let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size * 5)
    return ptr
}

/// Get value of an `UnsafeMutablePointer`.
///
/// - Parameters:
///     - right: pointer
public postfix func * <T> (right: UnsafeMutablePointer<T>) -> T {
    return right.pointee
}

/// Create pointer from value.
///
/// - Parameters:
///     - right: value to create pointer with
public postfix func & <T> (right: inout T) -> UnsafeMutablePointer<T> {
    return UnsafeMutablePointer<T>(&right)
}

/// Deinitialize and deallocate pointer.
///
/// - Parameters:
///     - right: pointer to deinitialize and deallocate
public prefix func -- <T> (right: inout UnsafeMutablePointer<T>) {
    right.deinitialize()
    right.deallocate()
}

/// Deallocate pointer.
///
/// - Parameters:
///     - right: pointer to deallocate
public prefix func - <T> (right: inout UnsafeMutablePointer<T>) {
    right.deallocate()
}

/// Cast pointer using opaque pointer.
///
/// - Parameters:
///     - left: pointer to cast
///     - right: type to cast to
public func |> <T, U> (left: UnsafeMutablePointer<T>, right: U.Type) -> UnsafeMutablePointer<U> {
    let opaquePtr = OpaquePointer(left)
    return UnsafeMutablePointer<U>(opaquePtr)
}

/// Cast raw pointer using opaque pointer.
///
/// - Parameters:
///     - left: raw pointer to cast
///     - right: type to cast to
public func |> <U> (left: UnsafeMutableRawPointer, right: U.Type) -> UnsafeMutablePointer<U> {
    let opaquePtr = OpaquePointer(left)
    return UnsafeMutablePointer<U>(opaquePtr)
}

/// Create raw pointer from pointer.
///
/// - Parameters:
///     - left: pointer to create raw pointer with
///     - right: should be `Void.self`
public func |> <T> (left: UnsafeMutablePointer<T>, right: Void.Type) -> UnsafeMutableRawPointer {
    return UnsafeMutableRawPointer(left)
}

/// Cast raw pointer using unsafe bitcast.
///
/// - Parameters:
///     - left: raw pointer to cast
///     - right: type to cast to
public func |>> <U> (left: UnsafeMutableRawPointer, right: U.Type) -> UnsafeMutablePointer<U> {
    return unsafeBitCast(left, to: UnsafeMutablePointer<U>.self)
}

/// Cast pointer using unsafe bitcast.
///
/// - Parameters:
///     - left: pointer to cast
///     - right: type to cast to
public func |>> <T, U> (left: UnsafeMutablePointer<T>, right: U.Type) -> UnsafeMutablePointer<U> {
    return unsafeBitCast(left, to: UnsafeMutablePointer<U>.self)
}
