import Foundation
import XCTest

class CashRegister {
    var availableFunds: Decimal
    
    var transactionTotal: Decimal = 0
    
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ cost: Decimal) {
        transactionTotal += cost
    }
    
    func acceptCashPayment(_ paymentCost: Decimal) {
        transactionTotal -= paymentCost
        availableFunds += paymentCost
    }
}
 
class CashRegisterTests: XCTestCase {
    var availableFunds: Decimal!
    var sut: CashRegister!
    var itemCost: Decimal!
    var paymentCost: Decimal!
    
    override func setUp() {
        super.setUp()
        availableFunds = 100
        itemCost = 42
        paymentCost = 40
        sut = CashRegister(availableFunds: availableFunds)
    }
    
    func testInitAvailbleFunds_setAvailableFunds() {
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addCostToTransactionTotal() {
        sut.addItem(itemCost)
        
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
    
    func testAddItem_twoItems_addCostsToTransactionTotal() {
        let itemCost2 = Decimal(20)
        let expectedTotal = itemCost + itemCost2
        
        sut.addItem(itemCost)
        sut.addItem(itemCost2)
        
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptCashPayment_subtractPaymentFromTransactionTotal() {
        givenTransactionInProgress()
        
        let expectedTotal = sut.transactionTotal - paymentCost
        sut.acceptCashPayment(paymentCost)
        
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptCashPayment_addPaymentToAvailableFunds() {
        givenTransactionInProgress()
        let expectedAvailableFunds = sut.availableFunds + paymentCost
        sut.acceptCashPayment(paymentCost)
        XCTAssertEqual(sut.availableFunds, expectedAvailableFunds)
    }
    
    override func tearDown() {
        availableFunds = nil
        sut = nil
        itemCost = nil
        super.tearDown()
    }
    
    func givenTransactionInProgress() {
      sut.addItem(50)
      sut.addItem(100)
    }
}

CashRegisterTests.defaultTestSuite.run()
