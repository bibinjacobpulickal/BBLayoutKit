import XCTest
@testable import BBLayoutKit

final class BBLayoutKitTests: XCTestCase {

    static var allLayoutKitTests = [
        ("testAddSubview", testAddSubview),
        ("testTamic", testTamic),
        ("testLayoutYAxisAnchors", testLayoutYAxisAnchors),
        ("testLayoutXAxisAnchors1", testLayoutXAxisAnchors1),
        ("testLayoutXAxisAnchors2", testLayoutXAxisAnchors2),
        ("testLayoutDimensionAnchors", testLayoutDimensionAnchors)
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

    func testLayoutXAxisAnchors1() {
        let viewLayoutXAxisAnchorAttributes = getLayoutXAxisAnchorAttributesForView1(view)
        let subviewLayoutXAxisAnchorAttributes = getLayoutXAxisAnchorAttributesForView1(subview)
        testAddSubview()
        viewLayoutXAxisAnchorAttributes.forEach { viewAnchor in
            subviewLayoutXAxisAnchorAttributes.forEach { subviewAnchor in
                let constraint = viewAnchor.anchor == subviewAnchor.anchor
                testConstraint(constraint, firstAttribute: viewAnchor.attribute, secondAttribute: subviewAnchor.attribute)
            }
        }
    }

    func getLayoutXAxisAnchorAttributesForView1(_ view: BBAnchorable) -> [(anchor: NSLayoutXAxisAnchor, attribute: NSLayoutConstraint.Attribute)] {
        [
            (view.leading, .leading),
            (view.trailing, .trailing),
            (view.centerX, .centerX)
        ]
    }

    func testLayoutXAxisAnchors2() {
        let viewLayoutXAxisAnchorAttributes = getLayoutXAxisAnchorAttributesForView2(view)
        let subviewLayoutXAxisAnchorAttributes = getLayoutXAxisAnchorAttributesForView2(subview)
        testAddSubview()
        viewLayoutXAxisAnchorAttributes.forEach { viewAnchor in
            subviewLayoutXAxisAnchorAttributes.forEach { subviewAnchor in
                let constraint = viewAnchor.anchor == subviewAnchor.anchor
                testConstraint(constraint, firstAttribute: viewAnchor.attribute, secondAttribute: subviewAnchor.attribute)
            }
        }
    }

    func getLayoutXAxisAnchorAttributesForView2(_ view: BBAnchorable) -> [(anchor: NSLayoutXAxisAnchor, attribute: NSLayoutConstraint.Attribute)] {
        [
            (view.left, .left),
            (view.right, .right),
            (view.centerX, .centerX)
        ]
    }

    func testLayoutDimensionAnchors() {
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

    func getLayoutDimensionAnchorAttributesForView(_ view: BBAnchorable) -> [(anchor: NSLayoutDimension, attribute: NSLayoutConstraint.Attribute)] {
        [
            (view.width, .width),
            (view.height, .height)
        ]
    }

    func testConstraintRelation(
        viewAnchor: (anchor: NSLayoutYAxisAnchor, attribute: NSLayoutConstraint.Attribute),
        subviewAnchor: (anchor: NSLayoutYAxisAnchor, attribute: NSLayoutConstraint.Attribute)) {
        let relations = [NSLayoutConstraint.Relation.equal, .greaterThanOrEqual, .lessThanOrEqual]
        relations.forEach { relation in
            var constraint: NSLayoutConstraint
            switch relation {
            case .lessThanOrEqual:
                constraint = viewAnchor.anchor <= subviewAnchor.anchor
            case .greaterThanOrEqual:
                constraint = viewAnchor.anchor >= subviewAnchor.anchor
            default:
                constraint = viewAnchor.anchor == subviewAnchor.anchor
            }
            testConstraint(constraint, firstAttribute: viewAnchor.attribute, secondAttribute: subviewAnchor.attribute)
        }
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
}
