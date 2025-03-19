import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { ICityList,
  IDistrictList,
  IGetRentRoomListParams, IGetRentRoomListResponse, IProvinceList } from '../models/RentRoomList';
import { http } from '../util/http/index';

// 搜索房源数据
export   const searchRoomListApi = (params:IGetRentRoomListParams) :Promise<IGetRentRoomListResponse>=> {
  return http.get<IGetRentRoomListResponse>('/house/search',params)
}
// 获取所有省份
export   const getProvinceListApi = () :Promise<IProvinceList>=> {
  return http.get<IProvinceList>('/province')
}
// 获取省下的市
export   const getCityListApi = (provinceCode:string) :Promise<ICityList>=> {
  return http.get<ICityList>('/city',{provinceCode})
}
// 获取市下的区
export   const getDistrictListApi = (cityCode:string) :Promise<IDistrictList>=> {
  return http.get<IDistrictList>('/area',{cityCode})
}