unit IdOpenSSLSocketClient;

interface

uses
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLSocket,
  IdStackConsts;

type
  TIdOpenSSLSocketClient = class(TIdOpenSSLSocket)
  private
    FSession: Pointer;
  public
    function Connect(
      const AHandle: TIdStackSocketHandle;
      const ASNIHostname: string = ''): Boolean;
    procedure SetSession(const ASession: Pointer);
  end;

implementation

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLExceptionResourcestrings,
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_ssl,
  IdOpenSSLHeaders_tls1,
  IdOpenSSLUtils;

{ TIdOpenSSLSocketClient }

function TIdOpenSSLSocketClient.Connect(
  const AHandle: TIdStackSocketHandle;
  const ASNIHostname: string): Boolean;
var
  LReturnCode: TIdC_INT;
  LShouldRetry: Boolean;
//  x: Boolean;
begin
  FSSL := StartSSL(FContext);
  SSL_set_fd(FSSL, AHandle);
  if ASNIHostname <> '' then
    if SSL_set_tlsext_host_name(FSSL, GetPAnsiChar(UTF8String(ASNIHostname))) <> 1 then
      EIdOpenSSLSetSNIServerNameError.&Raise();
  if Assigned(FSession) then
    if SSL_set_session(FSSL, FSession) <> 1 then
      EIdOpenSSLSetSessionError.&Raise();

  repeat
    LReturnCode := SSL_connect(FSSL);
    Result := LReturnCode = 1;

    LShouldRetry := ShouldRetry(FSSL, LReturnCode);
    if not LShouldRetry and (LReturnCode < 0) then
      raise EIdOpenSSLConnectError.Create(FSSL, LReturnCode, '');
  until not LShouldRetry;

  // The specification recommends that applications only use a session once
  // (although this may not be enforced). Now we enforce this on our own :)
//  SSL_CTX_remove_session(FContext, FSession);
//  x := SSL_session_reused(FSSL) = 1;
end;

procedure TIdOpenSSLSocketClient.SetSession(const ASession: Pointer);
begin
  FSession := ASession;
end;

end.
