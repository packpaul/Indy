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

unit IdOpenSSLContext;

interface

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_ssl,
  IdOpenSSLOptions,
  IdOpenSSLSocket,
  IdOpenSSLTypes;

type
  TIdOpenSSLContext = class(TObject)
  public const
    CExDataIndexSelf = 0;
//    CExDataIndexOptions = 1;
  private
    FContext: PSSL_CTX;
    FOptions: TIdOpenSSLOptionsBase;
    function AreOptionsUnchanged(const AOptions: TIdOpenSSLOptionsBase): Boolean;

    procedure InitContextWithStaticValues(const AContext: PSSL_CTX);
    procedure SetExData(const AContext: PSSL_CTX; AIndex: Integer; const AObj: TObject);
    procedure SetTLSVersions(
      const AContext: PSSL_CTX;
      const AMinVersion: TIdOpenSSLVersion;
      const AMaxVersion: TIdOpenSSLVersion);
    procedure SetVerifyLocations(
      const AContext: PSSL_CTX;
      const AVerifyCertificate: UTF8String;
      const AVerifyCertDirectory: UTF8String);
    procedure SetCertificate(
      const AContext: PSSL_CTX;
      const ACertificateFile: UTF8String;
      const APrivateKeyFile: UTF8String);
    procedure SetCiphers(
      const AContext: PSSL_CTX;
      const ACipherList: UTF8String;
      const ACipherSuites: UTF8String;
      const AUseServerCipherPreferences: Boolean);
    procedure SetKeylogCallback(
      const AContext: PSSL_CTX;
      const ACallback: TKeyLog);
    procedure SetLegacyOptions(
      const AContext: PSSL_CTX;
      const AAllowUnsafeLegacyRenegotiation: Boolean;
      const AUseLegacyServerConnect: Boolean);

    /// <summary>
    ///   Decrements the reference count of the internal SSL_CTX object, and
    ///   removes the SSL_CTX object pointed to by ctx and frees up the
    ///   allocated memory if the reference count has reached 0
    /// </summary>
    /// <remarks>
    ///   The function is nil-safe
    /// </remarks>
    procedure FreeContext(const AContext: PSSL_CTX);
  protected
    function GetVerifyMode(const AOptions: TIdOpenSSLOptionsBase): TIdC_INT; virtual; abstract;
  public
    destructor Destroy; override;

    function Init(const AOptions: TIdOpenSSLOptionsBase): Boolean;
    function CreateSocket: TIdOpenSSLSocket; virtual; abstract;

    property OpenSSLContext: PSSL_CTX read FContext;
  end;

implementation

uses
  IdOpenSSLExceptionResourcestrings,
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_ssl3,
  IdOpenSSLHeaders_tls1,
  IdOpenSSLHeaders_x509,
  IdOpenSSLHeaders_x509_vfy,
  IdOpenSSLUtils,
  Math,
  SysUtils;

function FreeString(const Value: string): Boolean;
var
  refCount: Integer;
begin
  // clear passed string if its refcount allows for it, removes the value from
  //  memory of the process
  refCount := StringRefCount(Value);
  Result := (refCount > -1) and (refCount < 2);
  if Result then
    FillChar(PByte(Value)^, Length(Value) * SizeOf(Char), 0);
end;

function GetPasswordCallback(buf: PIdAnsiChar; size: TIdC_INT; rwflag: TIdC_INT; userdata: Pointer): TIdC_INT; cdecl;
type
  PBytesPtr = ^TBytes;
var
  LContext: TIdOpenSSLContext;
  LPassword: string;
  LPasswordBytes: TIdBytes;
  LPasswordByteLength: Integer;
begin
  Result := 0;
  LContext := TIdOpenSSLContext(userdata);
  if not Assigned(LContext.FOptions.OnGetPassword) then
    Exit;
  FillChar(buf^, size, 0);

  LPassword := '';
  LContext.FOptions.OnGetPassword(LContext, LPassword, rwflag = 1);
  UniqueString(LPassword);

  LPasswordBytes := IndyTextEncoding_OSDefault.GetBytes(LPassword);
  LPasswordByteLength := Length(LPasswordBytes);
  if LPasswordByteLength = 0 then
    Exit;
  {$IFDEF USE_MARSHALLED_PTRS}
  TMarshal.Copy(PBytesPtr(@LPasswordBytes)^, 0, TPtrWrapper.Create(buf), IndyMin(LPasswordByteLength, size));
  {$ELSE}
  Move(LPasswordBytes[0], buf^, IndyMin(LPasswordByteLength, size));
  {$ENDIF}

  // Override memory to prevent reading password via memory dump
  FillChar(LPasswordBytes[0], LPasswordByteLength, 0);
  FreeString(LPassword);

  buf[size-1] := #0; // RLebeau: truncate the password if needed
  Result := IndyMin(LPasswordByteLength, size);
end;

function VerifyCallback(preverify_ok: TIdC_INT;
  x509_ctx: PX509_STORE_CTX): TIdC_INT; cdecl;
var
  LCert: PX509;
  LName: PX509_NAME;
  LIssuer, LSubject: string;
begin
  Result := 0;
  LCert := X509_STORE_CTX_get_current_cert(x509_ctx);
  if not Assigned(LCert) then
    Exit;

  LName := X509_get_issuer_name(LCert);
  LIssuer := GetString(X509_NAME_oneline(LName, nil, 0));

  LName := X509_get_subject_name(LCert);
  LSubject := GetString(X509_NAME_oneline(LName, nil, 0));

  if preverify_ok = 1 then
    Result := 1;
end;

procedure KeylogCallback(const ssl: PSSL; const line: PIdAnsiChar); cdecl;
var
  LCtx: PSSL_CTX;
  LContext: TIdOpenSSLContext;
begin
  LCtx := SSL_get_SSL_CTX(ssl);
  LContext := TIdOpenSSLContext(SSL_ctx_get_ex_data(LCtx, TIdOpenSSLContext.CExDataIndexSelf));
  if not Assigned(LContext) then
    EIdOpenSSLGetExDataError.&Raise(RIdOpenSSLGetExDataError);

//  LOptions := TIdOpenSSLOptionsBase(SSL_ctx_get_ex_data(LCtx, TIdOpenSSLContext.CExDataIndexOptions));
//  if not Assigned(LOptions) then
//    EIdOpenSSLGetExDataError.&Raise(RIdOpenSSLGetExDataError);

  if not Assigned(LContext.FOptions.OnKeyLogging) then
    Exit;
  LContext.FOptions.OnKeyLogging(LContext, GetString(line));
end;

{ TIdOpenSSLContext }

function TIdOpenSSLContext.AreOptionsUnchanged(
  const AOptions: TIdOpenSSLOptionsBase): Boolean;
begin
  Result := not Assigned(FOptions) or not FOptions.Equals(AOptions);
end;

destructor TIdOpenSSLContext.Destroy;
begin
  FOptions.Free();
  FreeContext(FContext);
  inherited;
end;

procedure TIdOpenSSLContext.FreeContext(const AContext: PSSL_CTX);
begin
  SSL_CTX_Free(AContext); // SSL_CTX_Free is nil-safe
end;

function TIdOpenSSLContext.Init(const AOptions: TIdOpenSSLOptionsBase): Boolean;
begin
  Result := True;
  if Assigned(FContext) and AreOptionsUnchanged(AOptions) then
    Exit;

  FreeContext(FContext);
  FContext := SSL_CTX_new(TLS_method());
//  FContext := SSL_CTX_new(TLS_method());
  if not Assigned(FContext) then
    EIdOpenSSLNewSSLCtxError.&Raise(RIdOpenSSLNewSSLCtxError);

  FOptions.Free();
  FOptions := AOptions.Clone() as TIdOpenSSLOptionsBase;

  InitContextWithStaticValues(FContext);

  SetCertificate(FContext, UTF8String(FOptions.CertFile), UTF8String(FOptions.CertKey));
  SetTLSVersions(FContext, FOptions.MinimumTLSVersion, FOptions.MaximumTLSVersion);
  SetVerifyLocations(FContext, UTF8String(FOptions.VerifyCertificate), UTF8String(FOptions.VerifyCertDirectory));
  SSL_CTX_set_verify(FContext, GetVerifyMode(FOptions), VerifyCallback);
//  SSL_CTX_set_verify(FContext, GetVerifyMode(FOptions), nil);
  SetCiphers(FContext, UTF8String(FOptions.CipherList), UTF8String(FOptions.CipherSuites), FOptions.UseServerCipherPreferences);
  SetKeylogCallback(FContext, FOptions.OnKeyLogging);
  SetLegacyOptions(FContext, FOptions.AllowUnsafeLegacyRenegotiation, FOptions.UseLegacyServerConnect);
end;

procedure TIdOpenSSLContext.InitContextWithStaticValues(
  const AContext: PSSL_CTX);
begin
  SSL_CTX_set_mode(AContext, SSL_MODE_AUTO_RETRY);
  SSL_CTX_set_default_verify_paths(AContext);
  SSL_CTX_set_session_cache_mode(AContext, SSL_SESS_CACHE_BOTH);
  SetExData(AContext, CExDataIndexSelf, Self);
//  SetExData(AContext, CExDataIndexOptions, FOptions);

//  SSL_CTX_set_verify_depth(AContext, -1);

  SSL_CTX_set_default_passwd_cb(AContext, GetPasswordCallback);
  SSL_CTX_set_default_passwd_cb_userdata(AContext, Pointer(Self));
end;

procedure TIdOpenSSLContext.SetCertificate(const AContext: PSSL_CTX;
  const ACertificateFile, APrivateKeyFile: UTF8String);
begin
  if (ACertificateFile = '') and (APrivateKeyFile = '') then
    Exit;

  if ACertificateFile <> '' then
//    if SSL_CTX_use_certificate_file(FContext, GetPAnsiChar(ACertificateFile), SSL_FILETYPE_PEM) <> 1 then
    if SSL_CTX_use_certificate_chain_file(AContext, GetPAnsiChar(ACertificateFile)) <> 1 then
      EIdOpenSSLSetCertificateError.&Raise();

  if APrivateKeyFile <> '' then
    if SSL_CTX_use_PrivateKey_file(AContext, GetPAnsiChar(APrivateKeyFile), SSL_FILETYPE_PEM) <> 1 then
      EIdOpenSSLSetPrivateKeyError.&Raise();

  if SSL_CTX_check_private_key(AContext) <> 1 then
    EIdOpenSSLCertAndPrivKeyMisMatchError.&Raise();
end;

procedure TIdOpenSSLContext.SetCiphers(
  const AContext: PSSL_CTX;
  const ACipherList: UTF8String;
  const ACipherSuites: UTF8String;
  const AUseServerCipherPreferences: Boolean);
begin
  if ACipherList <> '' then
    if SSL_CTX_set_cipher_list(AContext, GetPAnsiChar(ACipherList)) <> 1 then
      EIdOpenSSLSetCipherListError.&Raise(RIdOpenSSLSetCipherListError);
  if ACipherSuites <> '' then
    if SSL_CTX_set_ciphersuites(AContext, GetPAnsiChar(ACipherSuites)) <> 1 then
      EIdOpenSSLSetCipherSuiteError.&Raise(RIdOpenSSLSetCipherSuiteError);

  if AUseServerCipherPreferences then
    SSL_CTX_set_options(AContext, SSL_OP_CIPHER_SERVER_PREFERENCE)
  else
    SSL_CTX_clear_options(AContext, SSL_OP_CIPHER_SERVER_PREFERENCE);
end;

procedure TIdOpenSSLContext.SetExData(const AContext: PSSL_CTX; AIndex: Integer;
  const AObj: TObject);
begin
  if SSL_CTX_set_ex_data(AContext, AIndex, Pointer(AObj)) <> 1 then
    EIdOpenSSLSetExDataError.&Raise(RIdOpenSSLSetExDataError);
end;

procedure TIdOpenSSLContext.SetKeylogCallback(
  const AContext: PSSL_CTX;
  const ACallback: TKeyLog);
begin
  if Assigned(ACallback) then
    SSL_CTX_set_keylog_callback(AContext, KeylogCallback)
  else
    SSL_CTX_set_keylog_callback(AContext, nil);
end;

procedure TIdOpenSSLContext.SetLegacyOptions(
  const AContext: PSSL_CTX;
  const AAllowUnsafeLegacyRenegotiation: Boolean;
  const AUseLegacyServerConnect: Boolean);
begin
  if AAllowUnsafeLegacyRenegotiation then
    SSL_CTX_set_options(AContext, SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION)
  else
    SSL_CTX_clear_options(AContext, SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION);

  if AUseLegacyServerConnect then
    SSL_CTX_set_options(AContext, SSL_OP_LEGACY_SERVER_CONNECT)
  else
    SSL_CTX_clear_options(AContext, SSL_OP_LEGACY_SERVER_CONNECT);
end;

procedure TIdOpenSSLContext.SetTLSVersions(
  const AContext: PSSL_CTX;
  const AMinVersion: TIdOpenSSLVersion;
  const AMaxVersion: TIdOpenSSLVersion);
const
  CVersionConverter: array[TIdOpenSSLVersion] of TIdC_INT =
  (
    0,                //Undefined - 0 means autoconfiguration lowest (for min)
                      //            or highest (for max) by OpenSSL itselfs
    SSL3_VERSION,     //SSLv3
    TLS1_VERSION,     //TLSv1
    TLS1_1_VERSION,   //TLSv1_1
    TLS1_2_VERSION,   //TLSv1_2
    TLS1_3_VERSION    //TLSv1_3
  );
begin
  SSL_CTX_set_min_proto_version(AContext, CVersionConverter[AMinVersion]);
  SSL_CTX_set_max_proto_version(AContext, CVersionConverter[AMaxVersion]);
end;

procedure TIdOpenSSLContext.SetVerifyLocations(const AContext: PSSL_CTX;
  const AVerifyCertificate, AVerifyCertDirectory: UTF8String);
var
  LCert: PIdAnsiChar;
  LDir: PIdAnsiChar;
begin
  if not ((AVerifyCertificate = '') and (AVerifyCertDirectory = '')) then
  begin
    LCert := GetPAnsiCharOrNil(AVerifyCertificate);
    LDir := GetPAnsiCharOrNil(AVerifyCertDirectory);
    if SSL_CTX_load_verify_locations(AContext,
      LCert,
      LDir) = 0 then
    begin
      EIdOpenSSLSetVerifyLocationError.&Raise(RIdOpenSSLSetVerifyLocationError);
    end;
  end;
end;

end.