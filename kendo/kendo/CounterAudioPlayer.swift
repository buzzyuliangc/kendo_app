//
//  CounterAudioPlayer.swift
//  kendo
//
//  Created by Ian Loftis on 4/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation
import AVFoundation

class  CounterAudioPlayer {
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayers = Dictionary<Int, AVAudioPlayer>()
    //audio file setter
    init () {
        for num in 1...10 {
            let fileName = Constants.numberFiles[num]
            if(fileName != nil) {
                let path = Bundle.main.path(forResource: "audio/" + fileName!, ofType: nil)!
                let url = URL(fileURLWithPath: path)
                
                do {
                    audioPlayers[num] = try AVAudioPlayer(contentsOf: url)
                    print("set audio for " + String(num))
                } catch {
                    print("Couldn't load audio file!")
                }
            }
        }
    }
    
    //controller ffor playing mode
    func playCount(num: Int) {
        self.playNum(num: num%10)
        if(num%10 == 0) {
            self.playCompoundCount(firstNum: 10, secondNum: num/10)
        }
    }
    
    //playing compond number
    func playCompoundCount(firstNum: Int, secondNum: Int) {
        if(audioPlayers[firstNum] != nil) {
            let now: TimeInterval = audioPlayers[firstNum]!.deviceCurrentTime
            let duration: TimeInterval = audioPlayers[firstNum]!.duration
            audioPlayers[firstNum]!.play()
            if(audioPlayers[secondNum] != nil) {
                let delay: TimeInterval = 0.10
                audioPlayers[secondNum]!.play(atTime: now + duration + delay)
            }
        }
    }
    
    //vanilla play num
    func playNum(num:Int) {
        if(audioPlayers[num] != nil) {
            audioPlayers[num]!.play()
        }
        
//        let fileName = Constants.numberFiles[num]
//        if(fileName != nil) {
//            let path = Bundle.main.path(forResource: "audio/" + fileName!, ofType: nil)!
//            let url = URL(fileURLWithPath: path)
//
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.play()
//            } catch {
//                print("Couldn't load audio file!")
//            }
//        }
    }
    
    func playRest() {
        
    }
    
    //    func playSound(fileName: String) {
    //        let path = Bundle.main.path(forResource: fileName, ofType: nil)
    //        let url = URL(fileURLWithPath: path)
    //
    //        do {
    //            audioPlayer = try AVAudioPlayer(contentsOf: url)
    //            audioPlayer?.play
    //        }
    //    }
    //
}
