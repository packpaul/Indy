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

unit IdOpenSSLOptions;

interface

uses
  Classes,
  IdOpenSSLTypes;

type
  TIdOpenSSLPersistent = class(TPersistent)
  public
    procedure AssignTo(Dest: TPersistent); override;
    function Clone: TIdOpenSSLPersistent; virtual;
  end;

  TIdOpenSSLOptionsBase = class(TIdOpenSSLPersistent)
  strict private const
    CDefaultMinumumTLSVersion = TIdOpenSSLVersion.TLSv1;
    CDefaultMaximumTLSVersion = TIdOpenSSLVersion.Undefined;
    CDefaultUseServerCipherPreferences = True;
    CDefaultAllowUnsafeLegacyRenegotiation = False;
    CDefaultUseLegacyServerConnect = False;
  private
    FCertFile: string;
    FCertKey: string;
    FVerifyCertificate: string;
    FVerifyCertDirectory: string;
    FMaximumTLSVersion: TIdOpenSSLVersion;
    FMinimumTLSVersion: TIdOpenSSLVersion;
    FCipherList: string;
    FOnGetPassword: TGetPassword;
    FOnKeyLogging: TKeyLog;
    FCipherSuites: string;
    FUseServerCipherPreferences: Boolean;
    FAllowUnsafeLegacyRenegotiation: Boolean;
    FUseLegacyServerConnect: Boolean;
  public
    constructor Create; virtual;
    procedure AssignTo(Dest: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;

    /// <summary>
    ///   Sets the OpenSSL Option SSL_OP_CIPHER_SERVER_PREFERENCE
    /// </summary>
    property UseServerCipherPreferences: Boolean read FUseServerCipherPreferences write FUseServerCipherPreferences;
    /// <summary>
    ///   Allow legacy insecure renegotiation between OpenSSL and unpatched
    ///   clients or servers. Affects CVE-2009-3555 & RFC5746.
    /// </summary>
    /// <remarks>
    ///   <para>See SECURE RENEGOTIATION for more information.</para>
    ///   <code>https://www.openssl.org/docs/man1.1.1/man3/SSL_CTX_set_options.html</code>
    /// </remarks>
    property AllowUnsafeLegacyRenegotiation: Boolean read FAllowUnsafeLegacyRenegotiation write FAllowUnsafeLegacyRenegotiation;
    /// <summary>
    ///   Allow legacy insecure renegotiation between OpenSSL and unpatched
    ///   servers only. Affects CVE-2009-3555 & RFC5746.
    /// </summary>
    /// <remarks>
    ///   <para>See SECURE RENEGOTIATION for more information.</para>
    ///   <code>https://www.openssl.org/docs/man1.1.1/man3/SSL_CTX_set_options.html</code>
    /// </remarks>
    property UseLegacyServerConnect: Boolean read FUseLegacyServerConnect write FUseLegacyServerConnect;
  published
    /// <remarks>
    ///   Expects a path to a certificate in PEM format
    /// </remarks>
    property CertFile: string read FCertFile write FCertFile;
    /// <remarks>
    ///   Expects a path to a private key in PEM format
    /// </remarks>
    property CertKey: string read FCertKey write FCertKey;
    property OnGetPassword: TGetPassword read FOnGetPassword write FOnGetPassword;

    /// <summary>
    ///   Path to a CA certificate in PEM format. The file can contain several
    ///   CA certificates.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///   The file can contain several CA certificates identified by this
    ///   sequences. Before, between, and after the certificates text is allowed
    ///   which can be used e.g. for descriptions of the certificates.
    ///   <code>
    ///   -----BEGIN CERTIFICATE-----
    ///   ... (CA certificate in base64 encoding) ...
    ///   -----END CERTIFICATE-----
    ///   </code>
    ///   </para>
    ///
    ///   <para>
    ///   When looking up CA certificates, the OpenSSL library will first search
    ///   the certificates in CAfile, then those in CApath.
    ///   </para>
    /// </remarks>
    property VerifyCertificate: string read FVerifyCertificate write FVerifyCertificate;
    /// <summary>
    ///   Path to a directory containing CA certificates in PEM format.
    ///   The files each contain one CA certificate.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///   When looking up CA certificates, the OpenSSL library will first search
    ///   the certificates in CAfile, then those in <see cref="VerifyCertificate"/>.
    ///   </para>
    ///
    ///   <para>
    ///   Each name of a certificate file have to be in the "hash format" (the
    ///   name has to be like hash.0). For more information, please look at
    ///   OpenSSL documentation about "openssl verify -CApath" and
    ///   "openssl x509 -hash". In order to get the hash you could call:
    ///   <code>openssl x509 -hash -noout -in MyCA.pem</code>
    ///   </para>
    /// </remarks>
    property VerifyCertDirectory: string read FVerifyCertDirectory write FVerifyCertDirectory;

    /// <summary>
    ///   Minimum allowed TLS version. For letting OpenSSL automagic choosing
    ///   the lowest possible version use:
    ///   <code>TIdOpenSSLVersion.Undefined</code>
    /// </summary>
    property MinimumTLSVersion: TIdOpenSSLVersion read FMinimumTLSVersion write FMinimumTLSVersion default CDefaultMinumumTLSVersion;
    /// <summary>
    ///   Maximum allowed TLS version. For letting OpenSSL automagic choosing
    ///   the highest possible version use:
    ///   <code>TIdOpenSSLVersion.Undefined</code>
    /// </summary>
    property MaximumTLSVersion: TIdOpenSSLVersion read FMaximumTLSVersion write FMaximumTLSVersion default CDefaultMaximumTLSVersion;
    /// <summary>
    ///   <para>Sets the list of available ciphers. Only used for TLSv1.2 and below.</para>
    ///   <para>For TLSv1.3 use <see cref="CipherSuites"/>.</para>
    /// </summary>
    /// <remarks>
    ///   The format of the string is described in
    ///   <code>https://www.openssl.org/docs/man1.1.1/man1/ciphers.html</code>
    /// </remarks>
    property CipherList: string read FCipherList write FCipherList;
    /// <summary>
    ///   <para>Sets the list of available ciphersuites. Only used for TLSv1.3.</para>
    ///   <para>For TLSv1.2 and lower use <see cref="CipherList"/>.</para>
    /// </summary>
    /// <remarks>
    ///   This is a simple colon (":") separated list of TLSv1.3 ciphersuite
    ///   names in order of preference.
    /// </remarks>
    property CipherSuites: string read FCipherSuites write FCipherSuites;

    /// <summary>
    ///  <para>
    ///   !!! ONLY FOR DEBUGGING, be careful with productive code !!!
    ///  </para>
    ///  <para>
    ///   This callback is called whenever TLS key material is generated or
    ///   received, in order to allow applications to store this keying material
    ///   for debugging purposes.
    ///  </para>
    ///  <para>
    ///   Save every line into a text file, in wireshark set "(para-)Master
    ///   Secret log filename" to that text file. Now wireshark can unencrypt
    ///   all encrypted messages.
    ///   <code>Wireshark: Edit/preferences/Protocols/SSL/(para-)Master Secret log filename</code>
    ///  </para>
    ///  <para>
    ///  OpenSSL follows the format from NSS:
    ///  <code>https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/Key_Log_Format</code>
    ///  </para>
    /// </summary>
    /// <remarks>
    ///   !!! ONLY FOR DEBUGGING, be careful with productive code !!!
    /// </remarks>
    property OnKeyLogging: TKeyLog read FOnKeyLogging write FOnKeyLogging;
  end;

  TIdOpenSSLOptionsClass = class of TIdOpenSSLOptionsBase;

implementation

{ TIdOpenSSLOptionsBase }

procedure TIdOpenSSLOptionsBase.AssignTo(Dest: TPersistent);
var
  LDest: TIdOpenSSLOptionsBase;
begin
  inherited;
  if Dest is TIdOpenSSLOptionsBase then
  begin
    LDest := TIdOpenSSLOptionsBase(Dest);
    LDest.FCertFile := FCertFile;
    LDest.FCertKey := FCertKey;
    LDest.FVerifyCertificate := FVerifyCertificate;
    LDest.FVerifyCertDirectory := FVerifyCertDirectory;
    LDest.FMinimumTLSVersion := FMinimumTLSVersion;
    LDest.FMaximumTLSVersion := FMaximumTLSVersion;
    LDest.FCipherList := FCipherList;
    LDest.FOnGetPassword := FOnGetPassword;
    LDest.FOnKeyLogging := FOnKeyLogging;
  end
end;

constructor TIdOpenSSLOptionsBase.Create;
begin
  inherited;
  FMinimumTLSVersion := CDefaultMinumumTLSVersion;
  FMaximumTLSVersion := CDefaultMaximumTLSVersion;
  FUseServerCipherPreferences := CDefaultUseServerCipherPreferences;
  FAllowUnsafeLegacyRenegotiation := CDefaultAllowUnsafeLegacyRenegotiation;
  FUseLegacyServerConnect := CDefaultUseLegacyServerConnect;
end;

function TIdOpenSSLOptionsBase.Equals(Obj: TObject): Boolean;
var
  LObj: TIdOpenSSLOptionsBase;
begin
  inherited;
  Result := Obj is TIdOpenSSLOptionsBase;
  if Result then
  begin
    LObj := TIdOpenSSLOptionsBase(Obj);
    Result := (FCertFile = LObj.FCertFile)
      and (FCertKey = LObj.FCertKey)
      and (FVerifyCertificate = LObj.FVerifyCertificate)
      and (FVerifyCertDirectory = LObj.FVerifyCertDirectory)
      and (FMinimumTLSVersion = LObj.FMinimumTLSVersion)
      and (FMaximumTLSVersion = LObj.FMaximumTLSVersion)
      and (FCipherList = LObj.FCipherList)
      and (@FOnGetPassword = @LObj.FOnGetPassword)
      and (@FOnKeyLogging = @LObj.FOnKeyLogging);
  end;
end;

{ TIdOpenSSLPersistent }

procedure TIdOpenSSLPersistent.AssignTo(Dest: TPersistent);
begin
  if not (Dest is TIdOpenSSLPersistent) then
    inherited;
end;

function TIdOpenSSLPersistent.Clone: TIdOpenSSLPersistent;
begin
  Result := TIdOpenSSLOptionsClass(Self.ClassType).Create();
  AssignTo(Result);
end;

end.