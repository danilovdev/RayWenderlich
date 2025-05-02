
import SwiftUI

struct SpinnerView: View {
  @State var currentIndex: Int?
  @State var completed = false

  struct Leaf: View {
    let rotation: Angle
    let isCurrent: Bool
    let isCompleting: Bool
    
    var body: some View {
      Capsule()
        .stroke(isCurrent ? Color.white : Color.gray, lineWidth: 8)
        .frame(width: 20, height: isCompleting ? 20 : 50)
        .offset(x: isCurrent ? 10 : 0, y: isCurrent ? 40 : 70)
        .scaleEffect(isCurrent ? 0.5 : 1.0)
        .rotationEffect(isCompleting ? .zero : rotation)
        .animation(.easeInOut(duration: 1.5), value: isCurrent)
        .animation(.easeInOut(duration: 1.5), value: isCompleting)
    }
  }

  let leavesCount = 12

  var body: some View {
    VStack {
      ZStack {
        ForEach(0..<leavesCount) { index in
          Leaf(
            rotation: Angle(
              degrees: (Double(index) / Double(leavesCount)) * 360.0),
            isCurrent: index == self.currentIndex,
            isCompleting: self.completed
          )
        }
      }
      .onAppear(perform: animate)
    }
  }

  func animate() {
    var iteration = 0
    Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
      if let current = self.currentIndex {
        self.currentIndex = (current + 1) % self.leavesCount
      } else {
        self.currentIndex = 0
      }
      
      iteration += 1
      if iteration == 60 {
        timer.invalidate()
        self.completed = true
        self.currentIndex = nil
      }
    }
  }
}

#if DEBUG
struct SpinnerView_Previews: PreviewProvider {
  static var previews: some View {
    SpinnerView()
  }
}
#endif
