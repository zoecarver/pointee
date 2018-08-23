# Pointee
This is a simple framework containing operators to make it easier to use pointers in swift.

pointee tries to make swift pointers more similar to familiar C style pointers.   It allows you to use the familiar operators such as `&` and `*` (just on the other side) and allows you to cast using `|>` and `|>>`. 

## Basics
the pointee framework turns this:
```swift
let raw = UnsafeMutableRawPointer(&int)
    
let opaquePtr = OpaquePointer(raw)
let ptr = UnsafeMutablePointer<Int>(opaquePtr)

print(ptr.pointee)
```
into this:
```swift
print((int& |> Void.self |> Int.self)*)
```
## Operators
See `main.swift` for docs on all the operators.
The different operators are:

### Assignment
#### `*=`
Assigns a value to an `UnsafeMutablePointer`
Example:
```swift
// ptr: UnsafeMutablePointer<Int>
ptr *= 1
```
### Values and refrences
#### `*`
Create pointer of type. The allocation size of the pointer is determined using `MemoryLayout`.
Example:
```swift
let ptr = Int.self*
// ptr: UnsafeMutablePointer<Int>
```

#### `*`
Get value of an `UnsafeMutablePointer`.
Example:
```swift
// ptr: UnsafeMutablePointer<Int>
ptr *= 1
print(ptr*) // 1
```

#### `&`
Create pointer from value.
Example:
```swift
let int = 1
let ptr = int&
```
### Deallocating
#### `-`
Deallocate pointer.
Example:
```swift
// ptr: UnsafeMutablePointer<Int>
-ptr
```
Note: this should only be used on allocated pointers, for example:
```swift
var int = 1
var ptr = Int.self*
-ptr // Okay
ptr = int&
-ptr // Bad
```
#### `--`
Deinitialize and deallocate pointer.
Example:
```swift
// ptr: UnsafeMutablePointer<Int>
--ptr
```
Obviously the same note as above also applies here.
### Casting
#### `|>` Using `OpaquePointer`s:
```swift
var int = 1
var ptr = int&
ptr |> Double.self
```
#### `|>` to a void (aka raw) pointer:
```swift
var int = 1
var ptr = int&
ptr |> Void.self
```
Whats the difference? Instead of casting to an `UnsafeMutablePointer<Void>` it casts to an `UnsafeMutableRawPointer`.
#### `|>>` Bitcasting
Same syntax as above, just use `|>>`. This will use the `unsafeBitCast` method instead of using an `OpaquePointer`.
## Example
```swift
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
```
## Why
I created this mostly as a fun project but, it might also make it easier to communicate with C code. 
## Install
You can use carthage to install this framework:
```
github "pudility/icons8"
```
