//
//  RichTextRowTests.swift
//  RichTextRowTests
//
//  Created by Fabio Felici on 5/4/17.
//  Copyright © 2017 HubSpot. All rights reserved.
//

import XCTest
import Eureka

@testable import RichTextRow

class RichTextRowTests: XCTestCase {

    let formVC = FormViewController()

    override func setUp() {
        super.setUp()
        let form = Form()

        form +++ Section()
        <<< RichTextRow("RichTextRow") {
            $0.title = $0.tag
        }

        formVC.form = form

        // load the view to test the cells
        formVC.view.frame = CGRect(x: 0, y: 0, width: 375, height: 3000)
        formVC.tableView?.frame = formVC.view.frame
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRichTextRow() {
        guard let row = formVC.form.rowBy(tag: "RichTextRow") as? RichTextRow else { XCTFail(); return }
        row.cell.textDidChange(text: "This is a test")
        guard let value = row.value else { XCTFail(); return }
        XCTAssertTrue(value == "This is a test")
    }
    
}
