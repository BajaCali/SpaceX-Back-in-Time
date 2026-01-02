import Foundation

@testable import SpaceX_Back_In_Time
import Testing

@Suite("API Body Creation")
struct ApiBodyCreationTests {

    @Test("Encode LaunchesBody to JSON and print it")
    func encodeLaunchesBodyToJSON() throws {

        let launchesBody = LaunchesBody(page: 1, pageLimit: 12, orderedBy: Ordering(field: .byName, direction: .ascending))

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        let data = try encoder.encode(launchesBody)
        let jsonString = String(decoding: data, as: UTF8.self)

        print(jsonString)

        #expect(!jsonString.isEmpty)
    }
}
