//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jha, Vasudha on 25/05/19.
//  Copyright © 2019 Jha, Vasudha. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    //MARK: PROPERTIES
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        self.recordingLabel.text = "Recording in progress..."
        self.stopRecordingButton.isEnabled = true
        self.recordButton.isEnabled = false
        
        let _ = setupAudioSession()
        setupAudioRecorder()
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        
        self.recordButton.isEnabled = true
        self.stopRecordingButton.isEnabled = false
        self.recordingLabel.text = "Tap to record"
        
        audioRecorder.stop()
        guard let session = setupAudioSession() else {
            return
        }
        
        do {
            try session.setActive(false, options: .notifyOthersOnDeactivation)
        }
        catch {
            
        }
    }
}

//MARK: HELPER METHODS FOR SETTING UP RECORDER AND SESSION
extension RecordSoundsViewController {
    
    func createFilePath(for recording: String) -> URL? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let pathArray = [dirPath, recording]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        return filePath
    }
    
    func setupAudioSession() -> AVAudioSession? {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            return session
        }
        catch {
            
        }
        return nil
    }
    
    func setupAudioRecorder() {
        guard let filePath = createFilePath(for: SoundRecording.name) else { return }
        
        do {
            audioRecorder = try AVAudioRecorder(url: filePath, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
        catch {
            showAlert(Alerts.AudioRecorderError, message: String(describing: error))
        }
    }
    
}

//MARK: AVAudioRecorderDelegate
extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: Segue.stopRecording, sender: audioRecorder.url)
        }
        else {
            showAlert(Alerts.AudioRecordingError, message: "Error while recording audio")
        }
    }
}

//MARK: PERFORM SEGUE TO PlaySoundsViewController
extension RecordSoundsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.stopRecording {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            if let url = sender as? URL {
                playSoundsVC.recorderFilePath = url
            }
        }
    }
}
