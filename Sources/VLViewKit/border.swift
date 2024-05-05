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
              color: Color? = nil,
              size: CGFloat? = nil) -> some View
 {
  if edges.isEmpty || ( size ?? 1 ) <= 0
  {
   self
  }
  else
  {
   self.overlay(VLEdgeBorder(size: size ?? 1, edges: edges)
       .foregroundStyle(color ?? .black))
  }
 }

 func border(_ edge: Edge,
             color: Color? = nil,
             size: CGFloat? = nil) -> some View
 {
  self.borders([ edge ], color: color, size: size)
 }
 
 func borderBottom(color: Color? = nil,
                   size: CGFloat? = nil) -> some View
 {
  self.border(.bottom, color: color, size: size)
 }

 func borderLeading(color: Color? = nil,
                    size: CGFloat? = nil) -> some View
 {
  self.border(.leading, color: color, size: size)
 }

 func borderTop(color: Color? = nil,
                size: CGFloat? = nil) -> some View
 {
  self.border(.top, color: color, size: size)
 }

 func borderTrailing(color: Color? = nil,
                     size: CGFloat? = nil) -> some View
 {
  self.border(.trailing, color: color, size: size)
 }
}
