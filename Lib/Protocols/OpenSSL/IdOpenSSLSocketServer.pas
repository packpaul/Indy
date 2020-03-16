unit IdOpenSSLSocketServer;

interface

uses
  IdOpenSSLSocket,
  IdStackConsts;

type
  TIdOpenSSLSocketServer = class(TIdOpenSSLSocket)
  public
    function Accept(
      const AHandle: TIdStackSocketHandle): Boolean;
  end;

implementation

uses
  IdOpenSSLExceptionResourcestrings,
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_ssl,
  IdCTypes;

{ TIdOpenSSLSocketServer }

function TIdOpenSSLSocketServer.Accept(
  const AHandle: TIdStackSocketHandle): Boolean;
var
  LReturnCode: TIdC_INT;
  LShouldRetry: Boolean;
begin
  FSSL := StartSSL(FContext);
  SSL_set_fd(FSSL, AHandle);

  repeat
    LReturnCode := SSL_accept(FSSL);
    Result := LReturnCode = 1;

    LShouldRetry := ShouldRetry(FSSL, LReturnCode);
    if not LShouldRetry and (LReturnCode < 0) then
      raise EIdOpenSSLAcceptError.Create(FSSL, LReturnCode, '');
  until not LShouldRetry;
end;

end.
