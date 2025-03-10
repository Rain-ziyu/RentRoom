export interface IServiceData {

  "vipServiceList": IVipServiceList,
  "homeServiceList": IHomeServiceList,
  "serviceActivity": IServiceActivity,
  "newcomerZone": INewcomerZone,
  "cleaningServiceInfo": ICleaningServiceInfoList

}

export interface IVipServiceItem {
  "name": string
  "content": number
}

export type IVipServiceList = IVipServiceItem[]

export interface IHomeServiceItem {
  "icon": string,
  "title": string
}

export type IHomeServiceList = IHomeServiceItem[]

export interface IServiceActivity {
  "name": string,
  "img": string,
  "title": string,
  "subTitle": string
}

export interface INewcomerZone {
  "img": string
}

export type ICleaningServiceInfoList = ICleaningServiceInfoItem[]

export interface ICleaningServiceInfoItem {
  "img": string,
  "title": string,
  "subTitle": string,
  "originalPrice": string,
  "priceAfterDiscounts": string
}