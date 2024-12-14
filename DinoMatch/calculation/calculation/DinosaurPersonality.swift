//
//  DinosaurPersonality.swift
//  calculation
//
//  Created by Ari Guzzi on 10/16/24.
//

import SwiftUI

struct DinosaurPersonality: View {
    @State public var dinosaurPersonalities: [DinosaurPersona] = [
        DinosaurPersona(name: "pterodactyl", personality: DinosaurTraits.PterodactylTrait),
        DinosaurPersona(name: "spinosaurus", personality: DinosaurTraits.SpinosaurusTrait),
        DinosaurPersona(name: "stegosaurus", personality: DinosaurTraits.StegosaurusTrait),
        DinosaurPersona(name: "t-rex", personality: DinosaurTraits.TrexTrait),
        DinosaurPersona(name: "triceratops", personality: DinosaurTraits.TriceratopsTrait),
        DinosaurPersona(name: "velociraptor", personality: DinosaurTraits.VelociraptoTrait)
    ]
    let questions: [Question]
    @State public var currentQuestionIndex = 0
    @State public var scores: [String: Int] = [
        "pterodactyl": 0,
        "spinosaurus": 0, "stegosaurus": 0, "t-rex": 0, "triceratops": 0, "velociraptor": 0]
    @State public var result = []

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.green, Color.yellow],
                startPoint: .top, endPoint: .bottom)
            VStack {
                if currentQuestionIndex < questions.count {
                    let currentQuestion = questions[currentQuestionIndex]
                    Text(currentQuestion.text)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    ForEach(currentQuestion.answers.indices, id: \.self) { index in
                        Button(action: {
                                answerSelected(index)},
                            label: {
                                Text(currentQuestion.answers[index].text)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 150)
                                    .background(Color.teal)
                                    .cornerRadius(10)
                            })
                    }
                } else {
                    let result = highestScoringDinosaur()
                    ResultView(result: result, dinosaurPersonalities: dinosaurPersonalities)
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
    public func highestScoringDinosaur() -> DinosaurResult {
        let highestScore = scores.max(by: { $0.value < $1.value }) // get max score
        if let winner = highestScore?.key, let index = dinosaurPersonalities.firstIndex(where: { $0.name == winner }) {
            let personality = dinosaurPersonalities[index].personality
            return DinosaurResult(name: winner, personality: personality, index: index)
        } else {
            return DinosaurResult(name: "No clear answer", personality: "No specific traits.", index: 0)
        }
    }
    public func answerSelected(_ answerIndex: Int) {
            let selectedAnswer = questions[currentQuestionIndex].answers[answerIndex]
            for (dino, score) in selectedAnswer.dinosaurScores {
                scores[dino, default: 0] += score // update scores based on selected answer
            }
            if currentQuestionIndex < questions.count - 1 {
                withAnimation {
                    currentQuestionIndex += 1
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    currentQuestionIndex += 1
                } // added this to force the completion message
            }
        }
}
#Preview {
    DinosaurPersonality( questions: quizQuestions)
}
let quizQuestions = [
    Question(
        text: "What is your preferred climate?",
        answers: [
            Answer(
                text: "Tropical",
                dinosaurScores: [
                    "pterodactyl": 3,
                    "spinosaurus": 10,
                    "stegosaurus": 2,
                    "t-rex": 2,
                    "triceratops": 1,
                    "velociraptor": 4
                ]
            ),
            Answer(
                text: "Temperate",
                dinosaurScores: [
                    "pterodactyl": 2,
                    "spinosaurus": 2,
                    "stegosaurus": 10,
                    "t-rex": 5,
                    "triceratops": 10,
                    "velociraptor": 6
                ]
            ),
            Answer(
                text: "Arid",
                dinosaurScores: [
                    "pterodactyl": 1,
                    "spinosaurus": 5,
                    "stegosaurus": 2,
                    "t-rex": 10,
                    "triceratops": 2,
                    "velociraptor": 10
                ]
            ),
            Answer(
                text: "Cold",
                dinosaurScores: [
                    "pterodactyl": 4,
                    "spinosaurus": 0,
                    "stegosaurus": 6,
                    "t-rex": 3,
                    "triceratops": 5,
                    "velociraptor": 0
                ]
            )
        ]
    ),
    Question(
        text: "How often do you eat meat?",
        answers: [
            Answer(
                text: "Never",
                dinosaurScores: [
                    "pterodactyl": 0,
                    "spinosaurus": 0,
                    "stegosaurus": 10,
                    "t-rex": 0,
                    "triceratops": 10,
                    "velociraptor": 0
                ]
            ),
            Answer(
                text: "Rarely",
                dinosaurScores: [
                    "pterodactyl": 5,
                    "spinosaurus": 5,
                    "stegosaurus": 5,
                    "t-rex": 1,
                    "triceratops": 5,
                    "velociraptor": 2
                ]
            ),
            Answer(
                text: "Sometimes",
                dinosaurScores: [
                    "pterodactyl": 7,
                    "spinosaurus": 7,
                    "stegosaurus": 2,
                    "t-rex": 5,
                    "triceratops": 1,
                    "velociraptor": 7
                ]
            ),
            Answer(
                text: "Often",
                dinosaurScores: [
                    "pterodactyl": 3,
                    "spinosaurus": 3,
                    "stegosaurus": 0,
                    "t-rex": 10,
                    "triceratops": 0,
                    "velociraptor": 10
                ]
            )
        ]
    ),
    Question(
        text: "How do you approach problems?",
        answers: [
            Answer(
                text: "With quick thinking and agility",
                dinosaurScores: [
                    "pterodactyl": 5,
                    "spinosaurus": 3,
                    "stegosaurus": 2,
                    "t-rex": 4,
                    "triceratops": 3,
                    "velociraptor": 10
                ]
            ),
            Answer(
                text: "Through careful thought and planning",
                dinosaurScores: [
                    "pterodactyl": 3,
                    "spinosaurus": 2,
                    "stegosaurus": 10,
                    "t-rex": 5,
                    "triceratops": 8,
                    "velociraptor": 2
                ]
            ),
            Answer(
                text: "By overpowering or intimidating the problem",
                dinosaurScores: [
                    "pterodactyl": 1,
                    "spinosaurus": 5,
                    "stegosaurus": 1,
                    "t-rex": 10,
                    "triceratops": 5,
                    "velociraptor": 3
                ]
            ),
            Answer(
                text: "Avoiding confrontation and finding peaceful solutions",
                dinosaurScores: [
                    "pterodactyl": 6,
                    "spinosaurus": 2,
                    "stegosaurus": 7,
                    "t-rex": 0,
                    "triceratops": 7,
                    "velociraptor": 2
                ]
            )
        ]
    ),
    Question(
        text: "What is your social behavior like?",
        answers: [
            Answer(
                text: "I'm a leader, often taking charge",
                dinosaurScores: [
                    "pterodactyl": 4,
                    "spinosaurus": 3,
                    "stegosaurus": 2,
                    "t-rex": 10,
                    "triceratops": 7,
                    "velociraptor": 8
                ]
            ),
            Answer(
                text: "I prefer to follow and support others",
                dinosaurScores: [
                    "pterodactyl": 3,
                    "spinosaurus": 4,
                    "stegosaurus": 8,
                    "t-rex": 2,
                    "triceratops": 10,
                    "velociraptor": 1
                ]
            ),
            Answer(
                text: "I like working alone",
                dinosaurScores: [
                    "pterodactyl": 7,
                    "spinosaurus": 10,
                    "stegosaurus": 4,
                    "t-rex": 3,
                    "triceratops": 3,
                    "velociraptor": 9
                ]
            ),
            Answer(
                text: "I'm adaptable, fitting into any group",
                dinosaurScores: [
                    "pterodactyl": 6,
                    "spinosaurus": 5,
                    "stegosaurus": 5,
                    "t-rex": 5,
                    "triceratops": 5,
                    "velociraptor": 6
                ]
            )
        ]
    ),
    Question(
        text: "What is your preferred method of resolving conflicts?",
        answers: [
            Answer(
                text: "Negotiation and diplomacy",
                dinosaurScores: [
                    "pterodactyl": 5,
                    "spinosaurus": 2,
                    "stegosaurus": 7,
                    "t-rex": 3,
                    "triceratops": 10,
                    "velociraptor": 4
                ]
            ),
            Answer(
                text: "Standing my ground and fighting if necessary",
                dinosaurScores: [
                    "pterodactyl": 2,
                    "spinosaurus": 8,
                    "stegosaurus": 5,
                    "t-rex": 10,
                    "triceratops": 8,
                    "velociraptor": 5
                ]
            ),
            Answer(
                text: "Avoiding conflict altogether",
                dinosaurScores: [
                    "pterodactyl": 10,
                    "spinosaurus": 3,
                    "stegosaurus": 3,
                    "t-rex": 1,
                    "triceratops": 2,
                    "velociraptor": 3
                ]
            ),
            Answer(
                text: "Using my wits to outsmart the opposition",
                dinosaurScores: [
                    "pterodactyl": 3,
                    "spinosaurus": 4,
                    "stegosaurus": 2,
                    "t-rex": 5,
                    "triceratops": 3,
                    "velociraptor": 10
                ]
            )
        ]
    )
]
public enum DinosaurTraits { // swiftlint:disable line_length
    static let PterodactylTrait = """
    Imaginative and adventurous.
    The Pterodactyl is always eager to explore new heights and ideas, embodying a free-spirited nature that enjoys the thrill of discovery and the freedom of the skies.
    """
    static let SpinosaurusTrait = """
    Independent and unconventional.
    The Spinosaurus stands out due to its unique appearance and habits.
    It is highly adaptable and resourceful, often finding unique solutions to problems.
    """
    static let StegosaurusTrait = """
    Methodical and thoughtful.
    The Stegosaurus is known for its deliberate movements and defensive posture.
    It values stability and security, making careful decisions with a strong emphasis on protection and self-defense.
    """
    static let TrexTrait = """
    Bold, assertive, and a natural leader.
    The T-rex takes charge of situations with confidence and authority, often serving as a central figure in group settings.
    """
    static let TriceratopsTrait = """
    Loyal and protective.
    The Triceratops is known for its sturdy and reliable nature, always ready to stand up for its friends and loved ones.
    It embodies strength and steadfastness.
    """
    static let VelociraptoTrait = """
    Clever and quick-witted.
    The Velociraptor is highly intelligent and cunning, with a knack for solving complex problems quickly.
    It thrives in dynamic environments and enjoys intellectual challenges.
    """
}
