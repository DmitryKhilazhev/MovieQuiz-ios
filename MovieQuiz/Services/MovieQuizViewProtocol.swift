//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Dmitry on 01.02.2023.
//

import Foundation

protocol MovieQuizViewProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}
