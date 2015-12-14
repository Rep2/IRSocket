# IRSocket
Swift binding of Berkeley socket

This repo is under development. Feel free to contribute!

## Basic socket binding

```

// Creates UDP socket
if let socket = IRSocket(domain: AF_INET, type: SOCK_DGRAM, proto: 0){
    do{
        // Binds socket to OS given address
        let addr = IRSockaddr()
        try socket.bind(addr)
        
    }catch IRSocketError.BindFailed{
        print("Socket bind failed")
        exit(1)
        
    }catch{
        print("Get name failed")
        exit(1)
    }
    
}else{
    print("Server socket creation failed")
    exit(1)
}

```

