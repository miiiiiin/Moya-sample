//
//import Foundation
//import Moya
//
//
//class NetworkManager<T> where T: Codable {
//
//  func requestModel<R: TargetType>(
//    _ type: R,
//    test: Bool = false,
//    progressBlock: ((Double) -> ())? = nil,
//    completion: @escaping ((ModelResponse<T>?) -> ()),
//    error: @escaping (NetworkError) -> () )
//    -> Cancellable?
//  {
//    return request(type, test: test, progressBlock: progressBlock, modelComletion: completion, error: error)
//  }
//
//  // 用来处理只请求一次的栅栏队列
//  private let barrierQueue = DispatchQueue(label: "cn.tsingho.qingyun.NetworkManager", attributes: .concurrent)
//  // 用来处理只请求一次的数组,保存请求的信息 唯一
//  private var fetchRequestKeys = [String]()
//
//}
//
//
//extension NetworkManager {
//  /// 请求基类方法
//  ///
//  /// - Parameters:
//  ///   - type: 根据Moya定义的接口
//  ///   - test: 是否使用测试(几乎用不到)
//  ///   - progressBlock: 进度返回闭包
//  ///   - modelComletion: 普通接口返回数据闭包
//  ///   - modelListComletion: 列表接口返回数据闭包
//  ///   - error: 错误信息返回闭包
//  /// - Returns: 可以用来取消请求
//  private func request<R: TargetType>(
//    _ type: R,
//    test: Bool = false,
//    progressBlock: ((Double) -> ())? = nil,
//    modelComletion: ((ModelResponse<T>?) -> ())? = nil,
//    error: @escaping (NetworkError) -> () )
//    -> Cancellable?
//  {
//
//    let provider = createProvider(type: type, test: test)
//    let cancellable = provider.request(type, callbackQueue: DispatchQueue.global(), progress: { (progress) in
//      DispatchQueue.main.async {
//        progressBlock?(progress.progress)
//      }
//    }) { (response) in
//      let errorblock = { (e: NetworkError) in
//        DispatchQueue.main.async {
//          error(e)
//        }
//      }
//
//      // 请求完成移除
//      self.cleanRequest(type)
//
//      switch response {
//      case .success(let successResponse):
//        if let temp = modelComletion {
//          self.handleSuccessResponse(type, response: successResponse, modelComletion: temp, error: error)
//        }
//      case .failure:
//        errorblock(NetworkError.exception(message: "未连接到服务器"))
//      }
//    }
//    return cancellable
//  }
//
//  //处理成功的返回
//  private func handleSuccessResponse<R: TargetType>(
//    _ type: R,
//    response: Response,
//    modelComletion: ((ModelResponse<T>?) -> ())? = nil,
//    error: @escaping (NetworkError) -> ())
//  {
//    switch type.task {
//    case .uploadMultipart, .requestParameters:
//      do {
//        if let temp = modelComletion {
////          let modelResponse = try handleResponseData(false, type: type, data: response.data)
////          DispatchQueue.main.async {
////            self.cacheData(type, modelComletion: temp, model: (modelResponse.0, nil))
////            temp(modelResponse.0)
////          }
//        }
//      } catch let NetworkError.serverResponse(message, code) {
//        error(NetworkError.serverResponse(message: message, code: code))
//      } catch let NetworkError.loginStateIsexpired(message) {
//        // 登录状态变化清楚登录缓存信息
//        error(NetworkError.loginStateIsexpired(message: message))
//      } catch {
//        #if Debug
//        fatalError("未知错误")
//        #endif
//      }
//    default:
//      ()
//    }
//  }
//
//  // 处理错误信息
//  private func handleCode(responseCode: Int, message: String?) throws {
//    switch responseCode {
//    case ResponseCode.forceLogoutError:
//      throw NetworkError.loginStateIsexpired(message: message)
//    default:
//      throw NetworkError.serverResponse(message: message, code: responseCode)
//    }
//  }
//
//
//  // 创建moya请求类
//  private func createProvider<T: TargetType>(type: T, test: Bool) -> MoyaProvider<T> {
//    let activityPlugin = NetworkActivityPlugin { (state, targetType) in
//      switch state {
//      case .began:
//        DispatchQueue.main.async {
////          if type.isShowHud {
////            //                    SVProgressHUD.showLoading()
////          }
//          self.startStatusNetworkActivity()
//        }
//      case .ended:
//        DispatchQueue.main.async {
////          if type.isShowHud {
////            //                    SVProgressHUD.dismiss()
////          }
//          self.stopStatusNetworkActivity()
//        }
//      }
//    }
//    let provider = MoyaProvider<T>(plugins: [activityPlugin, NetworkLoggerPlugin(verbose: false)])
//    return provider
//  }
//
//  private func startStatusNetworkActivity() {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//  }
//
//  private func stopStatusNetworkActivity() {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//  }
//}
//
//// 保证同一请求同一时间只请求一次
//extension NetworkManager {
//
//  private func cleanRequest<R: TargetType>(_ type: R) {
//    switch type.task {
//    case let .requestParameters(parameters, _):
//      let key = type.path + parameters.description
//      barrierQueue.sync(flags: .barrier) {
////        fetchRequestKeys.remove(at: key)
//      }
//    default:
//      // 不会调用
//      ()
//    }
//  }
//}
