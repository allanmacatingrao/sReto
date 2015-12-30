//
//  TestMulticastHandshakePacket.swift
//  sReto
//
//  Created by Julian Asamer on 17/09/14.
//  Copyright (c) 2014 - 2016 Chair for Applied Software Engineering
//
//  Licensed under the MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness
//  for a particular purpose and noninfringement. in no event shall the authors or copyright holders be liable for any claim, damages or other liability, 
//  whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
//

import UIKit
import XCTest

class TestMulticastHandshakePacket: XCTestCase {
    func testMulticastPacket() {
        let destinationIds: Set<UUID> = [randomUUID(), randomUUID()]
        let hopTree: Tree = Tree(
            value: randomUUID(),
            subtrees: [
                Tree(
                    value: randomUUID(),
                    subtrees: [
                        Tree(
                            value: randomUUID(),
                            subtrees: []
                        )
                    ]
                ),
                Tree(
                    value: randomUUID(),
                    subtrees: []
                )
            ]
        )
        
        let packet1 = MulticastHandshake(sourcePeerIdentifier: randomUUID(), destinationIdentifiers: destinationIds, nextHopTree: hopTree)        
        if let packet2 = MulticastHandshake.deserialize(DataReader(packet1.serialize())) {
            XCTAssert(packet1.sourcePeerIdentifier == packet2.sourcePeerIdentifier, "sourcePeerIdentifier doesn't match.")
            XCTAssert(packet1.destinationIdentifiers == packet2.destinationIdentifiers, "Destination ids dont match.")
            XCTAssert(packet1.nextHopTree == packet2.nextHopTree, "Hop trees dont match.")
        } else {
            XCTFail("Failed to deserialize.")
        }
    }
}
