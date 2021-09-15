Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECB40CC6A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhIOSPa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 14:15:30 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42925 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOSP2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 14:15:28 -0400
Received: by mail-oi1-f178.google.com with SMTP id bi4so5319470oib.9
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGROUTFSPhPwrAjOiZrRhJr8mYDk0LpfV5uuNbVXVb0=;
        b=J+hILURXZQe26zfMBB5FC3O2xLJIuruP4VYsmFq1R0g7MXSNGcL3U6XTYX6ES8fPf/
         mj1p6NA7KKuinkfmIBEiwZKC8I6jW92akZlBZlSo+7xbMT6iiyG2NrVwxPBMhmpvCHGM
         1NsinnCnoOPcYaN5yjEY+i8/P6LvD9vrloHNIJJez3Vf56MTODfaerh3T9i2L3BYq/GD
         //X1VFBx+gy9YR0u0X+l2/LEplvnk+o2AMp8XSacPNASAdH2bNbX3UiOdkka5vUBy8Ge
         a2ARQlundBIK8NWVV5YgbAJcRGhgHcer1W69giSa49rFbdXNUqv6ogpq1+uiezcYNRpc
         a0LA==
X-Gm-Message-State: AOAM532G7ZpktRXdvEyli1pi9ckuG4/YGs2yjxJHPla+4j697fAzvwiH
        QMkh4Wu+AqAztqKmpmphEHnnNdojGZZUEUD54W4=
X-Google-Smtp-Source: ABdhPJx+oYhzPYoBP+mMHU4bDWfSsLqMCLKuYn/zkFalv7gwp8bLqMFekDKfCFNAXv81uDEvLCI0pQ/uFEbbkq4rNos=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr726565ois.69.1631729649198;
 Wed, 15 Sep 2021 11:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210915130905.11196-1-hui.wang@canonical.com>
In-Reply-To: <20210915130905.11196-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Sep 2021 20:13:58 +0200
Message-ID: <CAJZ5v0g1_zMKX9WeSDF5SXib1EFTke3wMHqtJm-+YtQzSyM6dQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: resources: add legacy irq override exception by
 DMI info
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 15, 2021 at 3:09 PM Hui Wang <hui.wang@canonical.com> wrote:
>
> After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
> IRQ override") is reverted, the keyboard of those Medion laptops can't
> work again.
>
> To fix the keyboard issue, here adding an override check by DMI info,
> this will not affect other machines and this design refers to
> the prt_quirks[] in the drivers/acpi/pci_irq.c.
>
> If we meet similar issues on other platforms, we could expand the
> table of skip_override_table[] or medion_laptop[].
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> BugLink: http://bugs.launchpad.net/bugs/1909814
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/acpi/resource.c | 49 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..7bf38652e6ac 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -16,6 +16,7 @@
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
>  #include <linux/irq.h>
> +#include <linux/dmi.h>
>
>  #ifdef CONFIG_X86
>  #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
> @@ -380,9 +381,51 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>
> +static const struct dmi_system_id medion_laptop[] = {
> +       {
> +               .ident = "MEDION P15651",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "M15T"),
> +               },
> +       },
> +       { }
> +};
> +
> +struct irq_override_cmp {
> +       const struct dmi_system_id *system;
> +       unsigned char irq;
> +       unsigned char triggering;
> +       unsigned char polarity;
> +       unsigned char shareable;
> +};
> +
> +static const struct irq_override_cmp skip_override_table[] = {
> +       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
> +};
> +
> +static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> +                                 u8 shareable)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
> +               const struct irq_override_cmp *entry = &skip_override_table[i];
> +
> +               if (dmi_check_system(entry->system) &&
> +                   entry->irq == gsi &&
> +                   entry->triggering == triggering &&
> +                   entry->polarity == polarity &&
> +                   entry->shareable == shareable)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>                                      u8 triggering, u8 polarity, u8 shareable,
> -                                    bool legacy)
> +                                    bool check_override)
>  {
>         int irq, p, t;
>
> @@ -401,7 +444,9 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>          * using extended IRQ descriptors we take the IRQ configuration
>          * from _CRS directly.
>          */
> -       if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
> +       if (check_override &&
> +           acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
> +           !acpi_get_override_irq(gsi, &t, &p)) {
>                 u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>                 u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>
> --

Applied as 5.16 material under the subject "ACPI: resources: Add
DMI-based legacy IRQ override quirk" with some changelog edits.

Thanks!
