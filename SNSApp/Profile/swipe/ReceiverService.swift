//
//  SwipeService.swift
//  SNSApp
//
//  Created by Kang Ning on 17/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class ReceiverService: NSObject{
    private let serviceType = "imageSwipe"
    private let myPeerId = MCPeerID(displayName: WebAPIHandler.shared.username!)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        super.init()
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
    }
    
}

extension ReceiverService : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true,self.session)
    }
    
}


