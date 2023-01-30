//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Dmitry on 30.01.2023.
//

import UIKit

final class MovieQuizPresenter {

    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel { //подготавливаю структуру перед выводом
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    
} 
