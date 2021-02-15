import XCTest
@testable import BBLayoutKit

final class BBLayoutKitTests: XCTestCase {

    static var allTests = [
        ("testExample", testExample),
        ("testAddSubview", testAddSubview)
    ]

    func testExample() {
        XCTAssertEqual("BBLayoutKit", "BBLayoutKit")
    }

    #if canImport(UIKit)
    func testAddSubview() {

        let view = UIView()
        let subView = UIView()

        view.addSubview(subView)
        XCTAssertTrue(view.subviews.contains(subView))
        XCTAssertTrue(subView.superview == view)
    }
    #endif
}
