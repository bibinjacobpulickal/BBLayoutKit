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

        testView(view, has: subView)
    }

    func testTamic() {

        let view = UIView()
        let subView = UIView()

        view.addSubview(subView) { }

        testView(view, has: subView)
        XCTAssertFalse(subView.tamic)
    }

    func testView(_ view: UIView, has subView: UIView) {

        XCTAssertTrue(view.subviews.contains(subView))
        XCTAssertTrue(subView.superview == view)
    }
}
#endif
