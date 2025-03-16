import VLstackNamespace
import SwiftUI

extension VLstack
{
 public struct ConditionalView<Content: View>: View
 {
  private let isPresented: Bool
  @ViewBuilder private let content: () -> Content

  public init(isPresented: Bool,
              @ViewBuilder content: @escaping () -> Content)
  {
   self.isPresented = isPresented
   self.content = content
  }

  public var body: some View
  {
   if isPresented
   {
    content()
   }
  }
 }
}
