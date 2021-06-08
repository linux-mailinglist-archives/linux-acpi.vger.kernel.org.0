Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCA739F597
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhFHLwk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 07:52:40 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43538 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhFHLwj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 07:52:39 -0400
Received: by mail-ot1-f42.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso19980818otu.10
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 04:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9rrdi/gOqmv/tUPT/rH1W5N+kPSWkRyn1kWikpbW68=;
        b=WwJ7JqfWOwO5fp1p2WFwD8mC8eimyeCML44ka8P5UxwRHCQiy08+qQpgduzGnPbnxE
         kVSMaS6JFPshgkAfaepvMaTnI8Zi1ksxdaMS+uJpAc7tz0b/qkii9Y0D3Mvz688KaFoP
         009KoAd5bXDJqKj9euKbHe+PHdl/8GQQILLx1qKuYX/+ztUjBks8DqnJT7W9m05as14r
         Wbqsoy75g6Qyh2FGCdcTUmy4ldXa9eXzcZFd95keh5VrEeWMfRsR4APuGTavV5JXxQQa
         vkWOJUtYC6oQgORcOSGpux4hZl3sGK2DLRtDwVXzEbfWloLW841bf94imsLH8rnIS4M7
         KUXg==
X-Gm-Message-State: AOAM531+SCavZ6nh5i0Z2so6EHX4r3yCIWKfdELssLg2CvqyFAQC/boK
        1AqaqchztTDBTPZl69P9iQ5OsOfRm8zgXgEroYYuQ4fmWvU=
X-Google-Smtp-Source: ABdhPJzTqCo6BGG90AIzMkm7pV5eXBDs/2ZmgKEp/CFiIvFMfZpMXtLa5G1HBzZitTeh/yLHPXkPmi98AOeaPUSK9gU=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr14612726otq.321.1623153032682;
 Tue, 08 Jun 2021 04:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210608045632.8832-1-hui.wang@canonical.com>
In-Reply-To: <20210608045632.8832-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 13:50:21 +0200
Message-ID: <CAJZ5v0inJMEAEDx4WGd4FNp3kYHGA4Pe-UkfpYTUQupKT0-A+Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI : don't always override the acpi irq
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 6:56 AM Hui Wang <hui.wang@canonical.com> wrote:
>
> The laptop keyboard doesn't work on many MEDION notebooks, but the
> keyboard works well under Windows and Unix.
>
> Through debugging, we found this log in the dmesg:
> ACPI: IRQ 1 override to edge, high
> pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
>
> And we checked the IRQ definition in the DSDT, it is:
>     IRQ (Level, ActiveLow, Exclusive, )
>         {1}
>
> So the BIOS defines the keyboard irq to Level_Low, but the linux
> kernel override it to Edge_High. If let the linux kernel skip the irq
> override, the keyboard will work normally.
>
> From the existing comment in the acpi_dev_get_irqresource(), the
> override function only needs to be called when BIOS defines IRQ() or
> IRQNoFlags, and according to page 419 and 420 of the
> ACPI_6_3_final_Jan30.pdf, if IRQ() is empty or defines IRQNoFlags,

Say "Section ... of ACPI 6.3" instead of referring directly to a PDF file.

And if you refer to ACPI 6.4 instead, you may use a Link tag to point
to the relevant section in the HTML format of the spec.

> the IRQ is High true, edge sensitive and non-shareable. The linux
> ACPI driver (acpi_rs_set_irq[] in rsirq.c) also assumes so.
>
> So here add a function to check 4 conditions, if all of them are true,
> call override function. otherwise, it means IRQ descriptior in the
> BIOS is not legacy or is not empty.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> BugLink: http://bugs.launchpad.net/bugs/1909814
> Reported-and-tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/acpi/resource.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..d346aa24ffd6 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -380,6 +380,16 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>
> +static bool acpi_dev_irq_empty_or_noflags(bool legacy, u8 triggering, u8 polarity,
> +                                         u8 shareable)
> +{
> +       if (legacy && (triggering == ACPI_EDGE_SENSITIVE) &&
> +           (polarity == ACPI_ACTIVE_HIGH) && (shareable == ACPI_EXCLUSIVE))
> +               return true;
> +       else
> +               return false;

Because the function returns bool, you can do

  return legacy && triggering == ACPI_EDGE_SENSITIVE && polarity ==
ACPI_ACTIVE_HIGH && shareable == ACPI_EXCLUSIVE;

Also I'm not sure why a new function is needed for this at all, as the
check can be done in-line below just fine.

Moreover, as it stands, the only purpose of the "legacy" argument of
acpi_dev_get_irqresource() is whether or not to do the override, so
the triggering/polarity/shareable check can be used to determine the
value of "legacy" when calling that function from
acpi_dev_resource_interrupt() in the ACPI_RESOURCE_TYPE_IRQ case.

> +}
> +
>  static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>                                      u8 triggering, u8 polarity, u8 shareable,
>                                      bool legacy)
> @@ -401,7 +411,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>          * using extended IRQ descriptors we take the IRQ configuration
>          * from _CRS directly.
>          */
> -       if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
> +       if (acpi_dev_irq_empty_or_noflags(legacy, triggering, polarity, shareable)
> +           && !acpi_get_override_irq(gsi, &t, &p)) {
>                 u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>                 u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>
> --
