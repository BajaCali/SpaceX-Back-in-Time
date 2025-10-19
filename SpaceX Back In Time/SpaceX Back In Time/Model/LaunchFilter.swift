import Foundation

// MARK: - Struct

extension Launch {
    /// Call as function to see if launch matches provided search text.
    final class Filter {
        let launch: Launch
        let searchText: String
        let searchComponents: [String]

        init(launch: Launch, searchText: String) {
            self.launch = launch
            self.searchText = searchText
            self.searchComponents = searchText
                .components(separatedBy: .whitespacesAndNewlines)
        }

        lazy var calendar: Calendar = { .autoupdatingCurrent }()
    }
}

// MARK: - Interface

extension Launch.Filter {
    func callAsFunction() -> Bool {
        match()
    }

    func match() -> Bool {
        searchTitle() ||
        searchDate()
    }
}

// MARK: - Support

extension Launch.Filter {
    /// Gets all years user searches for if any.
    private var searchYears: [Int] {
        searchComponents
            .compactMap(Int.init)
            .filter { $0 > 1900 && $0 < 2100 }
    }

    /// Gets all months user searches for if any.
    private var searchMonths: [Int] {
        let months = calendar.monthSymbols.map(\.localizedLowercase)

        return searchComponents
            .compactMap { component in
                months.firstIndex { $0.localizedStandardContains(component) }
            }
        .map { $0 + 1 }
    }
}

// MARK: - Filters

extension Launch.Filter {
    private func searchTitle() -> Bool {
        launch.title.localizedCaseInsensitiveContains(searchText)
    }

    private func searchDate() -> Bool {
        if searchYears.isNotEmpty && searchMonths.isNotEmpty {
            return searchYear() && searchMonth()
        }
        return searchYear() || searchMonth()
    }

    private func searchYear() -> Bool {
        let launchYear = calendar.component(.year, from: launch.date)

        return searchYears.contains { searchYear in
            searchYear == launchYear
        }
    }

    private func searchMonth() -> Bool {
        searchMonths.contains { searchMonth in
            searchMonth == calendar.component(.month, from: launch.date)
        }
    }
}
