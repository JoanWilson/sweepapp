//
//  HapticsViewController.swift
//  SweepApp
//
//  Created by Ana Raiany Guimarães Gomes on 2022-09-26.
//

import UIKit
import CoreHaptics

final class Haptics {
    static let shared = Haptics()
    private init() {}
    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let notificarionGenerator = UINotificationFeedbackGenerator()
        notificarionGenerator.prepare()
        notificarionGenerator.notificationOccurred(type)
    }
    public func vibrate2() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        guard hapticCapability.supportsHaptics else {
            print("Device does not support Haptics")
            return
        }
        
        do {
            let engine = try CHHapticEngine()
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try? engine.start()
            try? player.start(atTime: 0)
        } catch let error {
            // Catch error
            print(error)
        }
    }
}
