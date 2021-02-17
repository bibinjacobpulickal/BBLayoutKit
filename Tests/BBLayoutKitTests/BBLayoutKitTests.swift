import XCTest
@testable import BBLayoutKit

final class BBLayoutKitTests: XCTestCase {

    static var allLayoutKitTests = [
        ("testAddSubview", testAddSubview)
    ]

    #if canImport(UIKit)
    private let view    = UIView()
    private let subView = UIView()
    #elseif canImport(AppKit)
    private let view    = NSView()
    private let subView = NSView()
    #endif

    func testAddSubview() {

        view.addSubview(subView) { }

        XCTAssertTrue(view.subviews.contains(subView))
        XCTAssertTrue(subView.superview == view)
    }

    func testTamic() {
        testAddSubview()
        XCTAssertFalse(subView.tamic)
    }

    func testTopConstraint() {
        testAddSubview()
        let topConstraint = view.top == subView.top
        XCTAssertTrue(topConstraint.isActive)
        XCTAssertTrue(topConstraint.constant == 0)
        XCTAssertTrue(topConstraint.multiplier == 1)
        XCTAssertTrue(topConstraint.firstAttribute == .top)
        XCTAssertTrue(topConstraint.secondAttribute == .top)
    }
}
