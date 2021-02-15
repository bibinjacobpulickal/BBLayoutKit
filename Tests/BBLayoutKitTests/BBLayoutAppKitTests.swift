import XCTest
@testable import BBLayoutKit

#if canImport(AppKit)
final class BBLayoutAppKitTests: XCTestCase {

    static var allAppKitTests = [
        ("testExample", testExample),
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic)
    ]

    func testExample() {
        XCTAssertEqual("BBLayoutKit", "BBLayoutKit")
    }

    func testAddSubview() {

        let view = NSView()
        let subView = NSView()

        view.addSubview(subView)

        XCTAssertTrue(view.subviews.contains(subView))
        XCTAssertTrue(subView.superview == view)
    }

    func testTamic() {

        let view = NSView()
        let subView = NSView()

        view.addSubview(subView) { }

        XCTAssertFalse(subView.tamic)
    }
}
#endif
