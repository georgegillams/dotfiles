#!/usr/bin/swift
import CoreAudio
import Foundation

func makeAddress(_ selector: AudioObjectPropertySelector, scope: AudioObjectPropertyScope = kAudioObjectPropertyScopeGlobal) -> AudioObjectPropertyAddress {
    AudioObjectPropertyAddress(
        mSelector: selector,
        mScope: scope,
        mElement: kAudioObjectPropertyElementMain
    )
}

func getDefaultDevice(input: Bool) -> AudioDeviceID {
    var id = AudioDeviceID(0)
    var size = UInt32(MemoryLayout<AudioDeviceID>.size)
    var addr = makeAddress(input ? kAudioHardwarePropertyDefaultInputDevice : kAudioHardwarePropertyDefaultOutputDevice)
    AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &addr, 0, nil, &size, &id)
    return id
}

func setDefaultDevice(_ id: AudioDeviceID, input: Bool) {
    var mutableID = id
    let size = UInt32(MemoryLayout<AudioDeviceID>.size)
    var addr = makeAddress(input ? kAudioHardwarePropertyDefaultInputDevice : kAudioHardwarePropertyDefaultOutputDevice)
    AudioObjectSetPropertyData(AudioObjectID(kAudioObjectSystemObject), &addr, 0, nil, size, &mutableID)
}

func nameOf(_ id: AudioDeviceID) -> String {
    var name: Unmanaged<CFString>? = nil
    var size = UInt32(MemoryLayout<Unmanaged<CFString>?>.size)
    var addr = makeAddress(kAudioDevicePropertyDeviceNameCFString)
    AudioObjectGetPropertyData(id, &addr, 0, nil, &size, &name)
    return name?.takeRetainedValue() as String? ?? ""
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

func channelCount(_ id: AudioDeviceID, input: Bool) -> Int {
    let scope: AudioObjectPropertyScope = input ? kAudioObjectPropertyScopeInput : kAudioObjectPropertyScopeOutput
    var addr = makeAddress(kAudioDevicePropertyStreamConfiguration, scope: scope)
    var size: UInt32 = 0
    AudioObjectGetPropertyDataSize(id, &addr, 0, nil, &size)
    guard size > 0 else { return 0 }
    let bufferList = UnsafeMutableRawPointer.allocate(byteCount: Int(size), alignment: MemoryLayout<AudioBufferList>.alignment)
    defer { bufferList.deallocate() }
    AudioObjectGetPropertyData(id, &addr, 0, nil, &size, bufferList)
    let list = bufferList.bindMemory(to: AudioBufferList.self, capacity: 1).pointee
    return Int(list.mNumberBuffers)
}

func findDeviceID(named name: String, input: Bool) -> AudioDeviceID? {
    allDeviceIDs().first { nameOf($0) == name && channelCount($0, input: input) > 0 }
}

// Parse args
var deviceName: String? = nil
var deviceID: UInt32? = nil
var isInput = false
var listMode = false

var i = 1
let args = CommandLine.arguments
while i < args.count {
    switch args[i] {
    case "-s":
        i += 1
        if i < args.count { deviceName = args[i] }
    case "-sid":
        i += 1
        if i < args.count { deviceID = UInt32(args[i]) }
    case "-t":
        i += 1
        if i < args.count { isInput = args[i] == "input" }
    case "-l":
        listMode = true
    default:
        break
    }
    i += 1
}

if listMode {
    allDeviceIDs().forEach { print("\($0)\t\(nameOf($0))") }
} else if let name = deviceName {
    if let id = findDeviceID(named: name, input: isInput) {
        setDefaultDevice(id, input: isInput)
    } else {
        fputs("Device not found: \(name)\n", stderr)
        exit(1)
    }
} else if let id = deviceID {
    setDefaultDevice(id, input: isInput)
} else {
    // No args: print current default output device ID
    print(getDefaultDevice(input: isInput))
}
