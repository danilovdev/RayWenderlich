

import SwiftUI

struct ChallengeView: View {
    
    let challengeTest: ChallengeTest
    @State var showAnswers = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.showAnswers = !self.showAnswers
            }) {
                QuestionView(question: challengeTest.challenge.question)
                    .frame(height: 300)
            }
            if showAnswers {
                Divider()
                ChoicesView(challengeTest: challengeTest)
                    .frame(height: 300)
                    .padding()
            }
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    
    static let challengeTest = ChallengeTest(
        challenge: Challenge(
            question: "􀍠􀎃􀍢􀍚􀌴􀍭􀎔􀍯",
            pronunciation: "Onegai shimasu",
            answer: "Please"
        ),
        answers: ["Thank you", "Hello", "Goodbye"]
    )
    
    static var previews: some View {
        ChallengeView(challengeTest: challengeTest)
    }
}
