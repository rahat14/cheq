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
            }
            else if call.method == "getImagesFromAlbum" {
                if let albumName = call.arguments as? String {
                self?.fetchImagesFromAlbum3(albumName: albumName, result: result)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Album name is required", details: nil))
            }
        }
            else {
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
                // options.fetchLimit = 1
                let assets = PHAsset.fetchAssets(in: album, options: options)
                var count = assets.count
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
                                    "image": imageData,
                                    "count" : count,
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
    
    private func fetchImagesFromAlbum(albumName: String, result: @escaping FlutterResult) {
        print(albumName)
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        
        var album = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchOptions).firstObject
        
        if album == nil {
            
             let fetchOptions = PHFetchOptions()
             fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
             album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions).firstObject
         }
         
         guard let albumCollection = album else {
             print("xxxy")
             result([])
             return
         }
        
        let assets = PHAsset.fetchAssets(in: albumCollection, options: nil)
        var imagesData: [String: Data] = [:]
        
        let manager = PHImageManager.default()
        let targetSize = CGSize(width: 300, height: 300)
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        
        assets.enumerateObjects { (asset, _, _) in
            manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, info) in
                if let image = image, let imageData = image.pngData() {
                    imagesData[asset.localIdentifier] = imageData
                }
            }
        }
        
        print("xxx")
        print(imagesData.count)
        
        result(imagesData)
    }
    
    
 



private func fetchImagesFromAlbum2(albumName: String, result: @escaping FlutterResult) {
    let albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
    
    var albumCollection: PHAssetCollection?
    
    albums.enumerateObjects { (album, _, stop) in
        if album.localizedTitle == albumName {
            albumCollection = album
            stop.pointee = true
        }
    }
    
    guard let album = albumCollection else {
        result([])
        return
    }
    
    let assets = PHAsset.fetchAssets(in: album, options: nil)
    var imagesData: [String] = []
    
    let manager = PHImageManager.default()
    let targetSize = CGSize(width: 300, height: 300)
    let options = PHImageRequestOptions()
    options.deliveryMode = .highQualityFormat
    options.isSynchronous = true
    
    assets.enumerateObjects { (asset, _, _) in
        manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, info) in
            if let image = image, let imageData = image.pngData()?.base64EncodedString() {
                imagesData.append(imageData)
            }
        }
    }
    
    print(imagesData.count)
    result(imagesData)
}

private func fetchImagesFromAlbum3(albumName: String, result: @escaping FlutterResult) {
        var album: PHAssetCollection?
        
        if albumName == "Recents" {
            let cameraRoll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)

                  cameraRoll.enumerateObjects({ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
                    if object is PHAssetCollection {
                      let obj:PHAssetCollection = object as! PHAssetCollection

                      let fetchOptions = PHFetchOptions()
                      fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                      fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                      let assets = PHAsset.fetchAssets(in: obj, options: fetchOptions)
                        var imagesData: [String: Any] = [:]
                        let manager = PHImageManager.default()
                        let targetSize = CGSize(width: 800, height: 800)
                        let options = PHImageRequestOptions()
                        options.deliveryMode = .highQualityFormat
                        options.isSynchronous = true
                        
                        assets.enumerateObjects { (asset, _, _) in
                            manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, info) in
                                if let image = image, let imageData = image.pngData()?.base64EncodedString() {
                                    imagesData[asset.localIdentifier] = imageData
                                }
                            }
                        }
                        
                        result(["data" : imagesData])
                      
                    }
                  })
            
            
        } else {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
            album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions).firstObject
        }
        
        guard let albumCollection = album else {
            result([])
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let assets = PHAsset.fetchAssets(in: albumCollection, options: fetchOptions)
        var imagesData: [String: Any] = [:]
        
        let manager = PHImageManager.default()
        let targetSize = CGSize(width: 800, height: 800)
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        
        assets.enumerateObjects { (asset, _, _) in
            manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, info) in
                if let image = image, let imageData = image.pngData()?.base64EncodedString() {
                    imagesData[asset.localIdentifier] = imageData
                }
            }
        }
        
    
        result(["data" : imagesData])
    }
}
