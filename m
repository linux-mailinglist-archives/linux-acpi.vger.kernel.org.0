Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58C24834A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 12:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRKqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 06:46:32 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41787 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRKqb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2020 06:46:31 -0400
Received: by mail-oo1-f66.google.com with SMTP id x6so4036663ooe.8;
        Tue, 18 Aug 2020 03:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZBdcVXcJ4cNAeKQ+oZAhkzqjphlwK1WHq4Y5baWp/g=;
        b=qH3LMyrs84bMEvMkbsC91a/dYMNX2P2Qpo4DSvX2jyRdmQ3ncrmwGsaExEZyffzPdt
         Txs/1fBdQMHBvspW2EMAUeOcnYorb2rsGvRDtZrP60y3mgiHh2/nD0urE5FAZnWlKFy9
         M+dwMbhjJ2lJPo94kzJmMQfyeYkK+N4yA4nCGqjMQzQCC/98qQfjswZX73iSHEUtyYNm
         +/UoKcL8JbjVFoA/Exy8k5boGb+u5VXEwZk7uQBiA/rxw6d9J8GtOc7odZQPxrNCRvr5
         GBcWBQFfrdHG8pxInLXpXaEoSkYS2gkPWBLmDyOSapfMxoaTysUgPtKBlAcp3v+vFsdd
         1ugA==
X-Gm-Message-State: AOAM530ZJn2b4DFwDR+/MaVtAS4bvVDHJk/ZPDIwZn1X7YsKZhuOEbdV
        c69pWV02lGv2antyUMqfPI6ozcReY7pE2eScfE0=
X-Google-Smtp-Source: ABdhPJzVgHXGjvNzZjI1fl2ditxhkUf5lLRlDdpy9udjfSiegzbCn9n+OlGtljOq+l37gURZoUcHYJDIRDuuSSr+99c=
X-Received: by 2002:a4a:e618:: with SMTP id f24mr14305627oot.75.1597747590537;
 Tue, 18 Aug 2020 03:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200816151230.14524-1-yu.c.chen@intel.com>
In-Reply-To: <20200816151230.14524-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Aug 2020 12:46:12 +0200
Message-ID: <CAJZ5v0jz5EH7bB5Goia=qd_P5eVLoONbscSvvEAqU7svodg_MA@mail.gmail.com>
Subject: Re: [PATCH][RFC] ACPI: processor: Print more information when
 acpi_processor_evaluate_cst() failed
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Aug 16, 2020 at 5:12 PM Chen Yu <yu.c.chen@intel.com> wrote:
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

This is fine by me as a general idea, but please change the log level to "info".

> ---
>  drivers/acpi/acpi_processor.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b51ddf3bb616..c1d34c448edb 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -798,22 +798,34 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>                 memset(&cx, 0, sizeof(cx));
>
>                 element = &cst->package.elements[i];
> -               if (element->type != ACPI_TYPE_PACKAGE)
> +               if (element->type != ACPI_TYPE_PACKAGE) {
> +                       acpi_handle_warn(handle, "_CST C%d type(%x) is not package, skip...\n",
> +                                        i, element->type);
>                         continue;
> +               }
>
> -               if (element->package.count != 4)
> +               if (element->package.count != 4) {
> +                       acpi_handle_warn(handle, "_CST C%d package count(%d) is not 4, skip...\n",
> +                                        i, element->package.count);
>                         continue;
> +               }
>
>                 obj = &element->package.elements[0];
>
> -               if (obj->type != ACPI_TYPE_BUFFER)
> +               if (obj->type != ACPI_TYPE_BUFFER) {
> +                       acpi_handle_warn(handle, "_CST C%d package element[0] type(%x) is not buffer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 reg = (struct acpi_power_register *)obj->buffer.pointer;
>
>                 obj = &element->package.elements[1];
> -               if (obj->type != ACPI_TYPE_INTEGER)
> +               if (obj->type != ACPI_TYPE_INTEGER) {
> +                       acpi_handle_warn(handle, "_CST C[%d] package element[1] type(%x) is not integer, skip...\n",
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
> +                               acpi_handle_warn(handle, "_CST C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
> +                                                i);
>                                 continue;
>                         }
>                 } else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> @@ -857,6 +871,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>                         snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
>                                  cx.address);
>                 } else {
> +                       acpi_handle_warn(handle, "_CST C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
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
> +                       acpi_handle_warn(handle, "_CST C%d package element[2] type(%x) not integer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 cx.latency = obj->integer.value;
>
>                 obj = &element->package.elements[3];
> -               if (obj->type != ACPI_TYPE_INTEGER)
> +               if (obj->type != ACPI_TYPE_INTEGER) {
> +                       acpi_handle_warn(handle, "_CST C%d package element[3] type(%x) not integer, skip...\n",
> +                                        i, obj->type);
>                         continue;
> +               }
>
>                 memcpy(&info->states[++last_index], &cx, sizeof(cx));
>         }
> --
> 2.17.1
>
