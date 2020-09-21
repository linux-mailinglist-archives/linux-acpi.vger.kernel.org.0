Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E482D272C11
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Sep 2020 18:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgIUQ0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 12:26:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46056 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgIUQ0z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2020 12:26:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id g96so12866236otb.12;
        Mon, 21 Sep 2020 09:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu/T3dRokG6v9UdeBN/mIDs6/1yz4SWfuT57Z4RCFXw=;
        b=Ekw/2QWy2R/zC9/zQz/yuGtXTfZmcVmVGp0SY9Ek++kP0B1VHfk4XmjBSJhhpv6ODH
         aG1zG3T2PmQdvByVv+VKvAtRkE4CN/h/LDlqcFfT16IY/UY5MZmsmoILJhP9M1V34vlh
         RQXikCidurWLjHumCxK39+j7UjfKfcZsayRgKGSMZRcqq4tCvBiNaQaZBLTFe4m5JM6a
         vJHMpstakD1dVZevp/acNVQD0HoibnTTR1Aya/UxlKtEYHPAckeQKMxInDa7/NobefSK
         M1adcgASSwyd0E+835I/WcBZV+DteaWpYZmNFkweC0E823qfMPZCo4XP0yaH9b+NgDYH
         ZH+w==
X-Gm-Message-State: AOAM530PThLhVpvCrLbfTuZeNeXucDN2jQpywZ0hLfgO2u3Q8BsGbIFb
        M6Q7kDXU2K9GL8zxIBJi5nugy0rEERkui03RPNs=
X-Google-Smtp-Source: ABdhPJzyuRRf/FRG+njPPDjZBWIsxlQn47JyRZo0W/NF5Uh5m/uDkwfDJrwgLdmTIvf6nsDqFGyvnjw6YLRWP4OBmWI=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr213255otj.262.1600705614432;
 Mon, 21 Sep 2020 09:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200819032354.30234-1-yu.c.chen@intel.com>
In-Reply-To: <20200819032354.30234-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 18:26:43 +0200
Message-ID: <CAJZ5v0hoP6BnHbU_grcAUmZty9iVaKoFFgXx1P0q4NZgXfxasA@mail.gmail.com>
Subject: Re: [PATCH][v2] ACPI: processor: Print more information when
 acpi_processor_evaluate_cst() failed
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 19, 2020 at 5:22 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Some platforms have bogus _CST which might cause expectd behavior
> in the cpu idle driver. Some bogus _CST might be unable to be
> disassembled by acpica-tools due to broken format.
> Print extra log if the _CST extraction/verification failed.
> This can be used to help the user narrow down why the cpu
> idle driver fails to behave as expected.
>
> Suggested-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: According to Rafael's suggestion, change the log level
>     from "warn" to "info"

Applied as 5.10 material with some edits in the subject and changelog, thanks!

> ---
>  drivers/acpi/acpi_processor.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b51ddf3bb616..412a9725cc1e 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -798,22 +798,34 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>                 memset(&cx, 0, sizeof(cx));
>
>                 element = &cst->package.elements[i];
> -               if (element->type != ACPI_TYPE_PACKAGE)
> +               if (element->type != ACPI_TYPE_PACKAGE) {
> +                       acpi_handle_info(handle, "_CST C%d type(%x) is not package, skip...\n",
> +                                        i, element->type);
>                         continue;
> +               }
>
> -               if (element->package.count != 4)
> +               if (element->package.count != 4) {
> +                       acpi_handle_info(handle, "_CST C%d package count(%d) is not 4, skip...\n",
> +                                        i, element->package.count);
>                         continue;
> +               }
>
>                 obj = &element->package.elements[0];
>
> -               if (obj->type != ACPI_TYPE_BUFFER)
> +               if (obj->type != ACPI_TYPE_BUFFER) {
> +                       acpi_handle_info(handle, "_CST C%d package element[0] type(%x) is not buffer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 reg = (struct acpi_power_register *)obj->buffer.pointer;
>
>                 obj = &element->package.elements[1];
> -               if (obj->type != ACPI_TYPE_INTEGER)
> +               if (obj->type != ACPI_TYPE_INTEGER) {
> +                       acpi_handle_info(handle, "_CST C[%d] package element[1] type(%x) is not integer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 cx.type = obj->integer.value;
>                 /*
> @@ -850,6 +862,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>                                 cx.entry_method = ACPI_CSTATE_HALT;
>                                 snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
>                         } else {
> +                               acpi_handle_info(handle, "_CST C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
> +                                                i);
>                                 continue;
>                         }
>                 } else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> @@ -857,6 +871,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>                         snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
>                                  cx.address);
>                 } else {
> +                       acpi_handle_info(handle, "_CST C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
> +                                        i, reg->space_id);
>                         continue;
>                 }
>
> @@ -864,14 +880,20 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>                         cx.valid = 1;
>
>                 obj = &element->package.elements[2];
> -               if (obj->type != ACPI_TYPE_INTEGER)
> +               if (obj->type != ACPI_TYPE_INTEGER) {
> +                       acpi_handle_info(handle, "_CST C%d package element[2] type(%x) not integer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 cx.latency = obj->integer.value;
>
>                 obj = &element->package.elements[3];
> -               if (obj->type != ACPI_TYPE_INTEGER)
> +               if (obj->type != ACPI_TYPE_INTEGER) {
> +                       acpi_handle_info(handle, "_CST C%d package element[3] type(%x) not integer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 memcpy(&info->states[++last_index], &cx, sizeof(cx));
>         }
> --
> 2.17.1
>
