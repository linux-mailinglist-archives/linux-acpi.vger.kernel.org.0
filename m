Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B43A14C3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhFIMrG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 08:47:06 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38811 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhFIMrE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 08:47:04 -0400
Received: by mail-ot1-f41.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10165948otk.5
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkCxoNHzgFXJq2BIYGnsc6tqd+cRp4h82zBz3msM8FA=;
        b=OD2SI0FSbghXrLzJMTlRc/ieCc+BbVpWLZSO+I3BlP+Xm9NIsIE3VynA5A7YMMVh7G
         tdHv66Cr7AHpZfUFvTnhzPskHi8vhwD4VF7+NjuHkmr4ALbu1Etaa5ChmhfIUZj4dpyk
         IzEMV0A7qpVe1qcvWeTDbFErk7whEdqY8eMKax5kFN/8RhFBByzbbC401HFhWV5YQtHg
         UM4T/w5yCLgzmYhDeY3AOKcR2K7bc85u2V53cwLF5T0rAxF9p+N6K0pMDfP59tkRFusk
         FxmOYpvKP8CDq6fR/X6yDqP+yuaAnGIic+YRHhYCrFJecI1pcp6PMcwuNhjLyIPPTRfI
         t+JQ==
X-Gm-Message-State: AOAM533JD7OJKv1DpXizEmVFji9TUbsjKTiaGbIGmbvxdumkN35FTS3q
        n0AdKLHdrNZ8b1HwN8VNMl8mCo24dm0+L0c98KYo7PaEca8=
X-Google-Smtp-Source: ABdhPJy5Jiit9UltLB571wDyk6REThxR800Gt0LeUYpoHdrwGuEulugt1UBsfvOAKk/u7Rib936S1SOsEY7/9NMd29o=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr22291509otg.260.1623242700341;
 Wed, 09 Jun 2021 05:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210609021442.12446-1-hui.wang@canonical.com>
In-Reply-To: <20210609021442.12446-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 14:44:49 +0200
Message-ID: <CAJZ5v0juxLJXiyreAjeNkUYZZ2SHWCdFRM+ip3-H6NrgYHa=Cw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI : don't always override the acpi irq
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 9, 2021 at 4:14 AM Hui Wang <hui.wang@canonical.com> wrote:
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
>  drivers/acpi/resource.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..dc01fb550b28 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -423,6 +423,13 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>         }
>  }
>
> +static bool irq_is_legacy(struct acpi_resource_irq *irq)
> +{
> +       return irq->triggering == ACPI_EDGE_SENSITIVE &&
> +               irq->polarity == ACPI_ACTIVE_HIGH &&
> +               irq->shareable == ACPI_EXCLUSIVE;
> +}
> +
>  /**
>   * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
>   * @ares: Input ACPI resource object.
> @@ -461,7 +468,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                 }
>                 acpi_dev_get_irqresource(res, irq->interrupts[index],
>                                          irq->triggering, irq->polarity,
> -                                        irq->shareable, true);
> +                                        irq->shareable, irq_is_legacy(irq));
>                 break;
>         case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>                 ext_irq = &ares->data.extended_irq;
> --

Applied as 5.14 material under a new subject ("ACPI: resources: Add
checks for ACPI IRQ override") and with some edits in the patch
changelog.

Note, however, that this is a change in behavior that may result in
regressions on old machines, in which case some further refinements of
the code will be necessary.

Thanks!
