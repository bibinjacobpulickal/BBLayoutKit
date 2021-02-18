import XCTest
@testable import BBLayoutKit

final class BBLayoutKitTests: XCTestCase {

    static var allLayoutKitTests = [
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic),
        ("testTopToTopConstraint", testTopToTopConstraint)
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

    func testConstraint(
        _ constraint: NSLayoutConstraint,
        firstAttribute: NSLayoutConstraint.Attribute,
        secondAttribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat                     = 0,
        multiplier: CGFloat                   = 1,
        priority: UILayoutPriority            = .required,
        active: Bool                          = true) {

        XCTAssertTrue(constraint.firstAttribute == firstAttribute)
        XCTAssertTrue(constraint.secondAttribute == secondAttribute)
        XCTAssertTrue(constraint.relation == relation)
        XCTAssertTrue(constraint.constant == constant)
        XCTAssertTrue(constraint.multiplier == multiplier)
        XCTAssertTrue(constraint.priority == priority)
        XCTAssertTrue(constraint.isActive == active)
    }

    func testTopToTopConstraint() {
        testAddSubview()
        let topToTopConstraint = view.top == subView.top
        testConstraint(topToTopConstraint, firstAttribute: .top, secondAttribute: .top)
    }

    func testTopToBottomConstraint() {
        testAddSubview()
        let topToTopConstraint = view.top == subView.bottom
        testConstraint(topToTopConstraint, firstAttribute: .top, secondAttribute: .bottom)
    }
}
