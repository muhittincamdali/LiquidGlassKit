import Testing
@testable import LiquidGlassKit

@Suite("GlassTabBuilder")
struct GlassTabBuilderTests {
    enum Screen: Hashable, CaseIterable { case home, search, inbox, profile }

    private func build(@GlassTabBuilder<Screen> _ tabs: () -> [GlassTab<Screen>]) -> [GlassTab<Screen>] {
        tabs()
    }

    @Test func collectsTabsInOrder() {
        let tabs = build {
            GlassTab("Home", systemImage: "house", value: Screen.home)
            GlassTab("Search", systemImage: "magnifyingglass", value: Screen.search)
        }
        #expect(tabs.map(\.value) == [.home, .search])
        #expect(tabs.map(\.title) == ["Home", "Search"])
    }

    @Test(arguments: [true, false])
    func supportsOptionalTabs(showInbox: Bool) {
        let tabs = build {
            GlassTab("Home", systemImage: "house", value: Screen.home)
            if showInbox {
                GlassTab("Inbox", systemImage: "tray", value: Screen.inbox)
            }
        }
        #expect(tabs.map(\.value) == (showInbox ? [.home, .inbox] : [.home]))
    }

    @Test(arguments: [true, false])
    func supportsEitherBranch(signedIn: Bool) {
        let tabs = build {
            if signedIn {
                GlassTab("Profile", systemImage: "person", value: Screen.profile)
            } else {
                GlassTab("Search", systemImage: "magnifyingglass", value: Screen.search)
            }
        }
        #expect(tabs.map(\.value) == [signedIn ? .profile : .search])
    }

    @Test func supportsLoops() {
        let tabs = build {
            for screen in Screen.allCases {
                GlassTab("\(screen)", systemImage: "circle", value: screen)
            }
        }
        #expect(tabs.map(\.value) == Screen.allCases)
    }

    @Test func emptyBuilderProducesNoTabs() {
        #expect(build {}.isEmpty)
    }

    @Test func duplicateValuesKeepTheFirstTab() {
        let tabs = build {
            GlassTab("Home", systemImage: "house", value: Screen.home)
            GlassTab("Search", systemImage: "magnifyingglass", value: Screen.search)
            GlassTab("Home again", systemImage: "house.fill", value: Screen.home)
        }
        let unique = GlassTabBar<Screen>.uniqued(tabs)
        #expect(unique.map(\.title) == ["Home", "Search"])
    }
}
