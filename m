Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34A39FAC9
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFHPfb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 11:35:31 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46706 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFHPfb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 11:35:31 -0400
Received: by mail-oi1-f182.google.com with SMTP id c13so16355531oib.13
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 08:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJN35sA8oiOBg7KCovp5JQeiORtqOg6k54cAUrPLtG4=;
        b=A35NB4iLSxYJ7aAkl2TM0CWj5MiiMDbIcluEPA3axo8+zH1k2GylMyBiBBuzQsmh9A
         o7xuoBfABq6Y0hkRUgDqQCWeVGFA2J2/Pz9noxmizPRQlzaB0vTepQt611KRcWCwVgQ3
         6KWYay0z453a489apI5WOI/urboOPuc2GeW6XuSy4JPhbG40zwjRGqKxSN7kKzYWUQZ5
         Jk/NZUKVr6NxZlkJiu6ZlPbK7t9EsvgrAu7iuev/JdydLNoFjlB/2JKz1v099LQOFXph
         xBHDyU1IA31WC4Xbs7aZ0kkbgLiy5XC8mr5qRV4BhLpUydEHcPJLJIf/N2rqzIVpoDjq
         Gg8Q==
X-Gm-Message-State: AOAM532aJjsSfHR/yhOefqfbHyy80U5FIL2cUyDWXkMvtSfxpacqNgPC
        1jRelYxdNT0UaXEtXltKyVPevP+o/N8vluA09L8=
X-Google-Smtp-Source: ABdhPJzRuyWDI5+sdTCtvHi3RELfHcyPsG7Fwr/BRp/O2MAk04nmgxLKMLMj3rj7/BC6BMgIqYH9/rKQkjXL0FQXcQ4=
X-Received: by 2002:aca:b406:: with SMTP id d6mr3252568oif.71.1623166418251;
 Tue, 08 Jun 2021 08:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210608140701.17938-1-hui.wang@canonical.com>
In-Reply-To: <20210608140701.17938-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 17:33:27 +0200
Message-ID: <CAJZ5v0iMpaAZTcb9=sYHqLQbEjGoEYduAiUnXg05fc5yvVVDoA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI : don't always override the acpi irq
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 4:07 PM Hui Wang <hui.wang@canonical.com> wrote:
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
> IRQNoFlags, and according to the Section 6.4.2.1 of ACPI 6.4 spec [1],
> if IRQ() is empty or defines IRQNoFlags, the IRQ is High true, edge
> sensitive and non-shareable. The linux ACPI driver (acpi_rs_set_irq[]
> in rsirq.c) also assumes so.
>
> Here check 3 conditions to decide if the legacy is true or not, if it
> is true, it means the IRQ() is empty or defines IRQNoFlags and need to
> call irq_override().
>
> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#irq-descriptor # [1]
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> BugLink: http://bugs.launchpad.net/bugs/1909814
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-and-tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/acpi/resource.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..5e4341ca6790 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -447,6 +447,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  {
>         struct acpi_resource_irq *irq;
>         struct acpi_resource_extended_irq *ext_irq;
> +       bool irq_legacy;
>
>         switch (ares->type) {
>         case ACPI_RESOURCE_TYPE_IRQ:
> @@ -459,9 +460,13 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                         irqresource_disabled(res, 0);
>                         return false;
>                 }
> +
> +               irq_legacy = (irq->triggering == ACPI_EDGE_SENSITIVE && irq->polarity ==
> +                             ACPI_ACTIVE_HIGH && irq->shareable == ACPI_EXCLUSIVE);

Now it would make sense to use a wrapper function for this:

static bool irq_is_legacy(struct acpi_resource_irq *irq)
{
        return irq->triggering == ACPI_EDGE_SENSITIVE &&
                irq->polarity == ACPI_ACTIVE_HIGH &&
                irq->shareable == ACPI_EXCLUSIVE;
}

> +
>                 acpi_dev_get_irqresource(res, irq->interrupts[index],
>                                          irq->triggering, irq->polarity,
> -                                        irq->shareable, true);
> +                                        irq->shareable, irq_legacy);

+                                        irq->shareable, irq_is_legacy(irq));

>                 break;
>         case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>                 ext_irq = &ares->data.extended_irq;
> --
