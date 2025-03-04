object dmMainf: TdmMainf
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object RESTClient: TRESTClient
    BaseURL = 
      'https://api.open-meteo.com/v1/forecast?latitude=15.472&longitude' +
      '=73.8958&current=temperature_2m,apparent_temperature,is_day,prec' +
      'ipitation,rain,showers,cloud_cover,wind_speed_10m,wind_direction' +
      '_10m&hourly=temperature_2m&daily=temperature_2m_max,sunrise,suns' +
      'et,daylight_duration,rain_sum,wind_speed_10m_max&timezone=Asia%2' +
      'FBangkok'
    Params = <>
    SynchronizedEvents = False
    Left = 72
    Top = 200
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 88
    Top = 96
  end
  object RESTResponse: TRESTResponse
    Left = 208
    Top = 96
  end
end
