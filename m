Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006792CAB5C
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392364AbgLATDY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 14:03:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45458 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392361AbgLATDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 14:03:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id k3so2696268otp.12;
        Tue, 01 Dec 2020 11:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4nwtnN++PXcnu5S7VLuEP8CX8HDk2g/09v0VasvzIE=;
        b=Cc6Q1QnCv9wTEjGcmYHh+9Ca8Nu0QhucFa1LT6+eIoiy44gzz/MVyKT+KRn/G3ycz5
         KbWhEEA1qmrO6aluGQKlWvXMWaF3eD851/d2+J6tjyrnTkoVQZjLEv6z9DM9hynxnvGu
         hpYZsDtyglJxS7MzAcQ/V0o+P39KNQTTxJfB3dUOr2mrZDCsvSntexp5QlViGjoYNOPz
         vwMu+Hiafu4yBzWimzaPYzcDw2TLh/BcgTM5wmFLUD4SFruf9lcCnPQfo7bxZA3c98Qi
         e+TkmoXGicRrES7aHiTUPdQa3TIZuXQsfZKV8Af79z1qHN4rA/8QfyGpdjrmtroZqiZt
         ARPA==
X-Gm-Message-State: AOAM533OxdxHKAxmFUwIh/pU5Mr8fsfcEP/hg2aXGaQ89boW0LKQLywL
        c++9XHqE8PxLE0H/T/3SzUjm5XGdEtTVYHyWq34=
X-Google-Smtp-Source: ABdhPJzGR+NesdwIyDdJas2CXaIgk6UfRYSZ1sSTqiODL/M3W+gzrpp8l2Q9ipuRL4LAD/fdGa3QPJUhiO5kPbAC3kY=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr2927492ota.260.1606849363083;
 Tue, 01 Dec 2020 11:02:43 -0800 (PST)
MIME-Version: 1.0
References: <1606757759-6076-1-git-send-email-john.garry@huawei.com> <1606757759-6076-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1606757759-6076-3-git-send-email-john.garry@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Dec 2020 20:02:31 +0100
Message-ID: <CAJZ5v0jzDSQ8URKkmBYh0P79P3v5OHCwgssnkyVMk1jpZ=DWyQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] resource: Add irqresource_disabled()
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
> Add a common function to set the fields for a irq resource to disabled,
> which mimics what is done in acpi_dev_irqresource_disabled(), with a view
> to replace that function.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/ioport.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5135d4b86cd6..f9bf374f9633 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -307,6 +307,13 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>  struct resource *request_free_mem_region(struct resource *base,
>                 unsigned long size, const char *name);
>
> +static inline void irqresource_disabled(struct resource *res, u32 irq)
> +{
> +       res->start = irq;
> +       res->end = irq;
> +       res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> +}
> +
>  #ifdef CONFIG_IO_STRICT_DEVMEM
>  void revoke_devmem(struct resource *res);
>  #else
> --
> 2.26.2
>
