Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151A740C4A1
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhIOLz3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 07:55:29 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35763 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhIOLz3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 07:55:29 -0400
Received: by mail-oi1-f178.google.com with SMTP id r26so3859470oij.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 04:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUucg0J6qlBbOrs2WyyDhaeyGjTKqaxoxhX8qkgpoiE=;
        b=KlRjsENo95IQ6DjSvd7l2q5ZnU5rJ+NrkjSFpTOHEpmnx9Sq4IptEGYsuxlaluwgLm
         ZVnLpjcW6ylU4oWx+/CIe10kjqFbePcABO2yvqkkRnHgoZr2iqPdFPwoaA+84607r6iA
         IpbvDHqeYT6hBTiaPoVnqjbeGbJh9Kwgf1M0cqWwVT9ZK8uBGj4YgZZgSMN1ZMVDSh5n
         fhE/vccLU4yUgajp26s6oFZ2r7P3k7WdSCROuuMvbdUnJN8y4CdfU2XVTgWPRMxYwyUt
         0zfAle/mTPiQZ56esWEcAG4hJVV83lzepWtelll7WeCHYzcfwWc28mv1RM4Bvy4l5SMu
         f02Q==
X-Gm-Message-State: AOAM530KxwKkTekxvlQUZcuGIJyrAIYCWDQwLe7MGUtqg6J6n2D7BPc/
        nVpVHXPVd3sgLon9hZVxt9cw0QJY+v70Xcwj7XA=
X-Google-Smtp-Source: ABdhPJxHYZQOOADzo60PDKLH1clLicgr9j+nwJTJUrcLN4aywJ/CBbzPLtyKZkQQ1fnb2yYSTS69skLi3O488gzAjk8=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr4942480oie.71.1631706849913;
 Wed, 15 Sep 2021 04:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210914133410.88366-1-hui.wang@canonical.com>
In-Reply-To: <20210914133410.88366-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Sep 2021 13:53:57 +0200
Message-ID: <CAJZ5v0jvSEdcgu+gRa2s25wW3L+RQHoyPJiorid7wZdKM23CQw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resources: add legacy irq override exception by
 DMI info
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 14, 2021 at 3:34 PM Hui Wang <hui.wang@canonical.com> wrote:
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
>  drivers/acpi/resource.c | 51 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..676254ccac4d 100644
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
> @@ -380,17 +381,63 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
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
> +       bool override;
>
>         if (!valid_IRQ(gsi)) {
>                 irqresource_disabled(res, gsi);
>                 return;
>         }
>
> +       override = check_override && acpi_dev_irq_override(gsi, triggering,
> +                                                          polarity, shareable);
> +

This can be still made more straightforward.

The local bool variable is not necessary and check below can be
rearranged as follows below.

>         /*
>          * In IO-APIC mode, use overridden attribute. Two reasons:
>          * 1. BIOS bug in DSDT
> @@ -401,7 +448,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>          * using extended IRQ descriptors we take the IRQ configuration
>          * from _CRS directly.
>          */
> -       if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
> +       if (override && !acpi_get_override_irq(gsi, &t, &p)) {

if (check_override &&
    acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
    !acpi_get_override_irq(gsi, &t, &p)) {

>                 u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>                 u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>
> --
> 2.25.1
>
