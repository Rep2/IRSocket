//
//  IRSockaddr.swift
//  RASUSLabos
//
//  Created by Rep on 12/14/15.
//  Copyright © 2015 Rep. All rights reserved.
//

import Foundation

/// Simple wrapper for C sockaddr
class IRSockaddr{
    
    var cSockaddr:sockaddr_in
    
    init(ip: UInt32 = 0, port: UInt16 = 0, domain:Int32 = AF_INET){
        cSockaddr = sockaddr_in(
            sin_len:    __uint8_t(sizeof(sockaddr_in)),
            sin_family: sa_family_t(domain),
            sin_port:   htons(port),
            sin_addr:   in_addr(s_addr: ip),
            sin_zero:   ( 0, 0, 0, 0, 0, 0, 0, 0 )
        )
    }
    
}