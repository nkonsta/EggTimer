//
//  Player.swift
//  EggTimer
//
//  Created by Nick Konstantinou on 10/7/22.
//

import AVFoundation


class AudioPlayer {
    var player: AVAudioPlayer?


    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
