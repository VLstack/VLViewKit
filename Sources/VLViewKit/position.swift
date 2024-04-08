import SwiftUI

internal struct VLViewPositionKey: PreferenceKey
{
 static var defaultValue: CGRect = .zero

 static func reduce(value: inout CGRect, nextValue: () -> CGRect)
 {
  // TODO: check with new reduce logic
  value = nextValue()
 }
}

internal struct VLViewGeometryPosition: View
{
 var body: some View
 {
  GeometryReader
  {
   geometry in
   Color.clear
    .hidden()
    .preference(key: VLViewPositionKey.self, value: geometry.frame(in: .global))
//    .preference(key: VLViewPositionKey.self, value: geometry.frame(in: .local))
  }
 }
}

internal struct VLViewOnPositionModifier: ViewModifier
{
 let callback: (CGRect) -> Void

 func body(content: Content) -> some View
 {
  content
   .overlay(VLViewGeometryPosition())
   .onPreferenceChange(VLViewPositionKey.self)
   {
    callback($0)
   }
 }
}

public extension View
{
 func onPositionChange(perform: @escaping (CGRect) -> Void) -> some View
 {
  self.modifier(VLViewOnPositionModifier(callback: perform))
 }
}
