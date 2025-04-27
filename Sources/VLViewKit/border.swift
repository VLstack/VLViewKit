import SwiftUI

fileprivate struct VLEdgeBorder: Shape
{
 let size: CGFloat
 let edges: [ Edge ]

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

extension View
{
 public func borders(_ edges: [ Edge ],
                     color: Color = .black,
                     size: CGFloat = 1) -> some View
 {
  self
  .overlay
  {
   if size > 0 && !edges.isEmpty
   {
    VLEdgeBorder(size: size, edges: edges)
    .foregroundStyle(color)
   }
  }
 }

 public func border(_ edge: Edge,
                    color: Color = .black,
                    size: CGFloat = 1) -> some View
 {
  self.borders([ edge ], color: color, size: size)
 }
}
