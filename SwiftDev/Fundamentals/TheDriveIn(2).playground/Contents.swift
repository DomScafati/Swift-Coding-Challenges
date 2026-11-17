import Foundation
import AVFoundation

// Video Streaming in Swift Challenge
//
// Phrases/patterns that signal which type or property to use:
// "a time / position in the video"       → CMTime
// "create a player for this URL"         → AVPlayer(url:)
// "loading / ready / failed"             → switch on AVPlayerItem.Status
// "is it buffering right now"            → AVPlayer.TimeControlStatus
// "how much has downloaded so far"       → AVPlayerItem.loadedTimeRanges
// "limit the video quality"              → AVPlayerItem.preferredPeakBitRate

// The old Starlight Drive-In now streams films from a server. You are
// writing the Swift code in the projection booth. Each challenge is one
// small job with Apple's AVFoundation types. Nothing here touches the
// network, so every test runs offline.

// MARK: Pre-defined (do not modify)
let filmURL = URL(string: "https://example.com/film.m3u8")!

// ============================================================
// MARK: - Challenge 1 (The Clock): CMTime
// ============================================================
/*
 Video time is a `CMTime`, not a `Double`.

 func makeTime(seconds: Double) -> CMTime

 Return a CMTime for that many seconds. Use `preferredTimescale: 600`.

 Hint: `CMTime(seconds:preferredTimescale:)`
*/

// MARK: Your solution (Challenge 1)


// MARK: Tests (Challenge 1) — uncomment as you go
// assert(makeTime(seconds: 30).seconds == 30)
// assert(makeTime(seconds: 30).timescale == 600)   // the timescale you were asked for
// assert(makeTime(seconds: 1.5).seconds == 1.5)    // not a whole number
// assert(makeTime(seconds: 0).seconds == 0)        // zero
// print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Projector): Make a Player
// ============================================================
/*
 Build an `AVPlayer` for a URL. Do not start playing it.

 func makePlayer(url: URL, muted: Bool) -> AVPlayer

 Steps:
   - create the player from `url`
   - set its `isMuted` to `muted`
   - return it

 Hint: `AVPlayer(url:)` makes the AVPlayerItem for you.
*/

// MARK: Your solution (Challenge 2)


// MARK: Tests (Challenge 2) — uncomment as you go
// let loud = makePlayer(url: filmURL, muted: false)
// let quiet = makePlayer(url: filmURL, muted: true)
// assert(loud.isMuted == false)
// assert(quiet.isMuted == true)
// assert(quiet.rate == 0)                                                // not playing yet
// assert((quiet.currentItem?.asset as? AVURLAsset)?.url == filmURL)      // uses the URL given
// print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Status Board): Item Status
// ============================================================
/*
 An `AVPlayerItem` has a `status` of type `AVPlayerItem.Status`.
 Turn it into text for the screen.

 func statusMessage(_ status: AVPlayerItem.Status) -> String

   .unknown     → "Loading"
   .readyToPlay → "Ready"
   .failed      → "Failed"

 Hint: use a switch. If Xcode asks for it, finish with `@unknown default`.
*/

// MARK: Your solution (Challenge 3)


// MARK: Tests (Challenge 3) — uncomment as you go
// assert(statusMessage(.unknown) == "Loading")
// assert(statusMessage(.readyToPlay) == "Ready")
// assert(statusMessage(.failed) == "Failed")
// print("Challenge 3 passed!")


// ============================================================
// MARK: - Challenge 4 (The Spinner): Buffering
// ============================================================
/*
 A player reports `timeControlStatus` of type `AVPlayer.TimeControlStatus`.
 The cases are `.paused`, `.waitingToPlayAtSpecifiedRate` and `.playing`.

 Show the loading spinner only while the player is waiting to play.

 func showSpinner(for status: AVPlayer.TimeControlStatus) -> Bool

 Hint: only one case should return true.
*/

// MARK: Your solution (Challenge 4)


// MARK: Tests (Challenge 4) — uncomment as you go
// assert(showSpinner(for: .waitingToPlayAtSpecifiedRate) == true)
// assert(showSpinner(for: .playing) == false)
// assert(showSpinner(for: .paused) == false)
// print("Challenge 4 passed!")


// ============================================================
// MARK: - Challenge 5 (The Buffer Bar): Loaded Ranges
// ============================================================
/*
 `AVPlayerItem.loadedTimeRanges` is an array of `NSValue`. Each one holds
 a `CMTimeRange` (a start and a duration) of video that has downloaded.

 Return where the FIRST range ends, in seconds.
 Return nil if the array is empty.

 func bufferedUntil(_ ranges: [NSValue]) -> Double?

 Hint: `NSValue` has `.timeRangeValue`, and a `CMTimeRange` has `.end`.
 `.end` is a CMTime, so use `.seconds`.
*/

// MARK: Pre-defined (do not modify)
func range(start: Double, length: Double) -> NSValue {
    NSValue(timeRange: CMTimeRange(
        start: CMTime(seconds: start, preferredTimescale: 600),
        duration: CMTime(seconds: length, preferredTimescale: 600)
    ))
}

// MARK: Your solution (Challenge 5)


// MARK: Tests (Challenge 5) — uncomment as you go
// assert(bufferedUntil([range(start: 0, length: 12)]) == 12)                          // starts at zero
// assert(bufferedUntil([range(start: 10, length: 20)]) == 30)                         // start + length
// assert(bufferedUntil([range(start: 0, length: 12), range(start: 50, length: 5)]) == 12)   // first range only
// assert(bufferedUntil([]) == nil)                                                    // empty
// print("Challenge 5 passed!")


// ============================================================
// MARK: - Challenge 6 (The Data Cap): Peak Bitrate
// ============================================================
/*
 Cap the quality of a stream. An `AVPlayerItem` has a property
 `preferredPeakBitRate` that is a `Double` in bits per second.
 You are given the limit in kilobits per second (kbps).

 func capBitrate(on item: AVPlayerItem, kbps: Int)

 Set `item.preferredPeakBitRate` to the limit in bits per second.
 1 kbps is 1000 bits per second.

 Hint: convert the Int to a Double before you multiply.
*/

// MARK: Your solution (Challenge 6)


// MARK: Tests (Challenge 6) — uncomment as you go
// let item = AVPlayerItem(url: filmURL)
// assert(item.preferredPeakBitRate == 0)        // 0 means no cap yet
// capBitrate(on: item, kbps: 1500)
// assert(item.preferredPeakBitRate == 1_500_000)
// capBitrate(on: item, kbps: 800)
// assert(item.preferredPeakBitRate == 800_000)  // changes when called again
// capBitrate(on: item, kbps: 0)
// assert(item.preferredPeakBitRate == 0)        // 0 removes the cap
// print("Challenge 6 passed!")
