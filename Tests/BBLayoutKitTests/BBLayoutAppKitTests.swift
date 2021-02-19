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
        let subview = NSView()

        view.addSubview(subview)

        testView(view, has: subview)
    }

    func testTamic() {

        let view = NSView()
        let subview = NSView()

        view.addSubview(subview) { }

        testView(view, has: subview)
        XCTAssertFalse(subview.tamic)
    }

    func testView(_ view: NSView, has subview: NSView) {

        XCTAssertTrue(view.subviews.contains(subview))
        XCTAssertTrue(subview.superview == view)
    }
}
#endif
