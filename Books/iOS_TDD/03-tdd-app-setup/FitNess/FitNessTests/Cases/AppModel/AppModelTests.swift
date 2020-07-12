//
//  AppModelTests.swift
//  FitNessTests
//
//  Created by Алексей Данилов on 12.07.2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class AppModelTests: XCTestCase {
  
  private var sut: AppModel!
  
  override func setUp() {
    super.setUp()
    sut = AppModel()
  }
  
  func testAppModel_whenInitialized_isInNotStartedState() {
    let initialState = sut.appState
    XCTAssertEqual(initialState, AppState.notStarted)
  }
  
  func testAppModel_whenStarted_isInProgressState() {
    sut.start()
    let observedState = sut.appState
    XCTAssertEqual(observedState, AppState.inProgress)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
}
