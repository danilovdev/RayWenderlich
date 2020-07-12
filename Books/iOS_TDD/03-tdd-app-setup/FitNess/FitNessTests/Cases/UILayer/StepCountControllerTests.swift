//
//  StepCountControllerTests.swift
//  FitNessTests
//
//  Created by Алексей Данилов on 12.07.2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {
  
  var sut: StepCountController!
  
  override func setUp() {
    super.setUp()
    sut = StepCountController()
  }
  
  func testController_whenStartTapped_appIsInProgress() {
    whenStartStopPauseCalled()
    
    let state = AppModel.instance.appState
    XCTAssertEqual(state, AppState.inProgress)
  }
  
  func testController_whenStartTapped_buttonLabelIsPause() {
    whenStartStopPauseCalled()
    
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
  }
  
  func testController_whenCreated_buttonLabelIsStart() {
    sut.viewDidLoad()
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - When
  private func whenStartStopPauseCalled() {
    sut.startStopPause(nil)
  }
}
