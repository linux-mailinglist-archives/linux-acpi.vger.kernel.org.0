Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A671B301649
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Jan 2021 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhAWPV6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Jan 2021 10:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAWPVr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Jan 2021 10:21:47 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59733C06174A
        for <linux-acpi@vger.kernel.org>; Sat, 23 Jan 2021 07:21:07 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 63so8226162oty.0
        for <linux-acpi@vger.kernel.org>; Sat, 23 Jan 2021 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IFEonFlUnXpmuql+U3yp//U01zlY9B5kalZh5nWlTss=;
        b=m6Jtr26cOPUD53MbSHM4SsjTP2rRF2gdffRLieRkR9NwbcMmbkxvi+HsiIKxik3TbC
         QnLJNnF5doGSQ+U6hLM+AHv6Z20gzIiiDc9cOCv5FhJJkPfn7aqyMGuq6ZbYDi2n33kv
         KDO2BYlHY6jcbgapD1CgIuHq/CoW5aQ545kmSiPt6o1MQ8TRq80nEA9RNrmLD0xLzxF2
         35M2eAkZ7+UvrHhiUyMt/NjW3572MvH+yNJdDmGuNm7ubX6Eo9o20vj0StV/BCP3rh+E
         Nt9mezuUrEBsFhwjH6Q/sgzQLzuoIi7sTs9bfdRUlk1kspp+fH2koiuItZaUFiskgWEb
         2s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IFEonFlUnXpmuql+U3yp//U01zlY9B5kalZh5nWlTss=;
        b=I7g/4o2FV0mNO6QJQGkTgGvH3BeNguVbFAfoGw8Uyp6mPKrZmYRWPPoaTFwsZYMLQN
         4b+OKgCxm8pu5ashlpg/wgNhV1Xtfh96q8lEAVtkpYHQ223WlfOIWZ6JOGGVps9XkXBP
         +oYmX/2FJxH4ZLGWAYW+G1M9uvsNBAf/wkwzXv3+M9WRtRrf9hWsOvuUiW2MSLwy7ELX
         9+dG5+VwoaoSJrCjTx/YR/WW3xeDSQU+lhn0Odlf13JzO/MjH9azSOhmsXtqCwRLbxZh
         VV0IDZ/C+aiPDlYcAWt05Y5IT3z5zbG0vRvd5TB+tT0omoSg2fM+XC77qRKLGRAYR/Di
         WwUw==
X-Gm-Message-State: AOAM533BLZnvcIld6sDYMAOE2i1S6WxF+rl+LCAyWW8ehz21r5Jx9/Ud
        ufXurP/uQTqhPPsnbt5pSVI=
X-Google-Smtp-Source: ABdhPJwUPHI2ETwgDnXtl8uAh38zmRjsBScNzoD+5v6tuZaksXdsaLYLW0LcSfGy0XWzPyNwwN3rKg==
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr7022036otr.96.1611415266652;
        Sat, 23 Jan 2021 07:21:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j14sm2152552ots.71.2021.01.23.07.21.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jan 2021 07:21:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jan 2021 07:21:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [v2,3/9] ACPICA: ACPICA: fix -Wfallthrough
Message-ID: <20210123152104.GA36465@roeck-us.net>
References: <20210122002357.370836-4-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210122002357.370836-4-erik.kaneda@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 21, 2021 at 04:23:51PM -0800, Erik Kaneda wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> ACPICA commit 4b9135f5774caa796ddf826448811e8e7f08ef2f
> 
> GCC 7.1 gained -Wimplicit-fallthrough to warn on implicit fallthrough,
> as well as __attribute__((__fallthrough__)) and comments to explicitly
> denote that cases of fallthrough were intentional. Clang also supports
> this warning and statement attribute, but not the comment form.
> 
> Robert Moore provides additional context about the lint comments being
> removed. They were for "an old version of PC-Lint, which we don't use
> anymore." Drop those.
> 
> This will help us enable -Wimplicit-fallthrough throughout the Linux
> kernel.
> 
> Suggested-by: Robert Moore <robert.moore@intel.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Link: https://github.com/acpica/acpica/commit/4b9135f5
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>

With gcc 6.5 (and presumably each gcc version older than 7.1),
this patch results in:

drivers/acpi/acpica/dscontrol.c: In function ‘acpi_ds_exec_begin_control_op’:
drivers/acpi/acpica/dscontrol.c:65:3: error: ‘ACPI_FALLTHROUGH’ undeclared

and similar errors for other files.

Guenter

> ---
>  drivers/acpi/acpica/dscontrol.c |  2 +-
>  drivers/acpi/acpica/dswexec.c   |  3 +--
>  drivers/acpi/acpica/dswload.c   |  2 +-
>  drivers/acpi/acpica/dswload2.c  |  2 +-
>  drivers/acpi/acpica/exfldio.c   |  2 +-
>  drivers/acpi/acpica/exresop.c   |  4 ++--
>  drivers/acpi/acpica/exstore.c   |  4 ++--
>  drivers/acpi/acpica/hwgpe.c     |  2 +-
>  drivers/acpi/acpica/utdelete.c  |  2 +-
>  include/acpi/actypes.h          |  6 ++++++
>  include/acpi/platform/acgcc.h   | 15 +++++++++++++++
>  11 files changed, 32 insertions(+), 12 deletions(-)
> 
> -- 
> 2.29.2
> 
> diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
> index 4b5b6e859f62..b58ffc7acdb9 100644
> --- a/drivers/acpi/acpica/dscontrol.c
> +++ b/drivers/acpi/acpica/dscontrol.c
> @@ -62,7 +62,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
>  			}
>  		}
>  
> -		/*lint -fallthrough */
> +		ACPI_FALLTHROUGH;
>  
>  	case AML_IF_OP:
>  		/*
> diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
> index 1d4f8c81028c..4a9799246fae 100644
> --- a/drivers/acpi/acpica/dswexec.c
> +++ b/drivers/acpi/acpica/dswexec.c
> @@ -598,8 +598,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
>  					break;
>  				}
>  
> -				/* Fall through */
> -				/*lint -fallthrough */
> +				ACPI_FALLTHROUGH;
>  
>  			case AML_INT_EVAL_SUBTREE_OP:
>  
> diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
> index 27069325b6de..dd97c86f8e41 100644
> --- a/drivers/acpi/acpica/dswload.c
> +++ b/drivers/acpi/acpica/dswload.c
> @@ -224,7 +224,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
>  				break;
>  			}
>  
> -			/*lint -fallthrough */
> +			ACPI_FALLTHROUGH;
>  
>  		default:
>  
> diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
> index edadbe146506..d9a3dfca7555 100644
> --- a/drivers/acpi/acpica/dswload2.c
> +++ b/drivers/acpi/acpica/dswload2.c
> @@ -214,7 +214,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
>  				break;
>  			}
>  
> -			/*lint -fallthrough */
> +			ACPI_FALLTHROUGH;
>  
>  		default:
>  
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
> index ade35ff1c7ba..cde24e0fa6a8 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -434,7 +434,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
>  		 * region_field case and write the datum to the Operation Region
>  		 */
>  
> -		/*lint -fallthrough */
> +		ACPI_FALLTHROUGH;
>  
>  	case ACPI_TYPE_LOCAL_REGION_FIELD:
>  		/*
> diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
> index 4d1b22971d58..4a0f8b8bfe62 100644
> --- a/drivers/acpi/acpica/exresop.c
> +++ b/drivers/acpi/acpica/exresop.c
> @@ -198,7 +198,7 @@ acpi_ex_resolve_operands(u16 opcode,
>  
>  					target_op = AML_DEBUG_OP;
>  
> -					/*lint -fallthrough */
> +					ACPI_FALLTHROUGH;
>  
>  				case ACPI_REFCLASS_ARG:
>  				case ACPI_REFCLASS_LOCAL:
> @@ -264,7 +264,7 @@ acpi_ex_resolve_operands(u16 opcode,
>  			 * Else not a string - fall through to the normal Reference
>  			 * case below
>  			 */
> -			/*lint -fallthrough */
> +			ACPI_FALLTHROUGH;
>  
>  		case ARGI_REFERENCE:	/* References: */
>  		case ARGI_INTEGER_REF:
> diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
> index 3adc0a29d890..8fe33051275d 100644
> --- a/drivers/acpi/acpica/exstore.c
> +++ b/drivers/acpi/acpica/exstore.c
> @@ -96,7 +96,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
>  			return_ACPI_STATUS(AE_OK);
>  		}
>  
> -		/*lint -fallthrough */
> +		ACPI_FALLTHROUGH;
>  
>  	default:
>  
> @@ -422,7 +422,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
>  				break;
>  			}
>  
> -			/* Fallthrough */
> +			ACPI_FALLTHROUGH;
>  
>  		case ACPI_TYPE_DEVICE:
>  		case ACPI_TYPE_EVENT:
> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> index b13a4ed5bc63..0c84300e915c 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -167,7 +167,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
>  			return (AE_BAD_PARAMETER);
>  		}
>  
> -		/*lint -fallthrough */
> +		ACPI_FALLTHROUGH;
>  
>  	case ACPI_GPE_ENABLE:
>  
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> index 4c0d4e434196..624a26794d55 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -112,7 +112,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
>  						       gpe_block);
>  		}
>  
> -		/*lint -fallthrough */
> +		ACPI_FALLTHROUGH;
>  
>  	case ACPI_TYPE_PROCESSOR:
>  	case ACPI_TYPE_THERMAL:
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 647cb11d0a0a..2a32593691bc 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1286,4 +1286,10 @@ typedef enum {
>  
>  #define ACPI_OPT_END                    -1
>  
> +/* Definitions for explicit fallthrough */
> +
> +#ifndef ACPI_FALLTHROUGH
> +#define ACPI_FALLTHROUGH do {} while(0)
> +#endif
> +
>  #endif				/* __ACTYPES_H__ */
> diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
> index 7d63d03cf507..91f7a02c798a 100644
> --- a/include/acpi/platform/acgcc.h
> +++ b/include/acpi/platform/acgcc.h
> @@ -54,4 +54,19 @@ typedef __builtin_va_list va_list;
>  
>  #define ACPI_USE_NATIVE_MATH64
>  
> +/* GCC did not support __has_attribute until 5.1. */
> +
> +#ifndef __has_attribute
> +#define __has_attribute(x) 0
> +#endif
> +
> +/*
> + * Explictly mark intentional explicit fallthrough to silence
> + * -Wimplicit-fallthrough in GCC 7.1+.
> + */
> +
> +#if __has_attribute(__fallthrough__)
> +#define ACPI_FALLTHROUGH __attribute__((__fallthrough__))
> +#endif
> +
>  #endif				/* __ACGCC_H__ */
