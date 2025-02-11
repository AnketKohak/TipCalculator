//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by Mohammad Azam on 10/8/21.
//

import XCTest

class when_content_view_is_shown: XCTestCase{
    
    private var app: XCUIApplication!
    
    override  func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    func test_should_make_sure_the_total_text_field_contains_default_value(){
        let totalTextField = app.textFields["totalTextField"]
        XCTAssertEqual(totalTextField.value as! String, "Enter total")
    }
    func test_should_make_sure_the_20_percent_default_tip_option_is_selected(){
        
        let tipPercentafgeSeggmentControl = app.segmentedControls["tipPercentageSegmentControl"]
        let segementedControlButton = tipPercentafgeSeggmentControl.buttons.element(boundBy: 1)
        XCTAssertEqual(segementedControlButton.label, "20%")
        XCTAssertTrue(segementedControlButton.isSelected  )
    }
    override  func tearDown() {
     //clean up
        
    }
    
}

class when_calculate_tip_button_is_pressed: XCTestCase{
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        let totalTextField = app.textFields["totalTextField"]
        totalTextField.tap()
        totalTextField.typeText("100")
        
        let calculateTipButton = app.buttons["calculateTipButton"]
        calculateTipButton.tap()
        
    }
    func test_should_make_sure_that_tip_is_displayed_on_the_screen(){
        let tipText = app.staticTexts["tipText"]
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "₹ 20.00")
    }
}

