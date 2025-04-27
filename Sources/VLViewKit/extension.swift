import SwiftUI

extension View
{
 /// Conditionally hides the view
 @inlinable nonisolated public func invisible(_ isHidden: Bool) -> some View
 {
  self
   .frame(maxWidth: isHidden ? 0 : nil, maxHeight: isHidden ? 0 : nil)
   .opacity(isHidden ? 0 : 1)
   .disabled(isHidden)
 }

 /// Conditionally hides the view and optionally allows hit testing
 @inlinable nonisolated public func invisible(_ isHidden: Bool,
                                              allowHitTesting: Bool) -> some View
 {
  self
   .invisible(isHidden)
   .allowsHitTesting(allowHitTesting)
 }

 /// Conditionally display the view
 @inlinable nonisolated public func visible(_ isVisible: Bool) -> some View
 {
  self
   .frame(maxWidth: isVisible ? nil : 0, maxHeight: isVisible ? nil : 0)
   .opacity(isVisible ? 1 : 0)
   .disabled(!isVisible)
 }

 /// Conditionally display the view and optionally allows hit testing
 @inlinable nonisolated public func visible(_ isVislble: Bool,
                                            allowHitTesting: Bool) -> some View
 {
  self
   .visible(isVislble)
   .allowsHitTesting(allowHitTesting)
 }
}
