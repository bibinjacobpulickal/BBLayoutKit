import XCTest
@testable import BBLayoutKit

#if canImport(UIKit)
final class BBLayoutUIKitTests: XCTestCase {

    static var allUIKitTests = [
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic),
        ("testTopConstraint", testTopConstraint)
    ]

    private let view = UIView()
    private let subview = UIView()

    func testAddSubview() {

        view.addSubview(subview) { }

        XCTAssertTrue(view.subviews.contains(subview))
        XCTAssertTrue(subview.superview == view)
    }

    func testTamic() {
        testAddSubview()
        XCTAssertFalse(subview.tamic)
    }

    func testTopConstraint() {
        testAddSubview()
        let topConstraint = view.top == subview.top
        XCTAssertTrue(topConstraint.isActive)
        XCTAssertTrue(topConstraint.constant == 0)
        XCTAssertTrue(topConstraint.multiplier == 1)
        XCTAssertTrue(topConstraint.firstAttribute == .top)
        XCTAssertTrue(topConstraint.secondAttribute == .top)
    }
}
#endif
