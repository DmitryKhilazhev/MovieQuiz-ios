//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Dmitry on 26.01.2023.
//

import XCTest

class MovieQuizUITests: XCTestCase {
    
    /// Примитив приложения. То есть эта переменная символизирует приложение, которое мы тестируем.
    var app: XCUIApplication!
    
    // MARK: - setUpWithError
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        /// Инициализируем переменную арр на момент старта
        app = XCUIApplication()
        /// Чтобы перед каждым тестом приложение открывалось заново и обеспечивало чистоту теста
        app.launch()
        
        // это специальная настройка для тестов: если один тест не прошёл,
        // то следующие тесты запускаться не будут
        continueAfterFailure = false
    }
    
    // MARK: - tearDownWithError
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        /// Чтобы после каждого теста приложение закрывалось и обеспечивало чистоту теста
        app.terminate()
        /// Обнуляем переменную арр по завершению теста
        app = nil
    }
    
    // MARK: - testYesButton
    
    func testYesButton() {
        sleep(3) // ставим дилэй 3 сек на загрузку первого постера
        
        let firstPoster = app.images["Poster"] // находим первоначальный постер
        let firstPosterData = firstPoster.screenshot().pngRepresentation // Делаем скриншот первого постера
        
        app.buttons["Yes"].tap() // находим кнопку `Да` и нажимаем её
        sleep(3) // ставим дилэй 3 сек на загрузку второго постера
        
        let secondPoster = app.images["Poster"] // ещё раз находим постер
        let secondPosterData = secondPoster.screenshot().pngRepresentation // Делаем скриншот второго постера
        
        let indexLabel = app.staticTexts["Index"] // Находим индекс вопроса (после нажатия Да/нет)
        XCTAssertEqual(indexLabel.label, "2/10") // Проверяем, что индес поменялся
        
        XCTAssertNotEqual(firstPosterData, secondPosterData) // проверяем, что постеры разные
    }
    
    // MARK: - testNoButton
    func testNoButton() {
        sleep(3) // ставим дилэй 3 сек на загрузку первого постера
        
        let firstPoster = app.images["Poster"] // находим первоначальный постер
        let firstPosterData = firstPoster.screenshot().pngRepresentation // Делаем скриншот первого постера
        
        app.buttons["No"].tap() // находим кнопку `Нет` и нажимаем её
        sleep(3) // ставим дилэй 3 сек на загрузку второго постера
        
        let secondPoster = app.images["Poster"] // ещё раз находим постер
        let secondPosterData = secondPoster.screenshot().pngRepresentation // Делаем скриншот второго постера
        
        let indexLabel = app.staticTexts["Index"] // Находим индекс вопроса (после нажатия Да/нет)
        XCTAssertEqual(indexLabel.label, "2/10") // Проверяем, что индес поменялся
        
        XCTAssertNotEqual(firstPosterData, secondPosterData) // проверяем, что постеры разные
    }
    // MARK: - testAlert
    
    func testAlert() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }

        let alert = app.alerts["Game results"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть ещё раз")
    }

    // MARK: - testAlertDismiss
    
    func testAlertDismiss() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Game results"]
        alert.buttons.firstMatch.tap()
        
        sleep(2)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(indexLabel.label == "1/10")
    }
}
