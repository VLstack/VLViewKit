import SwiftUI

struct VLViewSizeKey: PreferenceKey
{
 static var defaultValue: CGSize = .zero

 static func reduce(value: inout CGSize, nextValue: () -> CGSize)
 {
  // TODO: check with new reduce logic
  value = nextValue()
 }
}

fileprivate struct VLViewGeometrySize: View
{
 var body: some View
 {
  GeometryReader
  {
   geometry in
   Color.clear
    .hidden()
    .preference(key: VLViewSizeKey.self, value: geometry.size)
//    .preference(key: VLViewSizeKey.self, value: geometry.frame(in: .global).size)
  }
 }
}

fileprivate struct VLViewOnSizeModifier: ViewModifier
{
 let callback: (CGSize) -> Void

 func body(content: Content) -> some View
 {
  content
   .overlay(VLViewGeometrySize())
   .onPreferenceChange(VLViewSizeKey.self)
   {
    callback($0)
   }
 }
}

extension View
{
 func onSizeChange(perform: @escaping (CGSize) -> Void) -> some View
 {
  self.modifier(VLViewOnSizeModifier(callback: perform))
 }

 func onSizeChange(maxHeight height: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeModifier(callback: { height.wrappedValue = max(0, $0.height, height.wrappedValue) }))
 }

 func onSizeChange(height: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeModifier(callback: { height.wrappedValue = $0.height }))
 }

 func onSizeChange(maxWidth width: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeModifier(callback: { width.wrappedValue = max(0, $0.width, width.wrappedValue) }))
 }

 func onSizeChange(width: Binding<CGFloat>) -> some View
 {
  self.modifier(VLViewOnSizeModifier(callback: { width.wrappedValue = $0.width }))
 }

 func onSizeChange(size: Binding<CGSize>) -> some View
 {
  self.modifier(VLViewOnSizeModifier(callback: { size.wrappedValue = $0 }))
 }
}
