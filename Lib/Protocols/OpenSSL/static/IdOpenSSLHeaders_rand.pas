unit IdOpenSSLHeaders_rand;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// rand.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLHeaders_ossl_typ;

type
  rand_meth_st_seed = function (const buf: Pointer; num: TIdC_INT): TIdC_INT; cdecl;
  rand_meth_st_bytes = function (buf: PByte; num: TIdC_INT): TIdC_INT; cdecl;
  rand_meth_st_cleanup = procedure; cdecl;
  rand_meth_st_add = function (const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE): TIdC_INT; cdecl;
  rand_meth_st_pseudorand = function (buf: PByte; num: TIdC_INT): TIdC_INT; cdecl;
  rand_meth_st_status = function: TIdC_INT; cdecl;

  rand_meth_st = class
    seed: rand_meth_st_seed;
    bytes: rand_meth_st_bytes;
    cleanup: rand_meth_st_cleanup;
    add: rand_meth_st_add;
    pseudorand: rand_meth_st_pseudorand;
    status: rand_meth_st_status;
  end;

  function RAND_set_rand_method(const meth: PRAND_METHOD): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function RAND_get_rand_method: PRAND_METHOD cdecl; external 'libcrypto-1_1.dll';
  function RAND_set_rand_engine(engine: PENGINE): TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function RAND_OpenSSL: PRAND_METHOD cdecl; external 'libcrypto-1_1.dll';

  function RAND_bytes(buf: PByte; num: TIdC_INT): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function RAND_priv_bytes(buf: PByte; num: TIdC_INT): TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  procedure RAND_seed(const buf: Pointer; num: TIdC_INT) cdecl; external 'libcrypto-1_1.dll';
  procedure RAND_keep_random_devices_open(keep: TIdC_INT) cdecl; external 'libcrypto-1_1.dll';

  procedure RAND_add(const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE) cdecl; external 'libcrypto-1_1.dll';
  function RAND_load_file(const &file: PIdAnsiChar; max_bytes: TIdC_LONG): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function RAND_write_file(const &file: PIdAnsiChar): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function RAND_status: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function RAND_query_egd_bytes(const path: PIdAnsiChar; buf: PByte; bytes: TIdC_INT): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function RAND_egd(const path: PIdAnsiChar): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function RAND_egd_bytes(const path: PIdAnsiChar; bytes: TIdC_INT): TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function RAND_poll: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

implementation

end.
