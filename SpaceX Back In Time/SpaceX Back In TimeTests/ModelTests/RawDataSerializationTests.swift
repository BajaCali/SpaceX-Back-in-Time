import Foundation
import Testing
import License2Chill

@testable import SpaceX_Back_In_Time

@Suite
final class RawDataSerializationTests: BddSuite {
    private var state: State

    init() {
        self.state = .init()
    }


    @Test(arguments: [
        LaunchesRaw.firstPage,
        LaunchesRaw.lastPage
    ])
    func serialise(_ data: Data) async throws {
        given.data(&state, LaunchesRaw.firstPage)
        try when.decode(&state)
    }
}

// MARK: - Stata

private struct State {
    var jsonDecoder = JSONDecoder()
    var dataToParse: Data!
    var decoded: LaunchesRaw!
}


// MARK: - Given

private extension Given {
    func data(_ state: inout State, _ data: Data) {
        state.dataToParse = data
    }
}

// MARK: - When

private extension When {
    func decode(_ state: inout State) throws {
        state.decoded = try state.jsonDecoder.decode(LaunchesRaw.self, from: state.dataToParse)
    }
}

