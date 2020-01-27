unit IdOpenSSLHeaders_async;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// async.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  ASYNC_ERR = 0;
  ASYNC_NO_JOBS = 0;
  ASYNC_PAUSE = 2;
  ASYNC_FINISH = 3;

type
  async_job_st = type Pointer;
  ASYNC_JOB = async_job_st;
  PASYNC_JOB = ^ASYNC_JOB;
  PPASYNC_JOB = ^PASYNC_JOB;
  
  async_wait_ctx_st = type Pointer;
  ASYNC_WAIT_CTX = async_wait_ctx_st;
  PASYNC_WAIT_CTX = ^ASYNC_WAIT_CTX;
  
  OSSL_ASYNC_FD = type TIdC_INT;
  POSSL_ASYNC_FD = ^OSSL_ASYNC_FD;

  ASYNC_WAIT_CTX_set_wait_fd_cleanup = procedure(v1: PASYNC_WAIT_CTX;
    const v2: Pointer; v3: OSSL_ASYNC_FD; v4: Pointer);
  ASYNC_start_job_cb = function(v1: Pointer): TIdC_INT;

  function ASYNC_init_thread(max_size: size_t; init_size: size_t): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  procedure ASYNC_cleanup_thread cdecl; external 'libcrypto-1_1.dll';

  function ASYNC_WAIT_CTX_new: PASYNC_WAIT_CTX cdecl; external 'libcrypto-1_1.dll';
  procedure ASYNC_WAIT_CTX_free(ctx: PASYNC_WAIT_CTX) cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_WAIT_CTX_set_wait_fd(ctx: PASYNC_WAIT_CTX; const key: Pointer; fd: OSSL_ASYNC_FD; custom_data: Pointer; cleanup_cb: ASYNC_WAIT_CTX_set_wait_fd_cleanup): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_WAIT_CTX_get_fd(ctx: PASYNC_WAIT_CTX; const key: Pointer; fd: POSSL_ASYNC_FD; custom_data: PPointer): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_WAIT_CTX_get_all_fds(ctx: PASYNC_WAIT_CTX; fd: POSSL_ASYNC_FD; numfds: PSize_t): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_WAIT_CTX_get_changed_fds(ctx: PASYNC_WAIT_CTX; addfd: POSSL_ASYNC_FD; numaddfds: PSize_t; delfd: POSSL_ASYNC_FD; numdelfds: PSize_t): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_WAIT_CTX_clear_fd(ctx: PASYNC_WAIT_CTX; const key: Pointer): TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function ASYNC_is_capable: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function ASYNC_start_job(job: PPASYNC_JOB; ctx: PASYNC_WAIT_CTX; ret: PIdC_INT; func: ASYNC_start_job_cb; args: Pointer; size: size_t): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_pause_job: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function ASYNC_get_current_job: PASYNC_JOB cdecl; external 'libcrypto-1_1.dll';
  function ASYNC_get_wait_ctx(job: PASYNC_JOB): PASYNC_WAIT_CTX cdecl; external 'libcrypto-1_1.dll';
  procedure ASYNC_block_pause cdecl; external 'libcrypto-1_1.dll';
  procedure ASYNC_unblock_pause cdecl; external 'libcrypto-1_1.dll';

implementation

end.
