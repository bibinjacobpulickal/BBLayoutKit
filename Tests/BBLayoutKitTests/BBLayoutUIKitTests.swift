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
    private let subView = UIView()

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
#endif
