import RealityKit

// Ensure you register this component in your app’s delegate using:
// NewCakeComponent.registerComponent()
public struct NewCakeComponent: Component, Codable {
    // Name used to uniquely identify the component type. It can differ from the struct name.
    public static var componentName: String { "RealityKitContent.NewCakeComponent" }

    // This is an example of adding a variable to the component.
    var count: Int = 0

    public init() {
    }
}
