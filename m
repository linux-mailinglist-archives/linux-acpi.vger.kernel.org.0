Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0B409A63
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Sep 2021 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhIMRL2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Sep 2021 13:11:28 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33345 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbhIMRL1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Sep 2021 13:11:27 -0400
Received: by mail-ot1-f46.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso14317983otu.0
        for <linux-acpi@vger.kernel.org>; Mon, 13 Sep 2021 10:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfS4XsasJ9HzoqyiLkj+WkyxMjsV3V6g4ZlU5tgZy9s=;
        b=LWf8SHb6itKBCFbo41rGSvQm9+EJ0s+K/SbRlpcGJoRdEk6N0rE8FbCUYvoq3+SqRn
         3vNBqsLeR5i6bYK8bE3zhbiTsKOoInBPMuFYISSv6Hd5G2qQ0nBkghkZqznk57fxvxBO
         xL9Nvcor0/x61fMt96cHHb3zjmw1jpSp90o7+2efxTZpxr1cyz2N9NeVJAt7Xn48pHNx
         pNCXIV8FVTDkeg6BqjwH2NFttYOO0KoaCSv1TaPsOqJLqyMj9iEPukLlkkP4FL+8qz/3
         eZETRyinWPT2B/VSdyBLdOcUp6TF3BV37GeCyYKvDTyXuK15BzvH3SfL4KF9w/yr7NWb
         0OtQ==
X-Gm-Message-State: AOAM532hrlZTJLbjIO0+pJF04+Jy4+VXIJk9R1nDzuWOOCaH3INuSWhv
        CFbki5rOUPSYk8hHECimKTswTMSPv7yUp8nitag=
X-Google-Smtp-Source: ABdhPJw0qIMv0UdrfjAzAsh93781TP8K7x9jK5PbRV38q0SkaieyYLam6IIwK5qvdsJDAcPqJdyHZa5YgW4sHJlezno=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr10486060otk.86.1631553011661;
 Mon, 13 Sep 2021 10:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210904014340.17536-1-hui.wang@canonical.com>
In-Reply-To: <20210904014340.17536-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Sep 2021 19:10:00 +0200
Message-ID: <CAJZ5v0gocDX_XFDkUQuYkEEjkxFjPW_u0mf1ZzaHd6FWwAn+bQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resources: add legacy irq override exception by DMI info
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 4, 2021 at 3:44 AM Hui Wang <hui.wang@canonical.com> wrote:
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
> Reported-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/acpi/resource.c | 52 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..434c8964f182 100644
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
> @@ -423,6 +424,49 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>         }
>  }
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
> +static bool acpi_dev_legacy_irq_override(u32 gsi, u8 triggering, u8 polarity,
> +                                        u8 shareable)
> +{
> +       int i;
> +       const struct irq_override_cmp *en;

This can be declared inside the for () loop.  Also, if "en" means
"entry", please call the variable "entry".

> +
> +       for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
> +               en = &skip_override_table[i];
> +
> +               if (dmi_check_system(en->system) &&
> +                   en->irq == gsi &&
> +                   en->triggering == triggering &&
> +                   en->polarity == polarity &&
> +                   en->shareable == shareable)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  /**
>   * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
>   * @ares: Input ACPI resource object.
> @@ -447,6 +491,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  {
>         struct acpi_resource_irq *irq;
>         struct acpi_resource_extended_irq *ext_irq;
> +       bool is_legacy;
>
>         switch (ares->type) {
>         case ACPI_RESOURCE_TYPE_IRQ:
> @@ -459,9 +504,14 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                         irqresource_disabled(res, 0);
>                         return false;
>                 }
> +
> +               is_legacy = acpi_dev_legacy_irq_override(irq->interrupts[index],
> +                                                        irq->triggering, irq->polarity,
> +                                                        irq->shareable);
> +
>                 acpi_dev_get_irqresource(res, irq->interrupts[index],
>                                          irq->triggering, irq->polarity,
> -                                        irq->shareable, true);
> +                                        irq->shareable, is_legacy);

Maybe we can rename the last argument of acpi_dev_get_irqresource() to
check_override (or similar) and do the check in there when that is
set?

>                 break;
>         case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>                 ext_irq = &ares->data.extended_irq;
> --
