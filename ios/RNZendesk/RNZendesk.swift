//
//  RNZendesk.swift
//  RNZendesk
//
//  Created by David Chavez on 24.04.18.
//  Copyright © 2018 David Chavez. All rights reserved.
//

import UIKit
import Foundation
import ZendeskSDK
import ZendeskCoreSDK

@objc(RNZendesk)
class RNZendesk: RCTEventEmitter {

    override public static func requiresMainQueueSetup() -> Bool {
        return false;
    }f

    @objc(constantsToExport)
    override func constantsToExport() -> [AnyHashable: Any] {
        return [:]
    }

    @objc(supportedEvents)
    override func supportedEvents() -> [String] {
        return []
    }


    // MARK: - Public API

    @objc(initialize:)
    func initialize(config: [String: Any]) {
        guard
            let appId = config["appId"] as? String,
            let clientId = config["clientId"] as? String,
            let zendeskUrl = config["zendeskUrl"] as? String else { return }

        Zendesk.initialize(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl)
        Support.initialize(withZendesk: Zendesk.instance)
        let identity = Identity.createAnonymous()
        Zendesk.instance?.setIdentity(identity)
    }

    @objc(identifyJWT:)
    func identifyJWT(token: String?) {
        guard let token = token else { return }
        let identity = Identity.createJwt(token: token)
        Zendesk.instance?.setIdentity(identity)
    }

    @objc(identifyAnonymous)
    func identifyAnonymous() {
        let identity = Identity.createAnonymous()

        Zendesk.instance?.setIdentity(identity)
    }

    @objc(showHelpCenter:)
    func showHelpCenter(with options: [String: Any]) {

        DispatchQueue.main.async {
            let Device_Brand = options["Device_Brand"] as? String;
            let Device_Model = options["Device_Model"] as? String;
            let OS = options["OS"] as? String;
            let OS_Version = options["OS_Version"] as? String;
            let App_Version = options["App_Version"] as? String;
            let Connection = options["Connection"] as? String;
            let Phone_or_Tablet = options["Phone_or_Tablet"] as? String;

            let Device_Brand_dv: Double = 360016501732
            let Device_Brand_value: NSNumber = NSNumber(value: Device_Brand_dv)

            let Device_Model_dv: Double = 360016554711
            let Device_Model_value: NSNumber = NSNumber(value: Device_Model_dv)

            let OS_dv: Double = 360016554731
            let OS_value: NSNumber = NSNumber(value: OS_dv)

            let OS_Version_dv: Double = 360016554911
            let OS_Version_value: NSNumber = NSNumber(value: OS_Version_dv)

            let App_Version_dv: Double = 360016554751
            let App_Version_value: NSNumber = NSNumber(value: App_Version_dv)

            let Connection_dv: Double = 360016502792
            let Connection_value: NSNumber = NSNumber(value: Connection_dv)

            let Phone_or_Tablet_dv: Double = 360016556691
            let Phone_or_Tablet_value: NSNumber = NSNumber(value: Phone_or_Tablet_dv)


            let c2 = ZDKCustomField(fieldId: Device_Brand_value, andValue: Device_Brand!)
            let c3 = ZDKCustomField(fieldId: Device_Model_value, andValue: Device_Model!)
            let c4 = ZDKCustomField(fieldId: OS_value, andValue: OS!)
            let c5 = ZDKCustomField(fieldId: OS_Version_value, andValue: OS_Version!)
            let c6 = ZDKCustomField(fieldId: App_Version_value, andValue: App_Version!)
            let c7 = ZDKCustomField(fieldId: Connection_value, andValue: Connection!)
            let c8 = ZDKCustomField(fieldId: Phone_or_Tablet_value, andValue: Phone_or_Tablet!)

            /*
            config.subject = "iOS Ticket"
            config.tags = ["ios", "mobile"]
            */
            let config = RequestUiConfiguration()
            config.fields = [c2,c3,c4,c5,c6,c7,c8] as! [ZDKCustomField]
            let helpCenter = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [config])


            let nvc = UINavigationController(rootViewController: helpCenter)
            UIApplication.shared.keyWindow?.rootViewController?.present(nvc, animated: true, completion: nil)
        }
    }

    @objc(showNewTicket:)
    func showNewTicket(with options: [String: Any]) {
        DispatchQueue.main.async {
            let config = RequestUiConfiguration()
            if let tags = options["tags"] as? [String] {
                config.tags = tags
            }
            let requestScreen = RequestUi.buildRequestUi(with: [config])

            let nvc = UINavigationController(rootViewController: requestScreen)
            UIApplication.shared.keyWindow?.rootViewController?.present(nvc, animated: true, completion: nil)
        }
    }
}
