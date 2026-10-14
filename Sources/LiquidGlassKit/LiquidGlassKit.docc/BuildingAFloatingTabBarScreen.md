# Building a Screen with a Floating Tab Bar

Put a title bar, a search field, cards, a floating tab bar and a sheet over scrolling content.

## Overview

Glass looks like glass only when something moves behind it. This guide builds a music library
screen step by step: content scrolls under a floating title bar and a floating tab bar, and a
button opens a glass sheet. The finished screen is listed at the end; the demo app in
`Examples/LiquidGlassDemo` uses the same structure.

### Step 1: Give the glass a background

Start with the content that scrolls. A gradient behind the scroll view makes the translucency
visible while you build; in an app this is usually artwork or photos.

```swift
ScrollView {
    VStack(spacing: 16) {
        ForEach(1...12, id: \.self) { index in
            GlassCard {
                Label("Album \(index)", systemImage: "square.stack")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 100)
}
.background {
    LinearGradient(colors: [.indigo, .purple, .pink], startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
}
```

The bottom padding keeps the last card above the tab bar you add in step 3.

### Step 2: Add a title bar and a search field

`GlassNavigationBar` takes a title, an optional subtitle and leading and trailing items.
Buttons in the items show only their icon, and VoiceOver reads the title as a header.
`GlassSearchBar` shows a clear button while it has text and a Cancel button while it is
focused.

```swift
GlassNavigationBar(title: "Library", subtitle: "128 albums") {
    Button("Back", systemImage: "chevron.left") {}
} trailing: {
    Button("Now Playing", systemImage: "music.note") {
        showsNowPlaying = true
    }
}
GlassSearchBar(text: $query, prompt: "Search the library")
```

Put both at the top of the `VStack` from step 1, so they scroll with the content.

### Step 3: Float a tab bar over the content

`GlassTabBar` works with any `Hashable` selection, so an enum is the natural choice. Place it
in a `ZStack` aligned to the bottom, above the scroll view:

```swift
enum LibrarySection: Hashable {
    case albums, artists, playlists
}
```

```swift
ZStack(alignment: .bottom) {
    // The scroll view from steps 1 and 2.

    GlassTabBar(selection: $section) {
        GlassTab("Albums", systemImage: "square.stack", value: LibrarySection.albums)
        GlassTab("Artists", systemImage: "music.mic", value: LibrarySection.artists)
        GlassTab("Playlists", systemImage: "music.note.list", value: LibrarySection.playlists)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 8)
}
```

The tab builder accepts `if` and `for`, so tabs can depend on state. VoiceOver reports the
selected tab.

### Step 4: Open a sheet

`SwiftUICore/View/glassSheet(isPresented:material:content:)` presents a floating sheet over
the view it modifies. Users close it by dragging it down, tapping the dimmed background, or with
the accessibility escape gesture. Inside the sheet, `GlassGroup` lets nearby glass buttons
blend into each other on OS 26:

```swift
.glassSheet(isPresented: $showsNowPlaying) {
    VStack(spacing: 12) {
        Text("Midnight City").font(.headline)
        GlassGroup(spacing: 12) {
            HStack(spacing: 12) {
                GlassButton("Previous", systemImage: "backward.fill") {}
                GlassButton("Play", systemImage: "play.fill", material: .tinted(.blue)) {}
                GlassButton("Next", systemImage: "forward.fill") {}
            }
        }
    }
    .padding()
}
```

tvOS has no drag gesture, so the sheet is not available there.

### Step 5: Check both rendering paths

On OS 26 the screen uses native glass; on iOS 17 and 18, and on visionOS, it uses the
`Material` fallback. Force the fallback in a preview to see what those users get, without a
second simulator:

```swift
LibraryScreen()
    .glassRenderingMode(.fallback)
```

Also turn on **Settings › Accessibility › Display & Text Size › Reduce Transparency**: the
fallback then draws opaque backgrounds, and the text must still be readable.

## The finished screen

```swift
import LiquidGlassKit
import SwiftUI

enum LibrarySection: Hashable {
    case albums, artists, playlists
}

struct LibraryScreen: View {
    @State private var section = LibrarySection.albums
    @State private var query = ""
    @State private var showsNowPlaying = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 16) {
                    GlassNavigationBar(title: "Library", subtitle: "128 albums") {
                        Button("Back", systemImage: "chevron.left") {}
                    } trailing: {
                        Button("Now Playing", systemImage: "music.note") {
                            showsNowPlaying = true
                        }
                    }
                    GlassSearchBar(text: $query, prompt: "Search the library")
                    ForEach(1...12, id: \.self) { index in
                        GlassCard {
                            Label("Album \(index)", systemImage: "square.stack")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .background {
                LinearGradient(colors: [.indigo, .purple, .pink], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }

            GlassTabBar(selection: $section) {
                GlassTab("Albums", systemImage: "square.stack", value: LibrarySection.albums)
                GlassTab("Artists", systemImage: "music.mic", value: LibrarySection.artists)
                GlassTab("Playlists", systemImage: "music.note.list", value: LibrarySection.playlists)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .glassSheet(isPresented: $showsNowPlaying) {
            VStack(spacing: 12) {
                Text("Midnight City").font(.headline)
                GlassGroup(spacing: 12) {
                    HStack(spacing: 12) {
                        GlassButton("Previous", systemImage: "backward.fill") {}
                        GlassButton("Play", systemImage: "play.fill", material: .tinted(.blue)) {}
                        GlassButton("Next", systemImage: "forward.fill") {}
                    }
                }
            }
            .padding()
        }
    }
}
```

## See Also

- <doc:GettingStarted>
- <doc:RenderingPaths>
- <doc:Theming>
