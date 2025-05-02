
import SwiftUI

struct ContentView: View {
  @State var zoomed = false
  
  var body: some View {
    VStack(spacing: 0) {
      HeroImage(name: "hero")
      
      ZStack {
        HStack {
          TourTitle(title: "Savanna Trek", caption: "15 mile drive followed by an hour long trek")
            .offset(x: 0, y: -15)
            .padding(.leading, 30)
            .offset(x: zoomed ? 500 : 0, y: -15)
            .animation(.default, value: zoomed)
          
          Spacer()
        }
        
        GeometryReader { geometry in
          Image("thumb")
            .clipShape(RoundedRectangle(cornerRadius: zoomed ? 40 : 500 ))
            .overlay(
              Circle()
                .fill(zoomed ? Color.clear : Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                .scaleEffect(0.8)
            )
            .saturation(zoomed ? 1 : 0)
            .rotationEffect(zoomed ? .degrees(0) : .degrees(90))
            .position(
              x: zoomed ? geometry.frame(in: .local).midX : 600,
              y: 60
            )
            .scaleEffect(zoomed ? 1.33 : 0.33)
            .shadow(radius: 10)
            .animation(.spring(), value: zoomed)
            .onTapGesture {
              zoomed.toggle()
            }
        }
      }
      .background(Color(red: 0.1, green: 0.1, blue: 0.1))
      
      MilestonesList()
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
