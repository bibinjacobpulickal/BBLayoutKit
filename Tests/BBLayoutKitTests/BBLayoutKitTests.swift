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

        viewLayoutYAxisAnchorAttributes.forEach { viewAnchor in
            subviewLayoutYAxisAnchorAttributes.forEach { subviewAnchor in
                testLayoutYAxisAnchorRelationsPrioritiesAndConstants(viewAnchor: viewAnchor, subviewAnchor: subviewAnchor)
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

    func testLayoutYAxisAnchorRelationsPrioritiesAndConstants(
        viewAnchor: (anchor: NSLayoutYAxisAnchor, attribute: NSLayoutConstraint.Attribute),
        subviewAnchor: (anchor: NSLayoutYAxisAnchor, attribute: NSLayoutConstraint.Attribute)) {

        let relations = [NSLayoutConstraint.Relation.equal,
                         .greaterThanOrEqual,
                         .lessThanOrEqual]
        let priorities = [UILayoutPriority.required,
                          .defaultHigh,
                          .dragThatCanResizeScene,
                          .sceneSizeStayPut,
                          .dragThatCannotResizeScene,
                          .defaultLow,
                          .fittingSizeLevel]
        let isActives = [true, false]

        testAddSubview()

        relations.forEach { relation in
            priorities.forEach { priority in
                isActives.forEach { isActive in

                    var constraint: NSLayoutConstraint
                    let constant = CGFloat.random(in: -1000...1000)

                    switch relation {
                    case .lessThanOrEqual:
                        if isActive {
                            constraint = viewAnchor.anchor <= subviewAnchor.anchor + constant
                        } else {
                            constraint = viewAnchor.anchor !<= subviewAnchor.anchor + constant
                        }
                    case .greaterThanOrEqual:
                        if isActive {
                            constraint = viewAnchor.anchor >= subviewAnchor.anchor + constant
                        } else {
                            constraint = viewAnchor.anchor !>= subviewAnchor.anchor + constant
                        }
                    default:
                        if isActive {
                            constraint = viewAnchor.anchor == subviewAnchor.anchor + constant
                        } else {
                            constraint = viewAnchor.anchor != subviewAnchor.anchor + constant
                        }
                    }
                    constraint.priority = priority
                    testConstraint(
                        constraint,
                        firstAttribute: viewAnchor.attribute,
                        secondAttribute: subviewAnchor.attribute,
                        relation: relation,
                        constant: constant,
                        priority: priority,
                        isActive: isActive)
                }
            }
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
        isActive: Bool                        = true) {

        XCTAssertTrue(constraint.firstAttribute == firstAttribute)
        XCTAssertTrue(constraint.secondAttribute == secondAttribute)
        XCTAssertTrue(constraint.relation == relation)
        XCTAssertTrue(constraint.constant == constant)
        XCTAssertTrue(constraint.multiplier == multiplier)
        XCTAssertTrue(constraint.priority == priority)
        XCTAssertTrue(constraint.isActive == isActive)
    }
}
