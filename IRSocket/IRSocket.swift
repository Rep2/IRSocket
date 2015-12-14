//
//  IRSocket.swift
//  RASUSLabos
//
//  Created by Rep on 12/14/15.
//  Copyright © 2015 Rep. All rights reserved.
//

import Foundation

enum IRSocketError: ErrorType{
    case BindFailed(error: Int32)
    case CloseFailed(error: Int32)
    case GetNameFailed(error: Int32)
}

/// Basic C socket binding
class IRSocket{
    
    /// C socket
    let cSocket:Int32
    
    /// Creates new instance of IRSocket containing C socket
    /// - Returns: IRSocket nil if creation fails
    init?(domain:Int32, type:Int32, proto:Int32){
        cSocket = socket(domain, type, proto)
        
        if cSocket == -1{
            return nil
        }
    }
    
    
    /// Binds socket to addres and updates address
    /// - Parameter addr: Binding address
    /// - Parameter update: If set updates addr fields
    ///
    /// - Throws: IRSocketError
    func bind(addr:IRSockaddr, update:Bool = true) throws{
        
        let bindRet = withUnsafePointer(&addr.cSockaddr) {
            Darwin.bind(cSocket, UnsafePointer<sockaddr>($0), 16)
        }
        
        if bindRet != 0{
            throw IRSocketError.BindFailed(error: bindRet)
        }
        
        if update{
            try getName(addr)
        }
        
    }
    
    
    /// Updates addr to correct value
    /// - Parameter addr: Binding address
    ///
    /// - Throws: IRSocketError
    func getName(addr:IRSockaddr) throws{
        var src_addr_len = socklen_t(sizeofValue(socket))
        
        let err = withUnsafePointer(&addr.cSockaddr) {
            return getsockname(self.cSocket, UnsafeMutablePointer($0), &src_addr_len)
        }
        
        if err == -1{
            throw IRSocketError.GetNameFailed(error: err)
        }

    }
    
    /// Closes socket
    deinit{
        close(cSocket)
    }
    
}