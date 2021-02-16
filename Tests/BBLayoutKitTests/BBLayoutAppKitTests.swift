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

        testView(view, has: subView)
    }

    func testTamic() {

        let view = NSView()
        let subView = NSView()

        view.addSubview(subView) { }

        testView(view, has: subView)
        XCTAssertFalse(subView.tamic)
    }

    func testView(_ view: NSView, has subView: NSView) {

        XCTAssertTrue(view.subviews.contains(subView))
        XCTAssertTrue(subView.superview == view)
    }
}
#endif
