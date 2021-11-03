Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C4444842
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCScj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:32:39 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46753 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhKCSci (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:32:38 -0400
Received: by mail-ot1-f43.google.com with SMTP id w29-20020a056830411d00b0055abaca9349so4683819ott.13;
        Wed, 03 Nov 2021 11:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJncZnkGLo6T9yKJwADjLjtLWs14lSc7963i0nFulOw=;
        b=oKXyduPG3WLCb7BDHPtxJle8Qw2OeN4QZCZ6jUMd233j+RMEwTNL50vmovdrtaU44o
         oBiOI65sBC+MMcd3HiENerhSdrSAGzO2iNdE6IoD4B8xpd5hDd77yIkFDMXtliQlU49A
         VvTrdh8GmuE/cXJ4yG6lW924Wsvnzkd+imCoTNOG+fL45gX83eowvnGA/+xtzbDGO0GT
         CW1QUlX+Cy3nrbU9Jbr45M2b6i1jKuoixS0SbEh0PgecDui8xnF5Fa4NdwGeWZruvwIw
         /IGmcoKuzAzPp9xJwt7lixdWtNvHT0i59BecOh1Uv0rZTF7tmrBWEFwBHeqeJRJDQWcT
         /Cfw==
X-Gm-Message-State: AOAM532jpt9bl3bgZlBcgbX5s4xIf6x73r6nHVsMT2Ljy3EFach74khD
        Wy4vv+M9x6G5SbE1hMJCev5q5k/6HMCG3mUi4Do=
X-Google-Smtp-Source: ABdhPJygsU8WQko4k1AmnogVzD7xi9DWbwzEEbmWes0KYajTaodsmxrD8pIUxGkCA/2hTNX44rs3txTXnt1unvHWQiA=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr32548681otd.16.1635964201969;
 Wed, 03 Nov 2021 11:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211031153135.5024-1-hdegoede@redhat.com>
In-Reply-To: <20211031153135.5024-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 19:29:51 +0100
Message-ID: <CAJZ5v0hWC1e-5FG=px9e-A6sFg1HP+pS7KvqYw+vbR0HvpaUZQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / PMIC: Fix intel_pmic_regs_handler() read accesses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 31, 2021 at 4:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The handling of PMIC register reads through writing 0 to address 4
> of the OpRegion is wrong. Instead of returning the read value
> through the value64, which is a no-op for function == ACPI_WRITE calls,
> store the value and then on a subsequent function == ACPI_READ with
> address == 3 (the address for the value field of the OpRegion)
> return the stored value.
>
> This has been tested on a Xiaomi Mi Pad 2 and makes the ACPI battery dev
> there mostly functional (unfortunately there are still other issues).
>
> Here are the SET() / GET() functions of the PMIC ACPI device,
> which use this OpRegion, which clearly show the new behavior to
> be correct:
>
> OperationRegion (REGS, 0x8F, Zero, 0x50)
> Field (REGS, ByteAcc, NoLock, Preserve)
> {
>     CLNT,   8,
>     SA,     8,
>     OFF,    8,
>     VAL,    8,
>     RWM,    8
> }
>
> Method (GET, 3, Serialized)
> {
>     If ((AVBE == One))
>     {
>         CLNT = Arg0
>         SA = Arg1
>         OFF = Arg2
>         RWM = Zero
>         If ((AVBG == One))
>         {
>             GPRW = Zero
>         }
>     }
>
>     Return (VAL) /* \_SB_.PCI0.I2C7.PMI5.VAL_ */
> }
>
> Method (SET, 4, Serialized)
> {
>     If ((AVBE == One))
>     {
>         CLNT = Arg0
>         SA = Arg1
>         OFF = Arg2
>         VAL = Arg3
>         RWM = One
>         If ((AVBG == One))
>         {
>             GPRW = One
>         }
>     }
> }
>
> Fixes: 0afa877a5650 ("ACPI / PMIC: intel: add REGS operation region support")
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Be consistent with capitalization of OpRegion
> ---
>  drivers/acpi/pmic/intel_pmic.c | 51 +++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index a371f273f99d..9cde299eba88 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -211,31 +211,36 @@ static acpi_status intel_pmic_regs_handler(u32 function,
>                 void *handler_context, void *region_context)
>  {
>         struct intel_pmic_opregion *opregion = region_context;
> -       int result = 0;
> +       int result = -EINVAL;
> +
> +       if (function == ACPI_WRITE) {
> +               switch (address) {
> +               case 0:
> +                       return AE_OK;
> +               case 1:
> +                       opregion->ctx.addr |= (*value64 & 0xff) << 8;
> +                       return AE_OK;
> +               case 2:
> +                       opregion->ctx.addr |= *value64 & 0xff;
> +                       return AE_OK;
> +               case 3:
> +                       opregion->ctx.val = *value64 & 0xff;
> +                       return AE_OK;
> +               case 4:
> +                       if (*value64) {
> +                               result = regmap_write(opregion->regmap, opregion->ctx.addr,
> +                                                     opregion->ctx.val);
> +                       } else {
> +                               result = regmap_read(opregion->regmap, opregion->ctx.addr,
> +                                                    &opregion->ctx.val);
> +                       }
> +                       opregion->ctx.addr = 0;
> +               }
> +       }
>
> -       switch (address) {
> -       case 0:
> -               return AE_OK;
> -       case 1:
> -               opregion->ctx.addr |= (*value64 & 0xff) << 8;
> -               return AE_OK;
> -       case 2:
> -               opregion->ctx.addr |= *value64 & 0xff;
> +       if (function == ACPI_READ && address == 3) {
> +               *value64 = opregion->ctx.val;
>                 return AE_OK;
> -       case 3:
> -               opregion->ctx.val = *value64 & 0xff;
> -               return AE_OK;
> -       case 4:
> -               if (*value64) {
> -                       result = regmap_write(opregion->regmap, opregion->ctx.addr,
> -                                             opregion->ctx.val);
> -               } else {
> -                       result = regmap_read(opregion->regmap, opregion->ctx.addr,
> -                                            &opregion->ctx.val);
> -                       if (result == 0)
> -                               *value64 = opregion->ctx.val;
> -               }
> -               memset(&opregion->ctx, 0x00, sizeof(opregion->ctx));
>         }
>
>         if (result < 0) {
> --

Applied as 5.16-rc material, thanks!
