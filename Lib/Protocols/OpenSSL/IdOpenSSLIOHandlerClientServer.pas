unit IdOpenSSLIOHandlerClientServer;

interface

uses
  IdOpenSSLIOHandlerClientBase,
  IdOpenSSLContextServer;

type
  TIdOpenSSLIOHandlerClientForServer = class(TIdOpenSSLIOHandlerClientBase)
  protected
    procedure EnsureContext; override;
  public
    procedure SetServerContext(const AContext: TIdOpenSSLContextServer);
    procedure StartSSL; override;
  end;

implementation

uses
  IdOpenSSLSocketServer;

{ TIdOpenSSLIOHandlerClientForServer }

procedure TIdOpenSSLIOHandlerClientForServer.EnsureContext;
begin
  inherited;
  Assert(Assigned(FContext));
end;

procedure TIdOpenSSLIOHandlerClientForServer.SetServerContext(
  const AContext: TIdOpenSSLContextServer);
begin
  FContext := AContext;
end;

procedure TIdOpenSSLIOHandlerClientForServer.StartSSL;
begin
  inherited;
  if PassThrough then
    Exit;
  (FTLSSocket as TIdOpenSSLSocketServer).Accept(Binding.Handle);
end;

end.
