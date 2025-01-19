import SwiftUI

extension View
{
 @available(*, deprecated, renamed: "invisible(_:)")
 public func hidden(_ isHidden: Bool) -> some View
 {
  self.invisible(isHidden)
 }

 @available(*, deprecated, renamed: "invisible(_:allowHitTesting:)")
 public func hidden(_ isHidden: Bool,
                    allowHitTesting: Bool) -> some View
 {
  self.invisible(isHidden, allowHitTesting: allowHitTesting)
 }

 /// Conditionally hides this view.
 @inlinable nonisolated public func invisible(_ isHidden: Bool) -> some View
 {
  self.frame(maxWidth: isHidden ? 0 : nil, maxHeight: isHidden ? 0 : nil)
      .opacity(isHidden ? 0 : 1)
      .disabled(isHidden)
 }

 /// Conditionally hides this view and optionally allows hit testing.
 @inlinable nonisolated public func invisible(_ isHidden: Bool,
                                           allowHitTesting: Bool) -> some View
 {
  self.invisible(isHidden)
      .allowsHitTesting(allowHitTesting)
 }

 /// Conditionally display this view.
 @inlinable nonisolated public func visible(_ isVisible: Bool) -> some View
 {
  self.invisible(!isVisible)
 }
}
