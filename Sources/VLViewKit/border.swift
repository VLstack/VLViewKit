import SwiftUI

fileprivate struct VLEdgeBorder: Shape
{
 var size: CGFloat
 var edges: [ Edge ]

 func path(in rect: CGRect) -> Path
 {
  edges.map
  {
   edge -> Path in
   switch edge
   {
    case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: size))
    case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - size, width: rect.width, height: size))
    case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: size, height: rect.height))
    case .trailing: return Path(.init(x: rect.maxX - size, y: rect.minY, width: size, height: rect.height))
   }
  }
  .reduce(into: Path()) { $0.addPath($1) }
 }
}

public extension View
{
 @ViewBuilder
 func borders(_ edges: [ Edge ],
              color: Color = .black,
              size: CGFloat = 1) -> some View
 {
  self
  .overlay
  {
   if !edges.isEmpty && size > 0
   {
    VLEdgeBorder(size: size, edges: edges)
    .foregroundStyle(color)
   }
  }
 }

 func border(_ edge: Edge,
             color: Color = .black,
             size: CGFloat = 1) -> some View
 {
  self.borders([ edge ], color: color, size: size)
 }
 
 @available(*, deprecated, message: "use .boder(.bottom, color:size:) instead")
 func borderBottom(color: Color = .black,
                   size: CGFloat = 1) -> some View
 {
  self.border(.bottom, color: color, size: size)
 }

 @available(*, deprecated, message: "use .boder(.leading, color:size:) instead")
 func borderLeading(color: Color = .black,
                    size: CGFloat = 1) -> some View
 {
  self.border(.leading, color: color, size: size)
 }

 @available(*, deprecated, message: "use .boder(.top, color:size:) instead")
 func borderTop(color: Color = .black,
                size: CGFloat = 1) -> some View
 {
  self.border(.top, color: color, size: size)
 }

 @available(*, deprecated, message: "use .boder(.trailing, color:size:) instead")
 func borderTrailing(color: Color = .black,
                     size: CGFloat = 1) -> some View
 {
  self.border(.trailing, color: color, size: size)
 }
}
