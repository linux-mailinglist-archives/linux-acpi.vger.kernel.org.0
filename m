Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79672CAB51
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 20:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbgLATCc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 14:02:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40304 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392316AbgLATCc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 14:02:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id 79so2707664otc.7;
        Tue, 01 Dec 2020 11:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGCSg/XgNwi3cF4EDoNSb1VDiK1YqRmCPX4AUa7CIjQ=;
        b=EGcp8hiiEt5jD/ct7NOw/JbsolttCwIgda3u3crCt/4/mINRRzUAJfjdXoBmcnYSX/
         RofddQP79sQf8H5sFtByOddKaTkFlWqZhnlUvuRFP/fdKeMm1EwUfOduHWYYzfHzT4zi
         8ftpwDLc1/mKkFgcqzXo0l8J9D9C1Gte/UhLR6ABC3E23h6H91EssqKL/hR6AcHS/HGO
         EXIKmwu/7k12efz2dCeZoGOXKuywXIHQU62BekTL/FYrp45YMYbmTeY46ulQDL6ah/+Z
         rzf2Lsbjh23oS0+lGE3iJTr1BDlXhZfKYLtAhqcYE96zbv604OwLBOG+5kR/3OOdCI3E
         vw0w==
X-Gm-Message-State: AOAM530YBKfEUvd9ZsdrbKb2VPpffes0cjX0ZeA9YubrAto33fBYgf/+
        2WTHRJEkUgMcGZK0np22hdCSYHtVhhGfSVgkfwQ=
X-Google-Smtp-Source: ABdhPJzI3NAp5K2MsFrEh4Ybf5fvmKKvrAttzNfQPSF1b7gj+fuTd6yw4/6cG75pXHja2a/+buZa4WAjrTWQTpSBRQg=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr2868099ots.321.1606849310854;
 Tue, 01 Dec 2020 11:01:50 -0800 (PST)
MIME-Version: 1.0
References: <1606757759-6076-1-git-send-email-john.garry@huawei.com> <1606757759-6076-4-git-send-email-john.garry@huawei.com>
In-Reply-To: <1606757759-6076-4-git-send-email-john.garry@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Dec 2020 20:01:39 +0100
Message-ID: <CAJZ5v0gnwJ37rzi_+FMB-eN1OAW0n86pYN8FWa_Tc4eWvjNv-Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] ACPI: Drop acpi_dev_irqresource_disabled()
To:     John Garry <john.garry@huawei.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        dwagner@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 30, 2020 at 6:41 PM John Garry <john.garry@huawei.com> wrote:
>
> The functionality of acpi_dev_irqresource_disabled() is same as in common
> irqresource_disabled(), so drop acpi_dev_irqresource_disabled() in favour
> of that function.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/resource.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ad04824ca3ba..58203193417e 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -380,13 +380,6 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>
> -static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
> -{
> -       res->start = gsi;
> -       res->end = gsi;
> -       res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> -}
> -
>  static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>                                      u8 triggering, u8 polarity, u8 shareable,
>                                      bool legacy)
> @@ -394,7 +387,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>         int irq, p, t;
>
>         if (!valid_IRQ(gsi)) {
> -               acpi_dev_irqresource_disabled(res, gsi);
> +               irqresource_disabled(res, gsi);
>                 return;
>         }
>
> @@ -426,7 +419,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>                 res->start = irq;
>                 res->end = irq;
>         } else {
> -               acpi_dev_irqresource_disabled(res, gsi);
> +               irqresource_disabled(res, gsi);
>         }
>  }
>
> @@ -463,7 +456,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                  */
>                 irq = &ares->data.irq;
>                 if (index >= irq->interrupt_count) {
> -                       acpi_dev_irqresource_disabled(res, 0);
> +                       irqresource_disabled(res, 0);
>                         return false;
>                 }
>                 acpi_dev_get_irqresource(res, irq->interrupts[index],
> @@ -473,7 +466,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>         case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>                 ext_irq = &ares->data.extended_irq;
>                 if (index >= ext_irq->interrupt_count) {
> -                       acpi_dev_irqresource_disabled(res, 0);
> +                       irqresource_disabled(res, 0);
>                         return false;
>                 }
>                 if (is_gsi(ext_irq))
> @@ -481,7 +474,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                                          ext_irq->triggering, ext_irq->polarity,
>                                          ext_irq->shareable, false);
>                 else
> -                       acpi_dev_irqresource_disabled(res, 0);
> +                       irqresource_disabled(res, 0);
>                 break;
>         default:
>                 res->flags = 0;
> --
> 2.26.2
>
