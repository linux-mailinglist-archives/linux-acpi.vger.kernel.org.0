Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E443C14B089
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 08:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgA1Hs7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 02:48:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgA1Hs6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2020 02:48:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so14806840wrh.5
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2020 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P51eYV6xfMKHJtmz3fBCU++fn1Qf38M/P+AHapHYGAU=;
        b=y9eXMqMuTmUqLyuYz6tA7xfsMub5NWGA9gukC82/6CbTvuwE5tyIHg0y4gSJIdT9XO
         QaMQikKhT4RJhDCpMWqj7S1CskChzl/Abjej/Aeoi/ZuXrXcxdjH1e09CrobnqBadfBv
         +sUBJfEzKcuHq5Vsbe3S193T9efhcA0A2mfLv5mjYiSO0b+t/9eD8OHwxSad/NWHOubD
         uXQYuIovSy/ZWIaZIM/inGClwcU3o6UIj2BGPBONnrZhSPI35rGK9YDHrX2+HquFLd4D
         Xn3+Q8C++k9Dm0HybvEG1kmDHrXOz+IoJRxBMh12RdfJvndjqr9Ph0vTluJQacFPqCz8
         mtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P51eYV6xfMKHJtmz3fBCU++fn1Qf38M/P+AHapHYGAU=;
        b=S9fKpr6wnUman4oeH80ueU2xUtPrjdHv6PJW17UT7FSond1La8E2ATwLxqONAzcVFt
         hld7aJ18rerXkqltpzxl9BIWPMxE9dd6bQpzYCcLA629We7oBZXfzXmATyaSW2V7T15l
         MnnbxcKwwfm/XOHVnn5YyyaIqvq6mWpEHVtSkMxeAilwm4e2oQB1GdvNdr+sgdgPK2di
         uVdKJ9iOX9b1eyIuC5bbcuDo/jUV0BG3a4hnTXpJs380MSW+be1smd4uhemcp8hKGfr1
         m+icxCjfN9TypWdO4/SS/8hzkqbMVZ6mbofYv96n4X+WqCbcv4xozHSEG+L9SIt4QDVK
         uvVA==
X-Gm-Message-State: APjAAAVHDmGgj3ywe7ZIX9F5Rd4wCibdtbKDEH4nse8k86xrsD9yrC8C
        +t40RgItxTqrOpMrTS4JqnBCuYkiZuQRZQjchUOwYw==
X-Google-Smtp-Source: APXvYqwlI/CMxioVRnXmP31TfUGLSeLIaF8jir48ryqliWY11yiEVhBEyoOG1Ia71WmOc1XYPfWTI2y8ZR4f9BG5uk8=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr26360242wrw.126.1580197737006;
 Mon, 27 Jan 2020 23:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20200126150231.6021-1-hdegoede@redhat.com>
In-Reply-To: <20200126150231.6021-1-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 Jan 2020 08:48:46 +0100
Message-ID: <CAKv+Gu_dE+pi7CSANOXEP2xenRirWQg5H71t5f4eah8-XZpbxQ@mail.gmail.com>
Subject: Re: [PATCH] efi/bgrt: Accept BGRT tables with a version of 0 on
 Lenovo laptops
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 26 Jan 2020 at 16:02, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some (somewhat older) Lenovo laptops have a correct BGRT table, except
> that the version field is 0 instead of 1.
>
> Quickly after finding this out, even before submitting a first version of
> this patch upstream, the list of DMI matches for affected models grew to
> 3 models (all Ivy Bridge based).
>
> So rather then maintaining an ever growing list with DMI matches for
> affected Lenovo models, this commit simply checks if the vendor is Lenovo
> when the version is 0 and in that case accepts the out of spec version
> working around the Lenovo firmware bug.
>
> Cc: stable@vger.kernel.org
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1791273
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/firmware/efi/efi-bgrt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
> index b07c17643210..3a2d6d3a590b 100644
> --- a/drivers/firmware/efi/efi-bgrt.c
> +++ b/drivers/firmware/efi/efi-bgrt.c
> @@ -15,6 +15,7 @@
>  #include <linux/acpi.h>
>  #include <linux/efi.h>
>  #include <linux/efi-bgrt.h>
> +#include <linux/dmi.h>
>
>  struct acpi_table_bgrt bgrt_tab;
>  size_t bgrt_image_size;
> @@ -42,7 +43,12 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
>                 return;
>         }
>         *bgrt = *(struct acpi_table_bgrt *)table;
> -       if (bgrt->version != 1) {
> +       /*
> +        * Some older Lenovo laptops have a correct BGRT table, except that
> +        * the version field is 0 instead of 1.
> +        */
> +       if (bgrt->version != 1 &&
> +           !(bgrt->version == 0 && dmi_name_in_vendors("LENOVO"))) {
>                 pr_notice("Ignoring BGRT: invalid version %u (expected 1)\n",
>                        bgrt->version);
>                 goto out;

Hi Hans,

Given that the ACPI spec only defines a single version for this table,
which is version #1, wouldn't it be simpler to just assume that
version #0 means version #1 in all cases, rather than using DMI
matches for that? There is no risk of misidentifying another table
version, since none exist ...
