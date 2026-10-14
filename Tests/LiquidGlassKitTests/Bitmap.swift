import CoreGraphics

/// RGBA pixels of a rendered image (premultiplied alpha, top row first).
struct Bitmap {
    struct Pixel: Equatable {
        let red: UInt8
        let green: UInt8
        let blue: UInt8
        let alpha: UInt8
    }

    let width: Int
    let height: Int
    private let bytes: [UInt8]

    init(_ image: CGImage) {
        width = image.width
        height = image.height
        var bytes = [UInt8](repeating: 0, count: image.width * image.height * 4)
        bytes.withUnsafeMutableBytes { buffer in
            let context = CGContext(
                data: buffer.baseAddress, width: image.width, height: image.height, bitsPerComponent: 8,
                bytesPerRow: image.width * 4, space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )
            context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        }
        self.bytes = bytes
    }

    /// For views drawn on a white canvas: whether a pixel is anything but the canvas.
    static func differsFromWhite(_ pixel: Pixel) -> Bool {
        min(pixel.red, pixel.green, pixel.blue) < 250
    }

    func pixel(x: Int, y: Int) -> Pixel {
        pixel(at: (y * width + x) * 4)
    }

    func count(where predicate: (Pixel) -> Bool) -> Int {
        stride(from: 0, to: bytes.count, by: 4).count { predicate(pixel(at: $0)) }
    }

    private func pixel(at offset: Int) -> Pixel {
        Pixel(red: bytes[offset], green: bytes[offset + 1], blue: bytes[offset + 2], alpha: bytes[offset + 3])
    }
}
