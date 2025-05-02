
import Foundation

func delay(seconds: TimeInterval, block: @escaping () -> Void) {
	DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: block)
}
