import Foundation

DispatchQueue.main.async {
    print("Done!")
    exit(0)
}

print("Starting main event loop...")
dispatchMain()
