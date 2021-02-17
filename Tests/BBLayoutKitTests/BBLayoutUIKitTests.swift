import XCTest
@testable import BBLayoutKit

#if canImport(UIKit)
final class BBLayoutUIKitTests: XCTestCase {

    static var allUIKitTests = [
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic)
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
}
#endif
