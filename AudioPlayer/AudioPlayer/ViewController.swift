//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Jingyu Lim on 2021/07/30.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL?
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer?
    
    var playerWrapView = UIStackView()
    var titleLabel = UILabel()
    var progressView = UIProgressView()
    var timeLabelWrapView = UIStackView()
    var currentTimeLabel = UILabel()
    var endTimeLabel = UILabel()
    var buttonWrapView = UIStackView()
    var playButton = UIButton()
    var pauseButton = UIButton()
    var stopButton = UIButton()
    var sliderWrapView = UIStackView()
    var volumeLable = UILabel()
    var slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewInit()
        self.playerInit()
    }
    
    @objc func updatePlayTime(){
        currentTimeLabel.text = convertNSTimerInterval2String(audioPlayer.currentTime)
        progressView.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @objc func play(_ sender: UIButton){
        setPlayButtons(play: false, pause: true, stop: true)
        audioPlayer.play()
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePlayTime), userInfo: nil, repeats: true)
    }
    
    @objc func pause(_ sender: UIButton){
        audioPlayer.pause()
        setPlayButtons(play: true, pause: false, stop: true)
    }
    
    @objc func stop(_ sender: UIButton){
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        currentTimeLabel.text = convertNSTimerInterval2String(0)
        setPlayButtons(play: true, pause: false, stop: false)
        progressTimer?.invalidate()
        progressView.progress = 0
    }
    
    @objc func volumnChange(_ sender: UISlider){
        audioPlayer.volume = sender.value
    }
    
    func setPlayButtons(play: Bool, pause: Bool, stop: Bool){
        playButton.isEnabled = play
        pauseButton.isEnabled = pause
        stopButton.isEnabled = stop
    }
    
    func playerInit() {
        guard let audioFile = Bundle.main.url(forResource: "file_example_MP3_2MG", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch {
            print("player init error: \(error.localizedDescription)")
        }
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slider.value
        endTimeLabel.text = convertNSTimerInterval2String(audioPlayer.duration)
        currentTimeLabel.text = convertNSTimerInterval2String(0)
        
        slider.maximumValue = MAX_VOLUME
        slider.value = 1.0
        progressView.progress = 0
        setPlayButtons(play: true, pause: false, stop: false)
        
    }
    
    
    func viewInit(){
        titleLabel.text = "Audio Player"
        titleLabel.textAlignment = .center
        currentTimeLabel.text = "currentTime"
        endTimeLabel.text = "endTime"
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.systemBlue, for: .normal)
        playButton.setTitleColor(.systemGray, for: .disabled)
        playButton.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(.systemBlue, for: .normal)
        pauseButton.setTitleColor(.systemGray, for: .disabled)
        pauseButton.addTarget(self, action: #selector(pause(_:)), for: .touchUpInside)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.systemBlue, for: .normal)
        stopButton.setTitleColor(.systemGray, for: .disabled)
        stopButton.addTarget(self, action: #selector(stop(_:)), for: .touchUpInside)
        volumeLable.text = "Volumn"
        slider.addTarget(self, action: #selector(volumnChange(_:)), for: .valueChanged)
        
        view.addSubview(playerWrapView)
        playerWrapView.axis = .vertical
        playerWrapView.spacing = 30
        playerWrapView.distribution = .fill
        
        playerWrapView.addArrangedSubview(titleLabel)
        playerWrapView.addArrangedSubview(progressView)
        
        playerWrapView.addArrangedSubview(timeLabelWrapView)
        timeLabelWrapView.addArrangedSubview(currentTimeLabel)
        timeLabelWrapView.addArrangedSubview(endTimeLabel)
        timeLabelWrapView.axis = .horizontal
        timeLabelWrapView.distribution = .equalSpacing
        
        playerWrapView.addArrangedSubview(buttonWrapView)
        buttonWrapView.addArrangedSubview(playButton)
        buttonWrapView.addArrangedSubview(pauseButton)
        buttonWrapView.addArrangedSubview(stopButton)
        buttonWrapView.axis = .horizontal
        buttonWrapView.distribution = .fillEqually
        
        playerWrapView.addArrangedSubview(sliderWrapView)
        sliderWrapView.addArrangedSubview(volumeLable)
        sliderWrapView.addArrangedSubview(slider)
        sliderWrapView.axis = .horizontal
        sliderWrapView.distribution = .fill
        sliderWrapView.spacing = 10
        
        let safeArea = view.safeAreaLayoutGuide
        playerWrapView.translatesAutoresizingMaskIntoConstraints = false
        playerWrapView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        playerWrapView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
        playerWrapView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
            
    }
    
    func convertNSTimerInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }


}

extension ViewController: AVAudioPlayerDelegate{
    
}
