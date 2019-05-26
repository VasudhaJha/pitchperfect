//
//  Constants.swift
//  PitchPerfect
//
//  Created by Jha, Vasudha on 26/05/19.
//  Copyright © 2019 Jha, Vasudha. All rights reserved.
//

import Foundation


// MARK: Alerts

struct Alerts {
    static let DismissAlert = "Dismiss"
    static let RecordingDisabledTitle = "Recording Disabled"
    static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
    static let RecordingFailedTitle = "Recording Failed"
    static let RecordingFailedMessage = "Something went wrong with your recording."
    static let AudioRecorderError = "Audio Recorder Error"
    static let AudioSessionError = "Audio Session Error"
    static let AudioRecordingError = "Audio Recording Error"
    static let AudioFileError = "Audio File Error"
    static let AudioEngineError = "Audio Engine Error"
}

// MARK: Segue identifiers
struct Segue {
    static let stopRecording = "stopRecording"
}

// MARK: Sound Recording names
struct SoundRecording {
    static let name = "recordedVoice.wav"
}

// MARK: PlayingState (raw values correspond to sender tags)

enum PlayingState { case playing, notPlaying }

