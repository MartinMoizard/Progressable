//
//  ProgressableTests.swift
//  ProgressableTests
//
//  Created by Martin MOIZARD-LANVIN on 21/09/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import XCTest
@testable import Progressable

class ProgressableTests: XCTestCase {
    let portraitFrame = CGRect(x: 0, y: 0, width: 320, height: 480)
    let landscapeFrame = CGRect(x: 0, y: 0, width: 480, height: 320)
    var viewController: UIViewController!
    var progressSearchBar: ProgressSearchBar!
    
    override func setUp() {
        super.setUp()
        self.viewController = UIViewController()
        self.viewController.view.frame = portraitFrame
        self.progressSearchBar = ProgressSearchBar(frame: CGRect(x: 0, y: 0, width: portraitFrame.width, height: 44))
        self.progressSearchBar.translatesAutoresizingMaskIntoConstraints = false
        self.progressSearchBar.autoresizingMask = [UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleWidth]
        self.viewController.view.addSubview(self.progressSearchBar)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertEqual(self.progressSearchBar.bounds.width, portraitFrame.width)
        XCTAssertEqual(self.progressSearchBar.progress, 0)
        XCTAssertEqual(self.progressSearchBar.progressLineWidth, 1)
        XCTAssertEqual(self.progressSearchBar.progressColor, nil)
    }
    
    func testChangeSize() {
        self.progressSearchBar.progress = 50
        self.progressSearchBar.layoutIfNeeded()
        XCTAssertEqual(self.progressSearchBar.progressLayer.bounds.width, portraitFrame.width / 2)
        
        self.viewController.view.frame = landscapeFrame
        self.viewController.view.setNeedsLayout()
        self.viewController.view.layoutIfNeeded()
        
        XCTAssertEqual(self.progressSearchBar.progressLayer.bounds.width, landscapeFrame.width / 2)
    }
    
    func testProgressWithAnimation() {
        self.progressSearchBar.setProgress(progress: 50, withDuration: 0.25)
        XCTAssertEqual(self.progressSearchBar.progress, 50)
    }
    
    func testProgressWithoutAnimation() {
        self.progressSearchBar.progress = 10
        XCTAssertEqual(self.progressSearchBar.progress, 10)
    }
}
