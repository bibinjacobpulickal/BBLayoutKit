import XCTest
@testable import BBLayoutKit

final class BBLayoutKitTests: XCTestCase {

    static var allLayoutKitTests = [
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic),
        ("testTopToTopConstraint", testTopToTopConstraint),
        ("testTopToBottomConstraint", testTopToBottomConstraint),
        ("testBottomToBottomConstraint", testBottomToBottomConstraint),
        ("testBottomToTopConstraint", testBottomToTopConstraint)
    ]

    #if canImport(UIKit)
    private let view    = UIView()
    private let subview = UIView()
    #elseif canImport(AppKit)
    private let view    = NSView()
    private let subview = NSView()
    #endif

    func testAddSubview() {

        view.addSubview(subview) { }

        XCTAssertTrue(view.subviews.contains(subview))
        XCTAssertTrue(subview.superview == view)
    }

    func testTamic() {
        testAddSubview()
        XCTAssertFalse(subview.tamic)
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

    func testLayoutYAxisAnchors() {
        let viewLayoutYAxisAnchorAttributes = getLayoutYAxisAnchorAttributesForView(view)
        let subviewLayoutYAxisAnchorAttributes = getLayoutYAxisAnchorAttributesForView(subview)
        testAddSubview()
        viewLayoutYAxisAnchorAttributes.forEach { viewAnchor in
            subviewLayoutYAxisAnchorAttributes.forEach { subviewAnchor in
                let constraint = viewAnchor.anchor == subviewAnchor.anchor
                testConstraint(constraint, firstAttribute: viewAnchor.attribute, secondAttribute: subviewAnchor.attribute)
            }
        }
    }

    func getLayoutYAxisAnchorAttributesForView(_ view: BBAnchorable) -> [(anchor: NSLayoutYAxisAnchor, attribute: NSLayoutConstraint.Attribute)] {
        [
            (view.top, .top),
            (view.bottom, .bottom),
            (view.centerY, .centerY)
        ]
    }
}
