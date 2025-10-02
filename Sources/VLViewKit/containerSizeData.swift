import SwiftUI
import VLstackNamespace

extension VLstack
{
 public struct ContainerSizeData: Identifiable, Equatable, Sendable
 {
  public var id: String { "\(size.width)x\(size.height)" }
  public let size: CGSize
  public let horizontalSizeClass: UserInterfaceSizeClass?
  public let verticalSizeClass: UserInterfaceSizeClass?
  public var isPortrait: Bool { size.width < size.height }
  public var isSized: Bool { size.width > 0 && size.height > 0 }

  public static let zero = VLstack.ContainerSizeData(size: .zero,
                                                     horizontalSizeClass: nil,
                                                     verticalSizeClass: nil)

  public static func == (lhs: VLstack.ContainerSizeData,
                         rhs: VLstack.ContainerSizeData) -> Bool
  {
   lhs.id == rhs.id && lhs.horizontalSizeClass == rhs.horizontalSizeClass && lhs.verticalSizeClass == rhs.verticalSizeClass
  }
 }

 internal struct ContainerSizeDataPreferenceKey: PreferenceKey
 {
  static let defaultValue: VLstack.ContainerSizeData = .zero

  static func reduce(value: inout VLstack.ContainerSizeData,
                     nextValue: () -> VLstack.ContainerSizeData)
  {
   value = nextValue()
  }
 }

 internal struct ContainerSizeDataEnvironmentKey: EnvironmentKey
 {
  static let defaultValue: VLstack.ContainerSizeData = .zero
 }

 internal struct ContainerSizeDataModifier: ViewModifier
 {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  @Environment(\.verticalSizeClass) private var verticalSizeClass

  @Binding var data: VLstack.ContainerSizeData

  internal func body(content: Content) -> some View
  {
   content
   .background
   {
    GeometryReader
    {
     geometry in
     Color.clear.preference(key: VLstack.ContainerSizeDataPreferenceKey.self,
                            value: VLstack.ContainerSizeData(size: geometry.size,
                                                             horizontalSizeClass: horizontalSizeClass,
                                                             verticalSizeClass: verticalSizeClass))
    }
    .onPreferenceChange(VLstack.ContainerSizeDataPreferenceKey.self) { self.data = $0 }
   }
  }
 }
}

extension EnvironmentValues
{
 public var containerSizeData: VLstack.ContainerSizeData
 {
  get { self[VLstack.ContainerSizeDataEnvironmentKey.self] }
  set { self[VLstack.ContainerSizeDataEnvironmentKey.self] = newValue }
 }
}

extension View
{
 public func getContainerSizeData(in data: Binding<VLstack.ContainerSizeData>) -> some View
 {
  self.modifier(VLstack.ContainerSizeDataModifier(data: data))
 }
}
