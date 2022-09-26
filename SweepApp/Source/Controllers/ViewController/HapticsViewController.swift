//
//  HapticsViewController.swift
//  SweepApp
//
//  Created by Ana Raiany Guimarães Gomes on 2022-09-26.
//

import UIKit

final class Haptics {
    
    static let shared = Haptics()
    
    private init() {}
    
    public func selectionVibrate() {
        DispatchQueue.main.async{
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
}
