Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905FD2B26F1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 22:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKMVdC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 16:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMVdC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 16:33:02 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F76C0617A6
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 13:33:02 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d3so5166668plo.4
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 13:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQ75ikH05XshXgYTR+1qs3C6oeVcKGNvq/PDg+cf54w=;
        b=q44b+tCOb9LhKXqaP1OKadV9TQZN+nwLolKx6idUlzOFWwN8324zPTIVUHU84GMUtI
         24KN8n1PRKlq6GMfcAuiLnr8vueA/J/QpxktkmZWqmG4PaXMy9fhP+6wNg2rCtdl3WfA
         fxvj9NlDVxe9uGT15tL93GcwwJijZ0wUZau29QA3IQ58j5Upf8tKyVXbPpAcKn2B8m2h
         pL574MvEreWQ7fIRgHQqpoCmmWkbzeQfL8V4ZsPHbCNoDNRTvEPiZO6TKkqUM74kw0Ne
         6hsqB/o6LhQb/yp5/AcQIvJOAnc+W5nmNA4gxAW0mao4UN8+ZnDv+CAH0oWa1gzzKtDg
         c9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQ75ikH05XshXgYTR+1qs3C6oeVcKGNvq/PDg+cf54w=;
        b=KcusM9aQAIsp7ndEw1mpFex/MHUjC13Z6OdZoYPm3kiraDa5LIUkXjx8b905BUzVmY
         hX2p6tmllcwhltg7/dDMSYwld/ETzmGVaTrgSuB1sepQz8heQ2TU0Mb4CJ1860kSGkUT
         nSDJLLrbEc9l1fQ2b+Q1kpKbeFFkUUpT+YP9JiVoTQPoMw+zu6i7Gy/U52AUHif83GGA
         R2mzy64TKPEsSF6GOzG7DpyPpLTSuVRT1Y0c7sYBaQDgpMdCtZp8l+saTcoUuDJtyzHp
         uTgUX2ydI8XRNMLbeIQUPRx6k4rxeO5lAXlbokFEBnEcKgSFaucW6kq9gYAUuNyLjyvu
         sHQA==
X-Gm-Message-State: AOAM530KyDOpqIWzNfKJWv98G9lHJ2UpOlpQkVUBPKtvJ7zgNmjFzfaJ
        TrrkyTc7G1PpX5vGjwlpiBM2b380ycet83Qr7OFvgg==
X-Google-Smtp-Source: ABdhPJzzKJ76NScSPNdZh0EB7QaYXyC7/M0AQzLWLPfoOLggAF8m3EikKM6IDAg2kPnqmQxbo1VH4L1LcHdB4pOO3Mw=
X-Received: by 2002:a17:902:d309:b029:d7:cc2d:1ee7 with SMTP id
 b9-20020a170902d309b02900d7cc2d1ee7mr3737792plc.10.1605303181615; Fri, 13 Nov
 2020 13:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com> <BYAPR11MB32568FEEF4CFA1C20296427B87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32568FEEF4CFA1C20296427B87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Nov 2020 13:32:50 -0800
Message-ID: <CAKwvOd=qDNnOu1oTeEN+chvfJcQSS5dxREo0JQHC=W0zhpYeLw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 13, 2020 at 1:27 PM Moore, Robert <robert.moore@intel.com> wrote:
>
>
>
> -----Original Message-----
> From: ndesaulniers via sendgmr <ndesaulniers@ndesaulniers1.mtv.corp.google.com> On Behalf Of Nick Desaulniers
> Sent: Tuesday, November 10, 2020 6:12 PM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Gustavo A . R . Silva <gustavoars@kernel.org>
> Cc: clang-built-linux@googlegroups.com; Nick Desaulniers <ndesaulniers@google.com>; Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] ACPICA: fix -Wfallthrough
>
> The "fallthrough" pseudo-keyword was added as a portable way to denote intentional fallthrough. This code seemed to be using a mix of fallthrough comments that GCC recognizes, and some kind of lint marker.
> I'm guessing that linter hasn't been run in a while from the mixed use of the marker vs comments.
>
> /*lint -fallthrough */
>
> This is the lint marker

Yes; but from my patch, the hunk modifying
acpi_ex_store_object_to_node() and vsnprintf() seem to indicate that
maybe the linter hasn't been run in a while.

Which linter is that?  I'm curious whether I should leave those be,
and whether we're going to have an issue between compilers and linters
as to which line/order these would need to appear on.

>
> BTW, what version of gcc added -Wfallthrough?

GCC 7.1 added -Wimplicit-fallthrough.

>
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/acpi/acpica/dscontrol.c | 3 +--
>  drivers/acpi/acpica/dswexec.c   | 4 +---
>  drivers/acpi/acpica/dswload.c   | 3 +--
>  drivers/acpi/acpica/dswload2.c  | 3 +--
>  drivers/acpi/acpica/exfldio.c   | 3 +--
>  drivers/acpi/acpica/exresop.c   | 5 ++---
>  drivers/acpi/acpica/exstore.c   | 6 ++----
>  drivers/acpi/acpica/hwgpe.c     | 3 +--
>  drivers/acpi/acpica/utdelete.c  | 3 +--
>  drivers/acpi/acpica/utprint.c   | 2 +-
>  10 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c index 4b5b6e859f62..1e75e5fbfd19 100644
> --- a/drivers/acpi/acpica/dscontrol.c
> +++ b/drivers/acpi/acpica/dscontrol.c
> @@ -61,8 +61,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
>                                 break;
>                         }
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case AML_IF_OP:
>                 /*
> diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c index 1d4f8c81028c..e8c32d4fe55f 100644
> --- a/drivers/acpi/acpica/dswexec.c
> +++ b/drivers/acpi/acpica/dswexec.c
> @@ -597,9 +597,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
>                                 if (ACPI_FAILURE(status)) {
>                                         break;
>                                 }
> -
> -                               /* Fall through */
> -                               /*lint -fallthrough */
> +                               fallthrough;
>
>                         case AML_INT_EVAL_SUBTREE_OP:
>
> diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c index 27069325b6de..afc663c3742d 100644
> --- a/drivers/acpi/acpica/dswload.c
> +++ b/drivers/acpi/acpica/dswload.c
> @@ -223,8 +223,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
>                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
>                                 break;
>                         }
> -
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 default:
>
> diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c index edadbe146506..1b794b6ba072 100644
> --- a/drivers/acpi/acpica/dswload2.c
> +++ b/drivers/acpi/acpica/dswload2.c
> @@ -213,8 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
>                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
>                                 break;
>                         }
> -
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 default:
>
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c index ade35ff1c7ba..9d1cabe0fed9 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -433,8 +433,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
>                  * Now that the Bank has been selected, fall through to the
>                  * region_field case and write the datum to the Operation Region
>                  */
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_TYPE_LOCAL_REGION_FIELD:
>                 /*
> diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c index 4d1b22971d58..df48faa9a551 100644
> --- a/drivers/acpi/acpica/exresop.c
> +++ b/drivers/acpi/acpica/exresop.c
> @@ -197,8 +197,7 @@ acpi_ex_resolve_operands(u16 opcode,
>                                 case ACPI_REFCLASS_DEBUG:
>
>                                         target_op = AML_DEBUG_OP;
> -
> -                                       /*lint -fallthrough */
> +                                       fallthrough;
>
>                                 case ACPI_REFCLASS_ARG:
>                                 case ACPI_REFCLASS_LOCAL:
> @@ -264,7 +263,7 @@ acpi_ex_resolve_operands(u16 opcode,
>                          * Else not a string - fall through to the normal Reference
>                          * case below
>                          */
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 case ARGI_REFERENCE:    /* References: */
>                 case ARGI_INTEGER_REF:
> diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c index 3adc0a29d890..2067baa7c120 100644
> --- a/drivers/acpi/acpica/exstore.c
> +++ b/drivers/acpi/acpica/exstore.c
> @@ -95,8 +95,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
>                 if (dest_desc->common.flags & AOPOBJ_AML_CONSTANT) {
>                         return_ACPI_STATUS(AE_OK);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         default:
>
> @@ -421,8 +420,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
>                                 }
>                                 break;
>                         }
> -
> -                       /* Fallthrough */
> +                       fallthrough;
>
>                 case ACPI_TYPE_DEVICE:
>                 case ACPI_TYPE_EVENT:
> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c index b13a4ed5bc63..fbfad80c8a53 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -166,8 +166,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
>                 if (!(register_bit & gpe_register_info->enable_mask)) {
>                         return (AE_BAD_PARAMETER);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_GPE_ENABLE:
>
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c index 4c0d4e434196..8076e7947585 100644
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
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c index 681c11f4af4e..f7e43baf5ff2 100644
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
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


-- 
Thanks,
~Nick Desaulniers
