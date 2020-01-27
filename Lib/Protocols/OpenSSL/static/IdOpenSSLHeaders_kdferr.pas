unit IdOpenSSLHeaders_kdferr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// kdferr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  (*
   * KDF function codes.
   *)
  KDF_F_PKEY_HKDF_CTRL_STR = 103;
  KDF_F_PKEY_HKDF_DERIVE = 102;
  KDF_F_PKEY_HKDF_INIT = 108;
  KDF_F_PKEY_SCRYPT_CTRL_STR = 104;
  KDF_F_PKEY_SCRYPT_CTRL_UINT64 = 105;
  KDF_F_PKEY_SCRYPT_DERIVE = 109;
  KDF_F_PKEY_SCRYPT_INIT = 106;
  KDF_F_PKEY_SCRYPT_SET_MEMBUF = 107;
  KDF_F_PKEY_TLS1_PRF_CTRL_STR = 100;
  KDF_F_PKEY_TLS1_PRF_DERIVE = 101;
  KDF_F_PKEY_TLS1_PRF_INIT = 110;
  KDF_F_TLS1_PRF_ALG = 111;

  (*
   * KDF reason codes.
   *)
  KDF_R_INVALID_DIGEST = 100;
  KDF_R_MISSING_ITERATION_COUNT = 109;
  KDF_R_MISSING_KEY = 104;
  KDF_R_MISSING_MESSAGE_DIGEST = 105;
  KDF_R_MISSING_PARAMETER = 101;
  KDF_R_MISSING_PASS = 110;
  KDF_R_MISSING_SALT = 111;
  KDF_R_MISSING_SECRET = 107;
  KDF_R_MISSING_SEED = 106;
  KDF_R_UNKNOWN_PARAMETER_TYPE = 103;
  KDF_R_VALUE_ERROR = 108;
  KDF_R_VALUE_MISSING = 102;

  function ERR_load_KDF_strings: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

implementation

end.
