import SwiftUI

fileprivate struct VLViewPositionKey: PreferenceKey
{
 static let defaultValue: CGRect = .zero

 static func reduce(value: inout CGRect, nextValue: () -> CGRect)
 {
  value = nextValue()
 }
}

fileprivate struct VLViewPositionReader: View
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

fileprivate struct VLViewOnPositionChangeModifier: ViewModifier
{
 let callback: @Sendable (CGRect) -> Void

 func body(content: Content) -> some View
 {
  content
   .background(VLViewPositionReader())
   .onPreferenceChange(VLViewPositionKey.self)
   {
    callback($0)
   }
 }
}

extension View
{
 public func onPositionChange(perform: @escaping @Sendable (CGRect) -> Void) -> some View
 {
  self.modifier(VLViewOnPositionChangeModifier(callback: perform))
 }
}
