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

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 31.03.2020 10:11:56

unit IdOpenSSLHeaders_conf_api;

interface

// Headers for OpenSSL 1.1.1
// conf_api.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdOpenSSLHeaders_conf;

  //* Up until OpenSSL 0.9.5a, this was new_section */
  function _CONF_new_section(conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl; external 'libcrypto-1_1.dll';
  //* Up until OpenSSL 0.9.5a, this was get_section */
  function _CONF_get_section(const conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl; external 'libcrypto-1_1.dll';
  //* Up until OpenSSL 0.9.5a, this was CONF_get_section */
  //STACK_OF(CONF_VALUE) *_CONF_get_section_values(const CONF *conf,
  //                                               const char *section);

  function _CONF_add_string(conf: PCONF; section: PCONF_VALUE; value: PCONF_VALUE): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function _CONF_get_string(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): PAnsiChar cdecl; external 'libcrypto-1_1.dll';
  function _CONF_get_number(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): TIdC_LONG cdecl; external 'libcrypto-1_1.dll';

  function _CONF_new_data(conf: PCONF): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  procedure _CONF_free_data(conf: PCONF) cdecl; external 'libcrypto-1_1.dll';


implementation

end.