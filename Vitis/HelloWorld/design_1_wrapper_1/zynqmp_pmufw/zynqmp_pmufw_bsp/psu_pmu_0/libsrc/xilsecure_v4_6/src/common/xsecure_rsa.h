/******************************************************************************
* Copyright (c) 2014 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
*******************************************************************************/

/*****************************************************************************/
/**
*
* @file xsecure_rsa.h
* @addtogroup xsecure_rsa_common_apis XilSecure RSA Common APIs
* @{
* @cond xsecure_internal
* This file contains hardware interface related information for RSA device
*
* This driver supports the following features:
*
* - RSA 4096 based encryption or decryption
* - verification/authentication of decrypted data
*
* <b>Initialization & Configuration</b>
*
* The Rsa driver instance can be initialized
* in the following way:
*
*   - XSecure_RsaInitialize(XSecure_Rsa *InstancePtr, u8* EncText,
*				u8 *Mod, u8 *ModExt, u8 *ModExpo)
*
* The method used for RSA decryption needs precalculated value off R^2 mod N
* which is generated by bootgen and is present in the signature along with
* modulus and exponent.
*
* @note
*	-The format of the public key (modulus, exponent and precalculated
*	 R^2 mod N should be same as specified by the bootgen
*
*	-For matching, PKCS paddding scheme has to be applied in the manner
*	 specified by the bootgen.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date        Changes
* ----- ---- -------- -------------------------------------------------------
* 1.0   ba   10/10/14 Initial release
* 2.2   vns  07/06/17 Added doxygen tags
*       vns  17/08/17 Added APIs XSecure_RsaPublicEncrypt and
*                     XSecure_RsaPrivateDecrypt.As per functionality
*                     XSecure_RsaPublicEncrypt is same as XSecure_RsaDecrypt.
* 3.1   vns  11/04/18 Added support for 512, 576, 704, 768, 992, 1024, 1152,
*                     1408, 1536, 1984, 3072 key sizes, where previous verision
*                     has support only 2048 and 4096 key sizes.
* 3.2   vns  04/30/18 Added error code XSECURE_RSA_DATA_VALUE_ERROR
* 4.0 	arc  18/12/18 Fixed MISRA-C violations.
*       vns  03/12/19 Modified as part of XilSecure code re-arch.
*                     Moved all macro definitions and instance structure to
*                     xsecure_rsa_core.h
* 4.2   har  11/07/19 Typo correction to enable compilation in C++
*       kpt  01/07/20 Added Macros for Magic Numbers in xsecure_rsa.c
*       rpo  09/10/20 Added error code
* 4.3   am   09/24/20 Resolved MISRA C violations
*       har  10/12/20 Addressed security review comments
*       ana  10/15/20 Updated doxygen tags
* 4.6   har  07/14/21 Fixed doxygen warnings
*       gm   07/16/21 Added APIs to support 64-bit address
*
* </pre>
*
* @endcond
******************************************************************************/

#ifndef XSECURE_RSA_H_
#define XSECURE_RSA_H_

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xsecure_rsa_core.h"

/************************** Constant Definitions ****************************/
#define XSECURE_RSA_BYTE_PAD_LENGTH	(3U)  /**< PKCS Byte Padding */
#define XSECURE_RSA_T_PAD_LENGTH	(19U) /**< PKCS T Padding */
#define XSECURE_RSA_BYTE_PAD1		(0X00U) /**<PKCS T Padding Byte */
#define XSECURE_RSA_BYTE_PAD2		(0X01U) /**<PKCS T Padding Byte */
#define XSECURE_RSA_BYTE_PAD3		(0XFFU)	/**<PKCS T Padding Byte */

/**
 * @name  RSA error codes
 * @{
 */
/**< Error Codes */
#define XSECURE_RSA_INVALID_PARAM	 (0x82U)
#define XSECURE_RSA_STATE_MISMATCH_ERROR (0x84U)
/** @} */

/***************************** Type Definitions ******************************/

/***************************** Function Prototypes ***************************/

/* Initialization */
int XSecure_RsaInitialize(XSecure_Rsa *InstancePtr, u8 *Mod, u8 *ModExt,
	u8 *ModExpo);
int XSecure_RsaInitialize_64Bit(XSecure_Rsa *InstancePtr, u64 Mod, u64 ModExt,
	u64 ModExpo);

/* RSA Signature Validation, assuming PKCS padding */
int XSecure_RsaSignVerification(const u8 *Signature, const u8 *Hash,
	u32 HashLen);
int XSecure_RsaSignVerification_64Bit(const u64 Signature, const u64 Hash,
	u32 HashLen);

/* RSA Public Encrypt operation */
int XSecure_RsaPublicEncrypt(XSecure_Rsa *InstancePtr, u8 *Input,
	u32 Size, u8 *Result);
int XSecure_RsaPublicEncrypt_64Bit(XSecure_Rsa *InstancePtr, u64 Input,
	u32 Size, u64 Result);

/* RSA Private Decryption operation */
int XSecure_RsaPrivateDecrypt(XSecure_Rsa *InstancePtr, u8 *Input,
	u32 Size, u8 *Result);
int XSecure_RsaPrivateDecrypt_64Bit(XSecure_Rsa *InstancePtr, u64 Input,
	u32 Size, u64 Result);

#ifdef __cplusplus
}
#endif

#endif /* XSECURE_RSA_H_ */
/* @} */