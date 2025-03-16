import VLstackNamespace
import SwiftUI

public extension VLstack
{
 struct ConditionalView<Content: View>: View
 {
  public let isPresented: Bool
  @ViewBuilder public let content: () -> Content

  public var body: some View
  {
   if isPresented
   {
    content()
   }
  }
 }
}
