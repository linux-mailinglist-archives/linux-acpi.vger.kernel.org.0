Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FCB369245
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhDWMj3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 08:39:29 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:39875 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhDWMj2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 08:39:28 -0400
Received: by mail-oi1-f177.google.com with SMTP id i81so49050063oif.6;
        Fri, 23 Apr 2021 05:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+Cr6KRQiqW/QQh4fNj+YQmgd5j/X9ToNwhEzqEwqCo=;
        b=VotI3DsqoOsCFq3S7Z0u/yVbatkX327+EBCQ31YnHkUfntHGnW9l7TrEtFwP0nalE/
         a1fWtwgkzUtwCH0JsfQ8nrm9XUUZe/3NiLFT2eQRtTd9fVBYHMd2M0p2H44KCkBN1SA4
         1bQfqlHObfb4yflWPQdYFomSXlr1KIkcSphZYb5pvG5plB0pzu8MGtsoDEGeDHbpk4Zo
         Zl6EsJe9oMbpjvkFowIrUZhPm5XVv8EfUFBS+yrQRJM3LZ0geRYMtYQx4PeZ4ZUe/1rs
         Hse5m/6HlavO6YrRX0FOzaImke3kQD69bCpoXUFjdG69ujuSQBoH3qUfGqrbWcbWMILI
         ceSg==
X-Gm-Message-State: AOAM533ke/dKD88bhSRNNpxdx3ALAANUzHL37h0fn/4sIfB+JYB9A9WZ
        iYbZfZlAShz+U+IBEdk3zHzTcq0/gtFTu2I/Ip8=
X-Google-Smtp-Source: ABdhPJzbGPz2ugAvCKps+kiVe9FVh0OHyR+v6YWDecakD6U0egek7LXAYxlIUGwI4+h5Istp2xB227+RKnzqmJRkDoA=
X-Received: by 2002:aca:bc89:: with SMTP id m131mr2678202oif.71.1619181531825;
 Fri, 23 Apr 2021 05:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210422214708.716164-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 14:38:41 +0200
Message-ID: <CAJZ5v0iwuqjPhceuO0dfq5zggpq9OHpv=bPtcZYhVtd-+-xyNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI/table: Print MADT Wake table information
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 11:47 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> When MADT is parsed, print MADT Wake table information as
> debug message. It will be useful to debug CPU boot issues
> related to MADT wake table.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This obviously depends on the ACPICA changes from the previous patch,
so I can pick it up when that material gets integrated.

For now

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9d581045acff..206df4ad8b2b 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -207,6 +207,17 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>                 }
>                 break;
>
> +       case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +               {
> +                       struct acpi_madt_multiproc_wakeup *p;
> +
> +                       p = (struct acpi_madt_multiproc_wakeup *) header;
> +
> +                       pr_debug("MP Wake (Mailbox version[%d] base_address[%llx])\n",
> +                                p->mailbox_version, p->base_address);
> +               }
> +               break;
> +
>         default:
>                 pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
>                         header->type);
> --
> 2.25.1
>
