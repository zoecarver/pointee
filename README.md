# Pointee
This is a simple framework containing operators to make it easier to use pointers in swift. 

## Basics
the pointee framework turns this:
```swift
let rawA = UnsafeMutableRawPointer(&int)
    
let opaquePtr = OpaquePointer(rawA)
let ptr = UnsafeMutablePointer<Int>(opaquePtr)

print(ptr.pointee)
```
into this:
```swift
print((int& |> Void.self |> Int.self)*)
```
## Operators
See `main.swift` for docs on all the operators.
The difforent oporators are:

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
Obviosly the same note as above also applies here.
### Casting

## Example

## Why


