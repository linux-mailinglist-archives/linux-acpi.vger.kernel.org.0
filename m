Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA094358BE7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhDHSD4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 14:03:56 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44765 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhDHSDz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 14:03:55 -0400
Received: by mail-ot1-f46.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso3139945oti.11
        for <linux-acpi@vger.kernel.org>; Thu, 08 Apr 2021 11:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehRnKs4b7xnj8rCZ/5sbbv3EiKKniMc74Yl1cf4zzWo=;
        b=famO9rL5IuXTmxTDvPNJCaBZaKzYp2oFJW80Jd9FVUrn1XNvhFYnQvtKgc2dgN+SAu
         X352uij9EaAO8F31OvpSakssA9f8mmNQVJcI/XEtDbD+SDz9FHJzWBwAeDF8e/RDXl7B
         RX6/bgcAJQ0S3RaSioK44dvZTfi2Q4Ium2AYyWFy+zHYBV55L4KVddOnLpXOFYlotU8Q
         6xhZVZ9Y+jkhwlxMFSYm3ZgM6vdYwZM5rLr5DaROGUs8XQJhrxNgYPR8KJfwmce3vgNq
         +nN7iC2o9oKOa6CT0EyadkqMFGNfMiceC0wzqtzPdy6RVPA785qB0KqNYG6KjKY9wByu
         qWgg==
X-Gm-Message-State: AOAM532p31Bzqdd18X8YBWtpWECxcbxg8mmB6yuiB1DxrahFxE+rkJBp
        IkcY+nqv4ekviUaEVlFfja88we+Nuj8PkiziqvwDdYpf
X-Google-Smtp-Source: ABdhPJz3OUC7J0fM0+0+apq9LujNqHC4lgW8ByLFgGTSpu/DrB4ZxMz4Z49S+lb9oToxHAwWkrnwERc0Dgbj35SWY6k=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr8742933otb.260.1617905023974;
 Thu, 08 Apr 2021 11:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210408103759.32866-1-acz@semihalf.com>
In-Reply-To: <20210408103759.32866-1-acz@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 20:03:33 +0200
Message-ID: <CAJZ5v0jmYJAVc75qDtyZyXFUZXcSO-TVesN3+vAGp0bPnq9UTQ@mail.gmail.com>
Subject: Re: [PATCH] resource: Prevent irqresource_disabled() from erasing flags
To:     Angela Czubak <acz@semihalf.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        upstream@semihalf.com, Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 8, 2021 at 12:38 PM Angela Czubak <acz@semihalf.com> wrote:
>
> Do not overwrite flags as it leads to erasing triggering and polarity
> information which might be useful in case of hard-coded interrupts.
> This way the information can be read later on even though mapping to
> APIC domain failed.
>
> Signed-off-by: Angela Czubak <acz@semihalf.com>
> ---
> Some Chromebooks use hard-coded interrupts in their ACPI tables.
> This is an excerpt as dumped on Relm:
>
> ...
>             Name (_HID, "ELAN0001")  // _HID: Hardware ID
>             Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
>             Name (_UID, 0x05)  // _UID: Unique ID
>             Name (ISTP, Zero)
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (BUF0, ResourceTemplate ()
>                 {
>                     I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2C1",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
>                     {
>                         0x000000B8,
>                     }
>                 })
>                 Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */
>             }
> ...
>
> This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
> to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
> fails and irqresource_disabled() is issued, which leads to erasing triggering
> and polarity information.
> If that function added its flags instead of overwriting them the correct IRQ
> type would be set even for the hard-coded interrupts, which allows device driver
> to retrieve it.
> This patch was originaly sent to linux-kernel@vger.kernel.org.
> I am resending it to linux-acpi@vger.kernel.org as per request of
> Rafael J. Wysocki to gather more visibility.
> Please let us know if you see possible issues with not erasing the flags or this
> modification seems acceptable.

I've applied the patch as 5.13 material, thanks!

>  include/linux/ioport.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 55de385c839cf..647744d8514e0 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
>  {
>         res->start = irq;
>         res->end = irq;
> -       res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> +       res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>  }
>
>  extern struct address_space *iomem_get_mapping(void);
> --
> 2.17.1
>
