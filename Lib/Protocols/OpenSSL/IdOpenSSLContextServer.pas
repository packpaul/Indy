{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

unit IdOpenSSLContextServer;

interface

uses
  IdCTypes,
  IdOpenSSLContext,
  IdOpenSSLOptions,
  IdOpenSSLSocket,
  IdOpenSSLOptionsServer,
  IdOpenSSLHeaders_ssl,
  IdOpenSSLHeaders_ossl_typ;

type
  TIdOpenSSLContextServer = class(TIdOpenSSLContext)
  private
    FSessionIdCtx: array[0 .. SSL_MAX_SID_CTX_LENGTH-1] of Byte;
    FSessionIdCtxFallback: Integer;
    procedure SetSessionContext(
      const AContext: PSSL_CTX;
      const ACAFile: UTF8String);
    procedure SetClientCA(
      const AContext: PSSL_CTX;
      const ACAFile: UTF8String);
  protected
    function GetVerifyMode(const AOptions: TIdOpenSSLOptionsBase): TIdC_INT; override;
  public
    function Init(const AOptions: TIdOpenSSLOptionsServer): Boolean;
    function CreateSocket: TIdOpenSSLSocket; override;
  end;

implementation

uses
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_pem,
  IdOpenSSLHeaders_x509,
  IdOpenSSLSocketServer,
  IdOpenSSLUtils;

{ TIdOpenSSLContextServer }

function TIdOpenSSLContextServer.CreateSocket: TIdOpenSSLSocket;
begin
  Result := TIdOpenSSLSocketServer.Create(OpenSSLContext);
end;

function TIdOpenSSLContextServer.GetVerifyMode(
  const AOptions: TIdOpenSSLOptionsBase): TIdC_INT;
var
  LOptions: TIdOpenSSLOptionsServer;
begin
  Result := SSL_VERIFY_NONE;
  LOptions := TIdOpenSSLOptionsServer(AOptions);
  if LOptions.RequestCertificate then
  begin
    Result := SSL_VERIFY_PEER;
    if LOptions.FailIfNoPeerCertificate then
      Result := Result or SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
    if LOptions.RequestCertificateOnlyOnce then
      Result := Result or SSL_VERIFY_CLIENT_ONCE;
  end;
end;

function TIdOpenSSLContextServer.Init(
  const AOptions: TIdOpenSSLOptionsServer): Boolean;
begin
  Result := inherited Init(AOptions);
  SetSessionContext(OpenSSLContext, UTF8String(AOptions.VerifyCertificate));
  if AOptions.RequestCertificate then
    SetClientCA(OpenSSLContext, UTF8String(AOptions.VerifyCertificate));
end;

procedure TIdOpenSSLContextServer.SetClientCA(const AContext: PSSL_CTX;
  const ACAFile: UTF8String);
var
  LBio: PBIO;
  LX509: PX509;
begin
  LBio := BIO_new_file(GetPAnsiChar(ACAFile), 'r');
  if not Assigned(LBio) then
    EIdOpenSSLSetClientCAError.&Raise();
  try
    LX509 := PEM_read_bio_X509(LBio, nil, nil, nil);
    if not Assigned(LX509) then
      EIdOpenSSLSetClientCAError.&Raise();
    try
      if SSL_CTX_add_client_CA(AContext, LX509) <> 1 then
        EIdOpenSSLSetClientCAError.&Raise();
    finally
      X509_free(LX509);
    end;
  finally
    BIO_free(LBio);
  end;
end;

procedure TIdOpenSSLContextServer.SetSessionContext(
  const AContext: PSSL_CTX;
  const ACAFile: UTF8String);
var
  LBio: PBIO;
  LX509: PX509;
  LLen: Integer;
begin
  if ACAFile = '' then
  begin
    Randomize();
    FSessionIdCtxFallback := Random(High(Integer));
    if SSL_CTX_set_session_id_context(
      AContext,
      PByte(@FSessionIdCtxFallback),
      SizeOf(FSessionIdCtxFallback)) <> 1 then
    begin
      EIdOpenSSLSessionIdContextError.&Raise();
    end;
    Exit;
  end;

  LBio := BIO_new_file(GetPAnsiChar(ACAFile), 'r');
  if not Assigned(LBio) then
    EIdOpenSSLSessionIdContextError.&Raise();
  try
    LX509 := PEM_read_bio_X509(LBio, nil, nil, nil);
    if not Assigned(LX509) then
      EIdOpenSSLSessionIdContextError.&Raise();
    try
      LLen := SSL_MAX_SID_CTX_LENGTH;
      FillChar(FSessionIdCtx[0], LLen, 0);
      if X509_digest(LX509, EVP_sha1, @FSessionIdCtx[0], @LLen) <> 1 then
        EIdOpenSSLSessionIdContextError.&Raise();

      if SSL_CTX_set_session_id_context(AContext, @FSessionIdCtx[0], LLen) <> 1 then
        EIdOpenSSLSessionIdContextError.&Raise();
    finally
      X509_free(LX509);
    end;
  finally
    BIO_free(LBio);
  end;
end;

end.