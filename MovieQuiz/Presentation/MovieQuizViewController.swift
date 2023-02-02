import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate, AlertPresenterDelegate, MovieQuizViewControllerProtocol {
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        presenter.didReceiveNextQuestion(question: question)
    }
    
    func didLoadDataFromServer() {
        presenter.didLoadDataFromServer()
    }
    
    func didFailToLoadData(with error: Error) {
        presenter.didFailToLoadData(with: error)
    }

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
    }
    @IBOutlet private weak var textLabel: UILabel!
    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked()
    }
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    private var presenter: MovieQuizPresenter!

     // MARK: - Lifecycle

     override func viewDidLoad() { //Показал стартовый вопрос
         super.viewDidLoad()

         presenter = MovieQuizPresenter(viewController: self)

         imageView.layer.cornerRadius = 20 // радиус скругления углов рамки
     }


     // MARK: - show functions

     func show(quiz step: QuizStepViewModel) {
         imageView.layer.borderColor = UIColor.clear.cgColor
         imageView.image = step.image
         textLabel.text = step.question
         counterLabel.text = step.questionNumber
     }

     func show(quiz result: QuizResultsViewModel) {
         let message = presenter.makeResultsMessage()

         let alert = UIAlertController(
             title: result.title,
             message: message,
             preferredStyle: .alert)
            alert.view.accessibilityIdentifier = "Game results"
             let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
                 guard let self = self else { return }

                 self.presenter.restartGame()
             }

         alert.addAction(action)

         self.present(alert, animated: true, completion: nil)
     }

     func highlightImageBorder(isCorrectAnswer: Bool) {
         imageView.layer.masksToBounds = true
         imageView.layer.borderWidth = 8
         imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
     }

     func showLoadingIndicator() {
         activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
         activityIndicator.startAnimating() // включаем анимацию
     }

     func hideLoadingIndicator() {
         activityIndicator.isHidden = true
     }

     func showNetworkError(message: String) {
         hideLoadingIndicator()

         let alert = UIAlertController(
             title: "Ошибка",
             message: message,
             preferredStyle: .alert)

             let action = UIAlertAction(title: "Попробовать ещё раз",
             style: .default) { [weak self] _ in
                 guard let self = self else { return }

                 self.presenter.restartGame()
             }

         alert.addAction(action)
     }
 }

