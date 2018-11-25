import Dispatch
import Glibc

DispatchQueue(label: "worker").asyncAfter(deadline: .now()) {
    print("Doing work...")
    usleep(1 * 1_000_000)
    print("Work done")
}

print("Sleeping for 2 seconds...")
usleep(2 * 1_000_000)

print("Exiting...")
