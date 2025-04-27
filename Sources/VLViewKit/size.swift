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

fileprivate struct VLViewOnSizeChangeModifier: ViewModifier
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

extension View
{
 public func onSizeChange(perform: @escaping @Sendable (CGSize) -> Void) -> some View
 {
  self.modifier(VLViewOnSizeChangeModifier(callback: perform))
 }

 public func onSizeChange(maxHeight height: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeChangeModifier(callback: { height.wrappedValue = max(0, $0.height, height.wrappedValue) }))
 }

 public func onSizeChange(height: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeChangeModifier(callback: { height.wrappedValue = $0.height }))
 }

 public func onSizeChange(maxWidth width: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeChangeModifier(callback: { width.wrappedValue = max(0, $0.width, width.wrappedValue) }))
 }

 public func onSizeChange(width: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeChangeModifier(callback: { width.wrappedValue = $0.width }))
 }

 public func onSizeChange(size: Binding<CGSize>) -> some View
 {
  self.modifier(VLViewOnSizeChangeModifier(callback: { size.wrappedValue = $0 }))
 }
}
