import XCTest
@testable import BBLayoutKit

#if canImport(UIKit)
final class BBLayoutUIKitTests: XCTestCase {

    static var allUIKitTests = [
        ("testExample", testExample),
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic)
    ]

    func testExample() {
        XCTAssertEqual("BBLayoutKit", "BBLayoutKit")
    }

    func testAddSubview() {

        let view = UIView()
        let subView = UIView()

        view.addSubview(subView)

        XCTAssertTrue(view.subviews.contains(subView))
        XCTAssertTrue(subView.superview == view)
    }

    func testTamic() {

        let view = UIView()
        let subView = UIView()

        view.addSubview(subView) { }

        XCTAssertFalse(subView.tamic)
    }
}
#endif
