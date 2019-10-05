---
layout: post
title:  "Client-IP with simply javascript"
date:   2019-08-19 19:02:19 +0200
categories: javascript code
---


This note is about how to get the IP with simply javascript code,
You can easily obtain
the ip information of the client (without reply on *external* services).

with the help of peer-services we have 2 options:
1. WebRTC to get a *LAN*IP : <http://dweb.link/ipfs/QmSsnL5QTC18msyAyVYEqwXrhaDDExvpB5DbVUZVVP6Ezw>
2. IPFS : to get the *public*IP and also the local ones<br>
   from the IPFS [loal addresses](http://127.0.0.1:5001/api/v0/swarm/addrs/local) : 
   <http://127.0.0.1:8080/ipfs/QmXsRhn66aJWkxamUvwje57NgZnoXDe9bVFxAH3vRPMeq2>

note: you'd need an IPFS node running on [http://127.0.0.1:8080](http://127.0.0.1:8080/ipns/webui.ipfs.io)
for the last point to work





