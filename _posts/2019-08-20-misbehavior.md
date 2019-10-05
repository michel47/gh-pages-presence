---
layout: post
title:  "misbehaving on the blockRing™"
date:   2019-08-20 10:24:43 +0200
categories: blockRing
keywords: corruption misbehaving
search_url: https://duckduckgo.com/?q
---

One of the key security principle we observed, in designing
the blockRings™ is the resilience to "corruption".

if someone what to misbehave let's him do it... however he is exposed !

That is why we use "open-hash" function in our "content-addressable-storage".

In fact it is a rather a KVS as there is no provision for someone not to change the content
pointed by a certain key.


The hash-function is differed to the application layer, consequently a blockRing™ blob is

``[addr=hash(data),data]``

This allows us to use keyed-hash ([HMAC]) to sign the blocks
and provide a [forward chain][FC] for distributing [mutables]

We use [*Keccak*MAC][KM] with a length of 224 for our cryptographic-hash-function

what does it means that if someone create collision or use a non-secure hash,
well it will mean that the associated payload is simply "anonnymously" modifiable.
by adding signatures to the block we "premissionned" the blockRing™ exposing, all misbehaviors.

As a consequence all "payload" can be corrupted and we validate it when we use it
by checking its message authentication code, the keys used for the authentication
are distributed via a "[one-time-key-chain][OTK]" 

[HMAC]: {{page.search_url}}=!g+keyed+hash+function
[OTK]: {{page.search_url}}=!g+one+time+key+chain+%22blockRing™%22
[KM]: /perl/code/2019/08/20/kmac-NIST-SP800-185-perl-module.html
[FC]: {{page.search_url}}=!g+mutable+and+forward+chain+%22blockRing™%22
[mutables]: {{page.search_url}}=!g+mutables+and+%22blockRing™%22







