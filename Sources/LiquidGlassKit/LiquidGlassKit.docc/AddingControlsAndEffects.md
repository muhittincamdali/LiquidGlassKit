# Adding Controls and Effects

Build a settings card with a glass switch and slider, give a surface a gradient tint, and
draw attention to a button with an animated highlight.

## Overview

The controls in this article wrap SwiftUI's own types, so they keep the behavior people
expect: a toggle styled with ``LiquidGlassToggleStyle`` is still a `Toggle`, and
``GlassSlider`` reads as an adjustable element in VoiceOver. All of them take an optional
material and fall back to the ``GlassTheme`` in the environment.

## Add a glass switch

Apply the `.liquidGlass` toggle style to any `Toggle`. The track is glass while the toggle
is off and fills with the view's tint color, or the `tint` you pass, when it is on.

```swift
struct NotificationSettings: View {
    @State private var isEnabled = true
    @State private var showsPreviews = false

    var body: some View {
        GlassCard {
            VStack(spacing: 14) {
                Toggle("Notifications", isOn: $isEnabled)
                    .toggleStyle(.liquidGlass)
                Toggle("Show Previews", isOn: $showsPreviews)
                    .toggleStyle(.liquidGlass(tint: .green))
            }
        }
    }
}
```

Use it inside a `Form` or `List` too; the style changes only how the switch is drawn.

## Add a glass slider

``GlassSlider`` shows its title and current value above a glass track. With a `step`, values
snap to `range.lowerBound + n * step` and never leave the range, so a `1...10` range with a
step of `2` gives 1, 3, 5, 7 and 9.

```swift
struct PlaybackSettings: View {
    @State private var volume = 0.6
    @State private var rate = 1.0

    var body: some View {
        GlassCard {
            VStack(spacing: 14) {
                GlassSlider("Volume", value: $volume, format: .percent)
                GlassSlider("Speed", value: $rate, in: 0.5...2, step: 0.25)
            }
        }
    }
}
```

`format` accepts any `FormatStyle` from `Double` to `String`. VoiceOver users swipe up or
down to move the slider by one step, or by a tenth of the range when there is no step. The
slider is not available on tvOS, which has no drag gesture.

## Tint a surface with a gradient

``SwiftUICore/View/glassGradient(_:direction:intensity:material:in:interactive:)`` draws a
glass surface and lays a gradient over it, inside the same shape, on both rendering paths.
`intensity` is the opacity of the colors and is clamped to `0...1`.

```swift
struct SunsetBadge: View {
    var body: some View {
        Label("Golden hour", systemImage: "sun.horizon")
            .padding()
            .glassGradient([.orange, .pink], direction: .horizontal, in: .capsule)
    }
}
```

## Highlight a call to action

``SwiftUICore/View/glassHighlight(_:color:in:)`` draws a moving light over a view. Choose
``GlassHighlight/shimmer`` for a sweeping band, ``GlassHighlight/pulse`` to brighten and fade
once per cycle, or ``GlassHighlight/breathe`` for a faint idle effect. Pass the same shape as
the glass under it.

```swift
struct UpgradeButton: View {
    var body: some View {
        GlassButton("Upgrade", systemImage: "sparkles", material: .tinted(.purple)) {}
            .glassHighlight(.shimmer, in: .capsule)
    }
}
```

The highlight ignores touches and is hidden from VoiceOver. When _Reduce Motion_ is on, or the
highlight is `nil`, nothing is drawn, so you can bind it to state without extra checks.

## Add a primary action and badges to the tab bar

Pass a ``GlassTabBarAction`` to ``GlassTabBar`` to place a round button after the tabs, for
the screen's main action such as composing a message. The button is as tall as the tab bar
and is tinted with the accent color unless you give it a material.

Call `badge(_:)` on a ``GlassTab`` to show a count or a short label in a red capsule over its
icon. A count of zero shows no badge, as with SwiftUI's `badge(_:)`, and VoiceOver reads the
badge as the tab's value.

```swift
struct InboxTabs: View {
    enum Section: Hashable { case inbox, archive }
    @State private var section = Section.inbox
    @State private var unreadCount = 3

    var body: some View {
        GlassTabBar(
            selection: $section,
            action: GlassTabBarAction("New Message", systemImage: "square.and.pencil") {}
        ) {
            GlassTab("Inbox", systemImage: "tray", value: Section.inbox)
                .badge(unreadCount)
            GlassTab("Archive", systemImage: "archivebox", value: Section.archive)
        }
    }
}
```

## Accessibility

On the fallback path every surface in this article, like every other glass surface in the
package, draws an opaque background when _Reduce Transparency_ is on and a stronger edge when
_Increase Contrast_ is on. See <doc:RenderingPaths> for how the two paths differ.
