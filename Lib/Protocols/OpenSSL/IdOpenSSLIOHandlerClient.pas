unit IdOpenSSLIOHandlerClient;

interface

uses
  IdGlobal,
  IdOpenSSLOptionsClient,
  IdOpenSSLSocketClient,
  IdOpenSSLIOHandlerClientbase,
  IdSSL;

type
  TIdOpenSSLIOHandlerClient = class(TIdOpenSSLIOHandlerClientBase)
  private
    FOptions: TIdOpenSSLOptionsClient;
    function GetTargetHost: string;
    function GetClientSocket: TIdOpenSSLSocketClient; {$IFDEF USE_INLINE}inline;{$ENDIF}
  protected
    function GetOptionClass: TIdOpenSSLOptionsClientClass; virtual;
    procedure InitComponent; override;
    procedure EnsureContext; override;
  public
    destructor Destroy; override;
    procedure StartSSL; override;
  published
    property Options: TIdOpenSSLOptionsClient read FOptions;
  end;

implementation

uses
  IdCustomTransparentProxy,
  IdOpenSSLContextClient,
  IdURI,
  SysUtils;

{ TIdOpenSSLIOHandlerClient }

procedure TIdOpenSSLIOHandlerClient.EnsureContext;
begin
  if PassThrough or Assigned(FContext) then
    Exit;
  FContext := TIdOpenSSLContextClient.Create();
  TIdOpenSSLContextClient(FContext).Init(FOptions);
end;

destructor TIdOpenSSLIOHandlerClient.Destroy;
begin
  FOptions.Free();
  FContext.Free();
  inherited;
end;

function TIdOpenSSLIOHandlerClient.GetClientSocket: TIdOpenSSLSocketClient;
begin
  Result := FTLSSocket as TIdOpenSSLSocketClient;
end;

function TIdOpenSSLIOHandlerClient.GetOptionClass: TIdOpenSSLOptionsClientClass;
begin
  Result := TIdOpenSSLOptionsClient;
end;

function TIdOpenSSLIOHandlerClient.GetTargetHost: string;

  function GetHostToCheck(const AUriToCheck: string): string;
  var
    LURI: TIdURI;
  begin
    Result := '';
    if AUriToCheck = '' then
      Exit;
    LURI := TIdURI.Create(URIToCheck);
    try
      Result := LURI.Host;
    finally
      LURI.Free();
    end;
  end;

  function GetProxyTargetHost(const ATransparentProxy: TIdCustomTransparentProxy): string;
  var
    LProxy: TIdCustomTransparentProxy;
  begin
    Result := '';
    LProxy := ATransparentProxy;
    while Assigned(LProxy) and LProxy.Enabled do
    begin
      Result := LProxy.Host;
      LProxy := LProxy.ChainedProxy;
    end;
  end;

begin
  Result := GetHostToCheck(URIToCheck);
  if Result = '' then
    // RLebeau: not reading from the property as it will create a
    // default Proxy object if one is not already assigned...
    Result := GetProxyTargetHost(FTransparentProxy);
end;

procedure TIdOpenSSLIOHandlerClient.InitComponent;
begin
  inherited;
  FOptions := GetOptionClass().Create();
end;

procedure TIdOpenSSLIOHandlerClient.StartSSL;
begin
  inherited;
  if PassThrough then
    Exit;
  GetClientSocket().Connect(Binding.Handle, GetTargetHost());
end;

end.
