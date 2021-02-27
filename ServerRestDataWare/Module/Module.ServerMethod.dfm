object DmServerMethod: TDmServerMethod
  OldCreateOrder = False
  Encoding = esUtf8
  Height = 346
  Width = 381
  object DWSEvents: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Hora'
        EventName = 'Hora'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsHoraReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Versao'
        EventName = 'Versao'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWSEventsEventsVersaoReplyEvent
      end>
    Left = 48
    Top = 40
  end
end
