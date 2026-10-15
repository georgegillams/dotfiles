#!/usr/bin/swift
import AppKit
import CoreAudio
import Foundation

func makeAddress(_ selector: AudioObjectPropertySelector) -> AudioObjectPropertyAddress {
    AudioObjectPropertyAddress(
        mSelector: selector,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
}

func allDeviceIDs() -> [AudioDeviceID] {
    var addr = makeAddress(kAudioHardwarePropertyDevices)
    var size: UInt32 = 0
    AudioObjectGetPropertyDataSize(AudioObjectID(kAudioObjectSystemObject), &addr, 0, nil, &size)
    let count = Int(size) / MemoryLayout<AudioDeviceID>.size
    var ids = [AudioDeviceID](repeating: 0, count: count)
    AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &addr, 0, nil, &size, &ids)
    return ids
}

func nameOf(_ id: AudioDeviceID) -> String {
    var name: Unmanaged<CFString>? = nil
    var size = UInt32(MemoryLayout<Unmanaged<CFString>?>.size)
    var addr = makeAddress(kAudioDevicePropertyDeviceNameCFString)
    AudioObjectGetPropertyData(id, &addr, 0, nil, &size, &name)
    return name?.takeRetainedValue() as String? ?? ""
}

func uidOf(_ id: AudioDeviceID) -> String {
    var uid: Unmanaged<CFString>? = nil
    var size = UInt32(MemoryLayout<Unmanaged<CFString>?>.size)
    var addr = makeAddress(kAudioDevicePropertyDeviceUID)
    AudioObjectGetPropertyData(id, &addr, 0, nil, &size, &uid)
    return uid?.takeRetainedValue() as String? ?? ""
}

func findUID(named name: String) -> String? {
    allDeviceIDs().first { nameOf($0) == name }.map { uidOf($0) }
}

let args = CommandLine.arguments
guard args.count >= 3 else {
    fputs("Usage: play-on-device.swift <file> <device-name>\n", stderr)
    exit(1)
}

let filePath = args[1]
let targetDevice = args[2]

guard let uid = findUID(named: targetDevice) else {
    fputs("Device not found: \(targetDevice)\n", stderr)
    exit(1)
}

guard let sound = NSSound(contentsOfFile: filePath, byReference: false) else {
    fputs("Could not load: \(filePath)\n", stderr)
    exit(1)
}

sound.playbackDeviceIdentifier = uid
sound.play()

while sound.isPlaying {
    RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))
}
