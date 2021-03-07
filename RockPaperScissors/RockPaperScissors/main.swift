//
//  RockPaperScissors - main.swift
//  Created by Coda & Tak
//  Copyright © yagom academy. All rights reserved.
//
import Foundation


enum GameDecision {
    case start
    case restart
    case exit
}

enum GameResult {
    case win
    case draw
    case lose
    case error
}

var aaa: GameResult = GameResult.draw
var bbb: GameDecision = GameDecision.restart

/** ## 가위바위보에 대한 기능(속성)과 메서드(행동)을 'RockPaperScissors 타입'으로 묶었음.
----------
- Computer의 임의의 수와 User에게 입력받은 값을 배열로 묶어 표현함.
- 컴퓨터의 수에서 사용자의 수를 빼서 나올수 있는 경우의 수를 묶어 결과값을 산출하였음
- 승리할 시 (-1,2) / 패배할 시 (-2,1) / 비겼을 시 (0) */
class RockPaperScissorsGame {
    var inputNumber: Int = 0
    var randomNumber: Int = 0
    var bbb: GameDecision = GameDecision.restart
    var gameCommand: GameResult = GameResult.draw
    var decisionNumber: Int = 0
    
    ///컴퓨터에서 가위바위보 중 무엇을 낼지를 결정하는 단계
    func setRandomNumber() {
        randomNumber = Int.random(in: 1...3)
    }

    /// 입력값을 받아 Bool 타입으로 반환.
    /// 입력값은 class 내부의 변수로 저장.
    func isValidInputNumber() -> Bool {
        guard let temporaryValue: String = readLine(),
              let deliveryNumber: Int = Int(temporaryValue)
        else { return false }
        inputNumber = deliveryNumber
        return true
    }
    
    /// checkInputNumber의 Bool값을 통해 예외 사항(nil 혹은 문자열을 입력했을 시)을 처리하고
    /// inputNumber에 저장된 숫자를 바탕으로 게임진행여부 결정
    func isGamePlaying() {
        if isValidInputNumber() == true {
            switch inputNumber {
            case 0:
                bbb = GameDecision.exit
            case 1, 2, 3:
                bbb = GameDecision.start
            default:
                print("잘못된 입력입니다. 다시 시도해주세요.")
                bbb = GameDecision.restart
            }
        } else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            bbb = GameDecision.restart
        }
    }
    

    
    func linkExitAndError() {
        if bbb == GameDecision.exit {
            gameCommand = GameResult.error
        }
    }


    func subtractNumbers(from: Int, by: Int) {
        decisionNumber = from - by
    }
    
    /**
    ### 컴퓨터의 수에서 사용자 입력값을 뺀 값에 따라 각각의 case 분류
    - ex) 컴퓨터의 수: 1(가위) - 사용자입력값: 2(바위) = -1로 사용자승리.
    ------
    - case에 따라 win, lose, draw 값을 gameCommand에 저장.*/
    func sortResult(by: Int) -> GameResult {
            switch (by) {
            case -1, 2:
                return GameResult.win
            case 1, -2:
                return GameResult.lose
            case 0:
                return GameResult.draw
            default:
                return GameResult.error
        }
    }
    

    func checkAndSort() {
        if bbb == GameDecision.start {
            sortResult(by: decisionNumber)
            
        }
    }
        
    ///결과값 출력
    func printResult() {
        switch sortResult(by: decisionNumber) {
        case GameResult.win:
            print("이겼습니다.")
        case GameResult.lose:
            print("졌습니다.")
        case GameResult.draw:
            if bbb == GameDecision.start {
            print("비겼습니다.")
            }
        default:
            return
        }
    }
    
    /// 컴퓨터, 사용자 가위바위보 초기화
    func initializeNumbers() {
        inputNumber = 0
        randomNumber = 0
    }
    
    ///## 게임을 시작하는 메서드
    ///---------
    ///- 컴퓨터와 사용자가 서로 비겼거나, 게임 진행 여부가 restart일때 반복.
    ///- 처음에 while문 내부로 진입하기 위해. gameCommand의 값을 draw로, GameDecision의 값을 restart로 설정해두었음.
    func rockscissorpaperstart() {
        setRandomNumber()
        isGamePlaying()
        linkExitAndError()
        subtractNumbers(from: randomNumber, by: inputNumber)
        checkAndSort()
        initializeNumbers()
        printResult()
        aaa = rockPaperScissors.sortResult(by: decisionNumber)
    }
    
    func start() {
        while sortResult(by: decisionNumber) == GameResult.draw && bbb == GameDecision.restart {
            print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
            rockscissorpaperstart()
            
        }
    }
}


let rockPaperScissors = RockPaperScissorsGame()
rockPaperScissors.start()







enum GameTurn {
    case 컴퓨터
    case 사용자
    case 미정
}

enum MuchkjjippaResult {
    case 결과미정
    case 결과결정
}

class Muckjjippa : RockPaperScissorsGame{
    var turnOfgame: GameTurn = GameTurn.미정
    var resultOfgame: MuchkjjippaResult = MuchkjjippaResult.결과미정
    
    func printTurn(of: GameTurn) {
        print("[\(of)턴] 묵(1), 찌(2), 빠(3)! <종료:0>: ", terminator: "")
    }
    
    func 턴변경구현() {
        switch turnOfgame {
        case GameTurn.컴퓨터:
            turnOfgame = GameTurn.사용자
        case GameTurn.사용자:
            turnOfgame = GameTurn.컴퓨터
        default:
            return
        }
    }
    
    func 턴확인() {
        switch aaa {
        case GameResult.win:
            turnOfgame = GameTurn.사용자
        case GameResult.lose:
            turnOfgame = GameTurn.컴퓨터
        default:
            turnOfgame = GameTurn.컴퓨터
        }
    }
    
    func 결과정리() {
        switch aaa {
        case .win:
            return
        case .draw:
            resultOfgame = MuchkjjippaResult.결과결정
            print("\(turnOfgame)의 승리!")
        case .lose:
            턴변경구현()
        case .error:
            return
        }
    }
    
    func startMuckjjippa() {
        while resultOfgame == MuchkjjippaResult.결과미정 && bbb == GameDecision.restart {
            턴확인()
            printTurn(of: turnOfgame)
                rockscissorpaperstart()
            결과정리()
        }
    }
}

let 묵찌빠 = Muckjjippa()
묵찌빠.startMuckjjippa()

