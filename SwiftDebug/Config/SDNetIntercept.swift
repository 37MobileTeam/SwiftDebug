//
//  SDNetDelegate.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/15.
//

import Foundation


/// 系统网络代理类
class SDURLProtocol: URLProtocol, URLSessionDataDelegate, URLSessionTaskDelegate{
    
    fileprivate var dataTask:URLSessionDataTask?
    fileprivate let sessionDelegateQueue = OperationQueue()
    
    class func startMonitor(){
        let sessionConfiguration = SDSessionConfiguration.shared
        URLProtocol.registerClass(SDURLProtocol.self)
        if !sessionConfiguration.isSwizzle{
            sessionConfiguration.load()
        }
    }
    
    class func stopMonitor(){
        let sessionConfiguration = SDSessionConfiguration.shared
        URLProtocol.unregisterClass(SDURLProtocol.self)
        if sessionConfiguration.isSwizzle{
            sessionConfiguration.unload()
        }
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: "SDURLProtocolHandledKey", in: request) != nil {
            return false
        }
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        let mutableReqeust = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
         //在这里可以对请求修改
        URLProtocol.setProperty(true, forKey: "SDURLProtocolHandledKey",
                                in: mutableReqeust)
        return mutableReqeust as URLRequest
    }
    
    override func startLoading() {
        var data: Data
        if request.httpBody == nil, let inputstream = request.httpBodyStream {
            var buffer = [UInt8](repeating: 0, count: 1024)
            data = Data()
            inputstream.open()
            while inputstream.hasBytesAvailable {
                let len = inputstream.read(&buffer, maxLength: 1024)
                if len > 0, inputstream.streamError == nil {
                    data.append(buffer, count: len)
                }
            }
            inputstream.close()
        } else {
            data = request.httpBody ?? Data()
        }
        let params =  String(data: data, encoding: .utf8)
        SwiftDebug.logNet(title: "请求:\(request.url?.absoluteString ?? "---")", content: params ?? "--")
        let defaultConfigObj = URLSessionConfiguration.default
        sessionDelegateQueue.maxConcurrentOperationCount = 1
        sessionDelegateQueue.name = "com.SQ.session.queue"
        if SDConfigCenter.shared.netConfig.enableNetProxy {
            defaultConfigObj.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            let proxyDic: [String: Any] = [
                (kCFNetworkProxiesHTTPEnable as String): SDConfigCenter.shared.netConfig.enableNetProxy,
                (kCFNetworkProxiesHTTPProxy as String): SDConfigCenter.shared.netConfig.netIp,
                (kCFNetworkProxiesHTTPPort as String): Int(SDConfigCenter.shared.netConfig.netPort) ?? 8888]
            defaultConfigObj.connectionProxyDictionary = proxyDic
        }
        let defaultSession = Foundation.URLSession(configuration: defaultConfigObj,
                                                   delegate: self, delegateQueue: sessionDelegateQueue)
        dataTask = defaultSession.dataTask(with: self.request)
        dataTask!.resume()
    }
    
    override func stopLoading() {
        dataTask?.cancel()
        dataTask = nil
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            client?.urlProtocolDidFinishLoading(self)
        } else {
            client?.urlProtocol(self, didFailWithError: error!)
            SwiftDebug.logNet(level: .error, title: "网络出错:\(task.currentRequest!.url!.lastPathComponent)", content: error!.localizedDescription)
        }
        self.dataTask = nil
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let responseContent = String(data: data, encoding: .utf8)
        var level: SDLogLevel = .info
        if let httpResponse = dataTask.response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            level = .error
        }
        SwiftDebug.logNet(level: level, title: "响应:\(request.url?.absoluteString ?? "---")", content: responseContent ?? "解析失败")
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        client?.urlProtocol(self, wasRedirectedTo: request, redirectResponse: response)
    }
}

class SDSessionConfiguration: NSObject {
    
    static var shared = SDSessionConfiguration()
    fileprivate override init(){}
    
    
    var isSwizzle = false
    
    func load(){
        isSwizzle = true
        guard let cls = NSClassFromString("__NSCFURLSessionConfiguration") ?? NSClassFromString("NSURLSessionConfiguration") else { return }
        swizzleSelector(selector: #selector(protocolClasses), fromClass: cls, toClass: SDSessionConfiguration.self)
    }
    
    func unload(){
        isSwizzle = false
        guard let cls = NSClassFromString("__NSCFURLSessionConfiguration") ?? NSClassFromString("NSURLSessionConfiguration") else { return }
        swizzleSelector(selector: #selector(protocolClasses), fromClass: cls, toClass: SDSessionConfiguration.self)
    }
    
    func swizzleSelector(selector: Selector, fromClass: AnyClass, toClass: AnyClass){
        let originalMethod = class_getInstanceMethod(fromClass, selector)
        let stubMethod = class_getInstanceMethod(toClass, selector)
        guard originalMethod != nil && stubMethod != nil else { return }
        method_exchangeImplementations(originalMethod!, stubMethod!)
    }
    
    @objc func protocolClasses() -> NSArray{
        return [SDURLProtocol.self]
    }
}
