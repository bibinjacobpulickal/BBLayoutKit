import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    #if canImport(UIKit)
    [testCase(BBLayoutUIKitTests.allUIKitTests)]
        .append(contentsOf: BBLayoutKitTests.allLayoutKitTests)
    #elseif canImport(AppKit)
    [testCase(BBLayoutAppKitTests.allAppKitTests)]
        .append(contentsOf: BBLayoutKitTests.allLayoutKitTests)
    #endif
}
#endif
