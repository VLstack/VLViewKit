import SwiftUI

fileprivate struct VLViewSizeKey: PreferenceKey
{
 static let defaultValue: CGSize = .zero

 static func reduce(value: inout CGSize, nextValue: () -> CGSize)
 {
  value = nextValue()
 }
}

fileprivate struct VLViewSizeReader: View
{
 var body: some View
 {
  GeometryReader
  {
   geometry in
   Color.clear
    .preference(key: VLViewSizeKey.self, value: geometry.size)
//    .preference(key: VLViewSizeKey.self, value: geometry.frame(in: .global).size)
  }
 }
}

fileprivate struct OnSizeChangeModifier: ViewModifier
{
 let callback: @Sendable (CGSize) -> Void

 func body(content: Content) -> some View
 {
  content
   .background(VLViewSizeReader())
   .onPreferenceChange(VLViewSizeKey.self)
   {
    callback($0)
   }
 }
}

public extension View
{
 func onSizeChange(perform: @escaping @Sendable (CGSize) -> Void) -> some View
 {
  self.modifier(OnSizeChangeModifier(callback: perform))
 }

 func onSizeChange(maxHeight height: Binding<CGFloat>) -> some View
 {
  self.modifier(OnSizeChangeModifier(callback: { height.wrappedValue = max(0, $0.height, height.wrappedValue) }))
 }

 func onSizeChange(height: Binding<CGFloat>) -> some View
 {
  self.modifier(OnSizeChangeModifier(callback: { height.wrappedValue = $0.height }))
 }

 func onSizeChange(maxWidth width: Binding<CGFloat>) -> some View
 {
  self.modifier(OnSizeChangeModifier(callback: { width.wrappedValue = max(0, $0.width, width.wrappedValue) }))
 }

 func onSizeChange(width: Binding<CGFloat>) -> some View
 {
  self.modifier(OnSizeChangeModifier(callback: { width.wrappedValue = $0.width }))
 }

 func onSizeChange(size: Binding<CGSize>) -> some View
 {
  self.modifier(OnSizeChangeModifier(callback: { size.wrappedValue = $0 }))
 }
}
