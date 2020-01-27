unit IdOpenSSLHeaders_ocsperr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// ocsperr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  (*
   * OCSP function codes.
   *)
  OCSP_F_D2I_OCSP_NONCE = 102;
  OCSP_F_OCSP_BASIC_ADD1_STATUS = 103;
  OCSP_F_OCSP_BASIC_SIGN = 104;
  OCSP_F_OCSP_BASIC_SIGN_CTX = 119;
  OCSP_F_OCSP_BASIC_VERIFY = 105;
  OCSP_F_OCSP_CERT_ID_NEW = 101;
  OCSP_F_OCSP_CHECK_DELEGATED = 106;
  OCSP_F_OCSP_CHECK_IDS = 107;
  OCSP_F_OCSP_CHECK_ISSUER = 108;
  OCSP_F_OCSP_CHECK_VALIDITY = 115;
  OCSP_F_OCSP_MATCH_ISSUERID = 109;
  OCSP_F_OCSP_PARSE_URL = 114;
  OCSP_F_OCSP_REQUEST_SIGN = 110;
  OCSP_F_OCSP_REQUEST_VERIFY = 116;
  OCSP_F_OCSP_RESPONSE_GET1_BASIC = 111;
  OCSP_F_PARSE_HTTP_LINE1 = 118;

  (*
   * OCSP reason codes.
   *)
  OCSP_R_CERTIFICATE_VERIFY_ERROR = 101;
  OCSP_R_DIGEST_ERR = 102;
  OCSP_R_ERROR_IN_NEXTUPDATE_FIELD = 122;
  OCSP_R_ERROR_IN_THISUPDATE_FIELD = 123;
  OCSP_R_ERROR_PARSING_URL = 121;
  OCSP_R_MISSING_OCSPSIGNING_USAGE = 103;
  OCSP_R_NEXTUPDATE_BEFORE_THISUPDATE = 124;
  OCSP_R_NOT_BASIC_RESPONSE = 104;
  OCSP_R_NO_CERTIFICATES_IN_CHAIN = 105;
  OCSP_R_NO_RESPONSE_DATA = 108;
  OCSP_R_NO_REVOKED_TIME = 109;
  OCSP_R_NO_SIGNER_KEY = 130;
  OCSP_R_PRIVATE_KEY_DOES_NOT_MATCH_CERTIFICATE = 110;
  OCSP_R_REQUEST_NOT_SIGNED = 128;
  OCSP_R_RESPONSE_CONTAINS_NO_REVOCATION_DATA = 111;
  OCSP_R_ROOT_CA_NOT_TRUSTED = 112;
  OCSP_R_SERVER_RESPONSE_ERROR = 114;
  OCSP_R_SERVER_RESPONSE_PARSE_ERROR = 115;
  OCSP_R_SIGNATURE_FAILURE = 117;
  OCSP_R_SIGNER_CERTIFICATE_NOT_FOUND = 118;
  OCSP_R_STATUS_EXPIRED = 125;
  OCSP_R_STATUS_NOT_YET_VALID = 126;
  OCSP_R_STATUS_TOO_OLD = 127;
  OCSP_R_UNKNOWN_MESSAGE_DIGEST = 119;
  OCSP_R_UNKNOWN_NID = 120;
  OCSP_R_UNSUPPORTED_REQUESTORNAME_TYPE = 129;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  ERR_load_OCSP_strings: function: TIdC_INT cdecl = nil;

implementation

uses
  System.Classes,
  Winapi.Windows;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := GetProcAddress(ADllHandle, PChar(AMethodName));
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

var
  LFailed: TStringList;
begin
  LFailed := TStringList.Create();
  try
    ERR_load_OCSP_strings := LoadFunction('ERR_load_OCSP_strings', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  ERR_load_OCSP_strings := nil;
end;
{$ENDREGION}

end.
