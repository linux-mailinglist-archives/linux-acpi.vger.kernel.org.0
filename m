Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0291B29C758
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827877AbgJ0S3c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:29:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45968 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827876AbgJ0S3c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 14:29:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id f37so1999071otf.12
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2020 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMpvqw+2rUd15RyHqkSkWUJQE9/5T8mWX3FiUEkrnRA=;
        b=sjQy4BcKHxfkwQpKcnCQDlk3w5aCmsUiwBmXZyjB7mEo0cgvSH9DfSNuKJJmmASq0z
         cFLpiWMSjngA9MTw/04NAPxHLjHTwl1FDQ7Vehf9KBPUXcfZq0h8+XBsrMfgXTitiX80
         d6B/XaYs5GXysmZdc/Y+PyG2hPytxT2QtpxDWT5Qsafz0Ye2147gXfxHBwuf1EWeEAXM
         apIl4ZHuYYtHR1/4k2pqxV99G4zti8WdQqPJLF2HRZ26GGYP6DBroH4HI9p2VaJdBr9o
         JfGnLfZvV0lYjiL84nKMEF066OWJZlGiGxZ1zYCqpVf32GiGPhF8vwbIbn6/Msz76K80
         loVA==
X-Gm-Message-State: AOAM532yM+XtkEuU5y3BqrOQ58VfdbgqyrLuk7ANYxVWmkEygg4FEiXS
        CxQB2+DFouWAL33SGV9741jsulsJsFFO8lNKXEwfYuh9
X-Google-Smtp-Source: ABdhPJyVpWlZcvtR9zQmtLDQ88e9gDKBAoUsz5pxBJvNsaGdjJtnAJbg0XWVhUfYc+aCMYxTh8oo+3RtAdueBbU4trI=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr2527591otk.260.1603823371127;
 Tue, 27 Oct 2020 11:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201026212840.17231-1-hdegoede@redhat.com>
In-Reply-To: <20201026212840.17231-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 19:29:19 +0100
Message-ID: <CAJZ5v0hXOdqmaWNLG=2GXR-UYMA1d+wyxJuUaS-smCN3E89qng@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Drop no longer necessary Acer SW5-012
 lid_init_state quirk
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 26, 2020 at 10:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 78a5b53e9fb4 ("Input: soc_button_array - work around DSDTs which
> modify the irqflags") adds a workaround for DSDTs with a _LID method
> which play tricks with the irqflags, assuming that the OS is using
> an irq-type of IRQ_TYPE_LEVEL_LOW.
>
> Now that this workaround is in place, we no longer need to disable the
> lid functionality on the Acer SW5-012.
>
> Fixes: 78a5b53e9fb4 ("Input: soc_button_array - Work around DSDTs which modify the irqflags")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/button.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index da4b125ab4c3..0761529cac05 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -73,19 +73,6 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
>
>  /* Please keep this list sorted alphabetically by vendor and model */
>  static const struct dmi_system_id dmi_lid_quirks[] = {
> -       {
> -               /*
> -                * Acer Switch 10 SW5-012. _LID method messes with home and
> -                * power button GPIO IRQ settings causing an interrupt storm on
> -                * both GPIOs. This is unfixable without a DSDT override, so we
> -                * have to disable the lid-switch functionality altogether :|
> -                */
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
> -               },
> -               .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
> -       },
>         {
>                 /* GP-electronic T701, _LID method points to a floating GPIO */
>                 .matches = {
> --

Applied as 5.10-rc material, thanks!
