unit IdOpenSSLHeaders_asyncerr;

interface

// Headers for OpenSSL 1.1.1
// asyncerr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  //
  // ASYNC function codes.
  //
  ASYNC_F_ASYNC_CTX_NEW                            = 100;
  ASYNC_F_ASYNC_INIT_THREAD                        = 101;
  ASYNC_F_ASYNC_JOB_NEW                            = 102;
  ASYNC_F_ASYNC_PAUSE_JOB                          = 103;
  ASYNC_F_ASYNC_START_FUNC                         = 104;
  ASYNC_F_ASYNC_START_JOB                          = 105;
  ASYNC_F_ASYNC_WAIT_CTX_SET_WAIT_FD               = 106;

  //
  // ASYNC reason codes.
  //
  ASYNC_R_FAILED_TO_SET_POOL                       = 101;
  ASYNC_R_FAILED_TO_SWAP_CONTEXT                   = 102;
  ASYNC_R_INIT_FAILED                              = 105;
  ASYNC_R_INVALID_POOL_SIZE                        = 103;

var
  function ERR_load_ASYNC_strings: TIdC_INT;

implementation

end.
