//
//  PreviousSessionUploadDelegate.swift
//  PlacenoteSDK referenced from http://www.gregread.com/2016/02/23/multicast-delegates-in-swift/#Option_2_8211_A_Better_Way
//
//  Created by Prasenjit Mukherjee on 2018-01-09.
//  Copyright © 2018 Vertical AI. All rights reserved.

import Foundation


/// A helper class that wraps around multiple PreviousPNSessionDelegates with convenient
/// utility operators to append and remove delegates to/from the list
public class PreviousSessionUploadDelegate {
  private var delegates = [PreviousPNSessionDelegate]()

  /**
   A function to append delegate to the PreviousSessionUploadDelegate delegate
   
   - Parameter delegate: A PreviousPNSessionDelegate to be appended
   */
  public func addDelegate(delegate: PreviousPNSessionDelegate) {
    // If delegate is a class, add it to our weak reference array
    delegates.append(delegate)
  }
  
  /**
   A function to remove delegate to the multicast delegate
   
   - Parameter delegate: A PNDelegate to be removed
   */
  public func removeDelegate(delegate: PreviousPNSessionDelegate) {
    for (index, delegateInArray) in delegates.enumerated().reversed() {
      // If we have a match, remove the delegate from our array
      if ((delegateInArray as AnyObject) === (delegate as AnyObject)) {
        delegates.remove(at: index)
      }
    }
  }
  
  /**
   Callback to subscribe to status of old uploads unfinished due to app closure
   
   - Parameter uploadStatus: Status of map (or dataset) upload.
   */
  func prevSessionMapUploadStatus(mapid: String, completed: Bool, faulted: Bool, percentage: Float) {
    for del in delegates {
      del.prevSessionMapUploadStatus(mapid: mapid, completed: completed, faulted: faulted, percentage: percentage)
    }
  }
  
  /**
   Callback to subscribe to status of old uploads unfinished due to app closure
   
   - Parameter uploadStatus: Status of map (or dataset) upload.
   */
  func prevSessionDatasetUploadStatus(mapid: String, completed: Bool, faulted: Bool, percentage: Float) {
    for del in delegates {
      del.prevSessionDatasetUploadStatus(mapid: mapid, completed: completed, faulted: faulted, percentage: percentage)
    }
  }
}

/**
 += operator to append delegate to the multicast delegate
 
 - Parameter delegate: A PNDelegate to be appended
 */
public func += (left: PreviousSessionUploadDelegate, right: PreviousPNSessionDelegate) {
  left.addDelegate(delegate: right)
}

/**
 -= operatorto remove delegate to the multicast delegate
 
 - Parameter delegate: A PNDelegate to be removed
 */
public func -= (left: PreviousSessionUploadDelegate, right: PreviousPNSessionDelegate) {
  left.removeDelegate(delegate: right)
}
