import UIKit
import Flutter
import Photos
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let albumChannel = FlutterMethodChannel(name: "album_channel", binaryMessenger: controller.binaryMessenger)

        albumChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getAlbumData" {
                self?.fetchAlbumData(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }




    private func fetchAlbumData(result: @escaping FlutterResult) {
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        let normalAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)

        var albumData: [[String: Any]] = []

        [smartAlbums, normalAlbums].forEach { (fetchResult) in
            fetchResult.enumerateObjects { (album, _, _) in
                let options = PHFetchOptions()
                options.fetchLimit = 1
                let assets = PHAsset.fetchAssets(in: album, options: options)

                if let asset = assets.firstObject {
                    let manager = PHImageManager.default()
                    let targetSize = CGSize(width: 100, height: 100)
                    let options = PHImageRequestOptions()
                    options.deliveryMode = .fastFormat
                    options.isSynchronous = true


                    manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, info) in
                        if let image = image {
                            if let imageData = image.pngData()?.base64EncodedString() {

                                let albumInfo: [String: Any] = [
                                    "name": album.localizedTitle ?? "",
                                    "image": imageData
                                ]

                                albumData.append(albumInfo)
                            }
                        }
                    }
                }
            }
        }

        result(["data" : albumData])
    }

}
