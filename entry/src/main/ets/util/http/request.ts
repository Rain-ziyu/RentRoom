import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import promptAction from '@ohos.promptAction';
import AnyObject from '../../models/HttpModel'
const request = axios.create({
  baseURL: 'http://192.168.10.19:6060'
})
// 封装请求时的统一配置
request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    return config
  }
)
// 相应内容判断
request.interceptors.response.use(
  (response: AxiosResponse) => {
    if (response.data.code === 200) {
      return response.data.data;
    } else {
      return Promise.reject(response.data.message);
    }
  },
  (error: AxiosError) => {
    promptAction.showToast({ message: error.message })
    return Promise.reject(error.message)
  }
)


export default class Http{
  get<T>(url:string,params?:AnyObject){
    return request.get<any,T>(url,{params})
  }
  post<T>(url:string,data?:AnyObject){
    return request.post<any,T>(url,data)
  }
  put<T>(url:string,data?:AnyObject){
    return request.put<any,T>(url,data)
  }
  delete<T>(url:string,params?:AnyObject){
    return request.delete<any,T>(url,{params})
  }
}