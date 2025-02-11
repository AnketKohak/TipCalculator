//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by Mohammad Azam on 10/8/21.
//

import XCTest

class when_content_view_is_shown: XCTestCase{
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override  func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
    }
    func test_should_make_sure_the_total_text_field_contains_default_value(){
        XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
    }
    func test_should_make_sure_the_20_percent_default_tip_option_is_selected(){
        
        
        let segementedControlButton = contentViewPage.tipPercentageSegmentedControl.buttons.element(boundBy: 1)
        XCTAssertEqual(segementedControlButton.label, "20%")
        XCTAssertTrue(segementedControlButton.isSelected)
    }
    override  func tearDown() {
     //clean up
        
    }
    
}
// MARK: - valid

class testing_valid_input: XCTestCase {
    func test_screen(){
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.textFields["totalTextField"]/*[[".textFields[\"Enter total\"]",".textFields[\"totalTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.textFields["totalTextField"]/*[[".textFields[\"Enter total\"]",".textFields[\"totalTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("100")

        app/*@START_MENU_TOKEN@*/.buttons["30%"]/*[[".segmentedControls[\"tipPercentageSegmentControl\"].buttons[\"30%\"]",".buttons[\"30%\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["calculateTipButton"]/*[[".buttons[\"Calculate Tip\"]",".buttons[\"calculateTipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
       let tipText = app/*@START_MENU_TOKEN@*/.staticTexts["tipText"]/*[[".staticTexts[\"₹ 60.00\"]",".staticTexts[\"tipText\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertEqual(tipText.label, "₹ 30.00")
        
        
    }
}




class when_calculate_tip_button_is_pressed_valid_input: XCTestCase{
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        let totalTextField = contentViewPage.totalTextField
        totalTextField.tap()
        totalTextField.typeText("100")
        
        let calculateTipButton = contentViewPage.calculateTipButton
        calculateTipButton.tap()
        
    }
    func test_should_make_sure_that_tip_is_displayed_on_the_screen(){
        
        let tipText = contentViewPage.tipText
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "₹ 20.00")
    }
    
}
class when_calculate_tip_button_is_pressed_invalid_input: XCTestCase{
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        let totalTextField = contentViewPage.totalTextField
        totalTextField.tap()
        totalTextField.typeText("-100")
        let calculateTipButton = contentViewPage.calculateTipButton
        calculateTipButton.tap()
        
    }
    func test_should_clear_tip_label_for_invalid_input(){
        let tipText = contentViewPage.tipText
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "")
    }
    
    func test_should_disaply_error_message_for_invalid_input(){
        let messageText = contentViewPage.messageText
        let _ = messageText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(messageText.label, "Invalid Input")
    }
}
