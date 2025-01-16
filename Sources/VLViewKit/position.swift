import SwiftUI

fileprivate struct VLViewPositionKey: PreferenceKey
{
 static let defaultValue: CGRect = .zero

 static func reduce(value: inout CGRect, nextValue: () -> CGRect)
 {
  value = nextValue()
 }
}

fileprivate struct ViewPositionReader: View
{
 var body: some View
 {
  GeometryReader
  {
   geometry in
   Color.clear
    .preference(key: VLViewPositionKey.self, value: geometry.frame(in: .global))
//    .preference(key: VLViewPositionKey.self, value: geometry.frame(in: .local))
  }
 }
}

fileprivate struct OnPositionChangeModifier: ViewModifier
{
 let callback: @Sendable (CGRect) -> Void

 func body(content: Content) -> some View
 {
  content
   .background(ViewPositionReader())
   .onPreferenceChange(VLViewPositionKey.self)
   {
    callback($0)
   }
 }
}

public extension View
{
 func onPositionChange(perform: @escaping @Sendable (CGRect) -> Void) -> some View
 {
  self.modifier(OnPositionChangeModifier(callback: perform))
 }
}
