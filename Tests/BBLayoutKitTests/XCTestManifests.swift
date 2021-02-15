import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    #if canImport(UIKit)
    [testCase(BBLayoutUIKitTests.allUIKitTests)]
    #elseif canImport(AppKit)
    [testCase(BBLayoutAppKitTests.allAppKitTests)]
    #endif
}
#endif
