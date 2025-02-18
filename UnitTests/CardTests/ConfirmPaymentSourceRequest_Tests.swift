import Foundation
import XCTest
@testable import PaymentsCore
@testable import Card

class ConfirmPaymentSourceRequest_Tests: XCTestCase {

    func testEncodingPaymentSource_withValidCardDictionary_expectsValidPaymentSourceBody() throws {
        let card = Card(
            number: "4032036247327321",
            expirationMonth: "11",
            expirationYear: "2024",
            securityCode: "222"
        )

        let confirmPaymentSourceRequest = try XCTUnwrap(
            ConfirmPaymentSourceRequest(card: card, orderID: "", clientID: "")
        )

        let paymentSourceBody = try XCTUnwrap(confirmPaymentSourceRequest.body)
        let paymentSourceBodyString = String(data: paymentSourceBody, encoding: .utf8)

        // swiftlint:disable line_length
        let expectedPaymentSourceBodyString = """
        {"payment_source":{"card":{"number":"4032036247327321","security_code":"222","billing_address":null,"name":null,"expiry":"2024-11"}}}
        """
        // swiftlint:enable line_length

        XCTAssertEqual(paymentSourceBodyString, expectedPaymentSourceBodyString)
    }
}
