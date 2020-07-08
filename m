Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21B021855B
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jul 2020 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgGHK67 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Jul 2020 06:58:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40101 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgGHK66 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2020 06:58:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id t198so24894926oie.7;
        Wed, 08 Jul 2020 03:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma9ZJcX3rCASQ1Yers2il4SNeWPyd7g9t6DtIKiBr1U=;
        b=GY9W55B3Lzigq85v1lQaLfiZoUkTh6A6PXNRhZPKSntqCL78wY9Rr8zgswLF3u4k3+
         6ugLk58XUtoFFnEcMcwrOie7JBRIdVBOb0Vk3scSdwf8Dq9J8Cf7BSuxc+Iv3/JXqBzv
         oLeQ2IHrp4MGo43MkKIhcqXgUa7uikyAk04Pwd0GiOAh1+Zk+ZVpjzdo31us5a5T+gWe
         PoNVOTjmBXax3eWN0H0fHmJ0p4HKqbkuBMByFwPmMnZ9BZd2RC4c7X/+ie+Zy8k7bqV8
         DU3bqU9ND0cmqSzh/YPX1lRMwh9eA1q1XUS/ahRyDHEceBar82QqWGmCnBSedPERAoha
         EDZg==
X-Gm-Message-State: AOAM530NNkULF2X8HexBJcch2wKnQANOxeTpwZV+7F4WvaiACvTMiXEM
        w1TZnwaAkQyJBD4FkcxTpKxxSUF9LaFYATu4nR8=
X-Google-Smtp-Source: ABdhPJwEGUtyHaA88w/taqZov0miWMOkIlHqWfppH2+c5Ch8dK/EmDEKEBRA2C7pZBmW1k372KAZdtwcc6/iforzXjA=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr6405827oih.68.1594205936617;
 Wed, 08 Jul 2020 03:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200707200716.GA4920@embeddedor>
In-Reply-To: <20200707200716.GA4920@embeddedor>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jul 2020 12:58:44 +0200
Message-ID: <CAJZ5v0iDz_EsrpdMQQDfaVC2orMQkEcubmR6-J6mvtrXmKXbRg@mail.gmail.com>
Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 7, 2020 at 10:01 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I need to talk to Erik and Bob about this one.

> ---
>  drivers/acpi/acpica/dscontrol.c |    2 +-
>  drivers/acpi/acpica/dswexec.c   |    3 +--
>  drivers/acpi/acpica/dswload.c   |    2 +-
>  drivers/acpi/acpica/dswload2.c  |    4 +---
>  drivers/acpi/acpica/exfldio.c   |    2 +-
>  drivers/acpi/acpica/exresop.c   |    4 ++--
>  drivers/acpi/acpica/exstore.c   |    4 ++--
>  drivers/acpi/acpica/hwgpe.c     |    3 +--
>  drivers/acpi/acpica/utdelete.c  |    3 +--
>  drivers/acpi/acpica/utprint.c   |    2 +-
>  10 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
> index 4b5b6e859f62..134d53380663 100644
> --- a/drivers/acpi/acpica/dscontrol.c
> +++ b/drivers/acpi/acpica/dscontrol.c
> @@ -62,7 +62,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
>                         }
>                 }
>
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case AML_IF_OP:
>                 /*
> diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
> index 1d4f8c81028c..41f6cb61778a 100644
> --- a/drivers/acpi/acpica/dswexec.c
> +++ b/drivers/acpi/acpica/dswexec.c
> @@ -598,8 +598,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
>                                         break;
>                                 }
>
> -                               /* Fall through */
> -                               /*lint -fallthrough */
> +                               fallthrough;
>
>                         case AML_INT_EVAL_SUBTREE_OP:
>
> diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
> index 27069325b6de..1d8789869dda 100644
> --- a/drivers/acpi/acpica/dswload.c
> +++ b/drivers/acpi/acpica/dswload.c
> @@ -224,7 +224,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
>                                 break;
>                         }
>
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 default:
>
> diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
> index edadbe146506..de367e8e4cf4 100644
> --- a/drivers/acpi/acpica/dswload2.c
> +++ b/drivers/acpi/acpica/dswload2.c
> @@ -213,9 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
>                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
>                                 break;
>                         }
> -
> -                       /*lint -fallthrough */
> -
> +                       fallthrough;
>                 default:
>
>                         /* All other types are an error */
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
> index ade35ff1c7ba..677ba3ab1482 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -434,7 +434,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
>                  * region_field case and write the datum to the Operation Region
>                  */
>
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_TYPE_LOCAL_REGION_FIELD:
>                 /*
> diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
> index 4d1b22971d58..7c8676adcf43 100644
> --- a/drivers/acpi/acpica/exresop.c
> +++ b/drivers/acpi/acpica/exresop.c
> @@ -198,7 +198,7 @@ acpi_ex_resolve_operands(u16 opcode,
>
>                                         target_op = AML_DEBUG_OP;
>
> -                                       /*lint -fallthrough */
> +                                       fallthrough;
>
>                                 case ACPI_REFCLASS_ARG:
>                                 case ACPI_REFCLASS_LOCAL:
> @@ -264,7 +264,7 @@ acpi_ex_resolve_operands(u16 opcode,
>                          * Else not a string - fall through to the normal Reference
>                          * case below
>                          */
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 case ARGI_REFERENCE:    /* References: */
>                 case ARGI_INTEGER_REF:
> diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
> index 3adc0a29d890..fcf8dff56c5b 100644
> --- a/drivers/acpi/acpica/exstore.c
> +++ b/drivers/acpi/acpica/exstore.c
> @@ -96,7 +96,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
>                         return_ACPI_STATUS(AE_OK);
>                 }
>
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         default:
>
> @@ -422,7 +422,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
>                                 break;
>                         }
>
> -                       /* Fallthrough */
> +                       fallthrough;
>
>                 case ACPI_TYPE_DEVICE:
>                 case ACPI_TYPE_EVENT:
> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> index 49c46d4dd070..19d574f64c78 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -95,8 +95,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
>                 if (!(register_bit & gpe_register_info->enable_mask)) {
>                         return (AE_BAD_PARAMETER);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_GPE_ENABLE:
>
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> index c365faf4e6cd..6db09eb9d257 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -111,8 +111,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
>                         (void)acpi_ev_delete_gpe_block(object->device.
>                                                        gpe_block);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_TYPE_PROCESSOR:
>         case ACPI_TYPE_THERMAL:
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
> index 681c11f4af4e..f7e43baf5ff2 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
>                 case 'X':
>
>                         type |= ACPI_FORMAT_UPPER;
> -                       /* FALLTHROUGH */
> +                       fallthrough;
>
>                 case 'x':
>
>
