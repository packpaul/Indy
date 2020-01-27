unit IdOpenSSLHeaders_cryptoerr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// cryptoerr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  (*
   * CRYPTO function codes.
   *)
  CRYPTO_F_CMAC_CTX_NEW = 120;
  CRYPTO_F_CRYPTO_DUP_EX_DATA = 110;
  CRYPTO_F_CRYPTO_FREE_EX_DATA = 111;
  CRYPTO_F_CRYPTO_GET_EX_NEW_INDEX = 100;
  CRYPTO_F_CRYPTO_MEMDUP = 115;
  CRYPTO_F_CRYPTO_NEW_EX_DATA = 112;
  CRYPTO_F_CRYPTO_OCB128_COPY_CTX = 121;
  CRYPTO_F_CRYPTO_OCB128_INIT = 122;
  CRYPTO_F_CRYPTO_SET_EX_DATA = 102;
  CRYPTO_F_FIPS_MODE_SET = 109;
  CRYPTO_F_GET_AND_LOCK = 113;
  CRYPTO_F_OPENSSL_ATEXIT = 114;
  CRYPTO_F_OPENSSL_BUF2HEXSTR = 117;
  CRYPTO_F_OPENSSL_FOPEN = 119;
  CRYPTO_F_OPENSSL_HEXSTR2BUF = 118;
  CRYPTO_F_OPENSSL_INIT_CRYPTO = 116;
  CRYPTO_F_OPENSSL_LH_NEW = 126;
  CRYPTO_F_OPENSSL_SK_DEEP_COPY = 127;
  CRYPTO_F_OPENSSL_SK_DUP = 128;
  CRYPTO_F_PKEY_HMAC_INIT = 123;
  CRYPTO_F_PKEY_POLY1305_INIT = 124;
  CRYPTO_F_PKEY_SIPHASH_INIT = 125;
  CRYPTO_F_SK_RESERVE = 129;

  (*
   * CRYPTO reason codes.
   *)
  CRYPTO_R_FIPS_MODE_NOT_SUPPORTED = 101;
  CRYPTO_R_ILLEGAL_HEX_DIGIT = 102;
  CRYPTO_R_ODD_NUMBER_OF_DIGITS = 103;

  function ERR_load_CRYPTO_strings: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

implementation

end.
