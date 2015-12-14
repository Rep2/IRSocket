//
//  App.swift
//  SimpleSocketExample
//
//  Created by Rep on 12/14/15.
//  Copyright © 2015 Rep. All rights reserved.
//

import Foundation

class App{
    
    let socket:IRSocket
    
    init(){
        
        if let sock = IRSocket(domain: AF_INET, type: SOCK_DGRAM, proto: 0){
            socket = sock
        }else{
            print("Server socket creation failed")
            exit(1)
        }
        
        do{
        
            let addr = IRSockaddr()
            try socket.bind(addr)
            
        }catch IRSocketError.BindFailed{
            print("Socket bind failed")
            exit(1)
            
        }catch IRSocketError.GetNameFailed{
            print("Get name failed")
            exit(1)
            
        }catch {
            
        }
        
    }
    
}