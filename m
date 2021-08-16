Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4043ED8A5
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhHPOFz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 10:05:55 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35496 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhHPOFy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 10:05:54 -0400
Received: by mail-oi1-f180.google.com with SMTP id r26so846597oij.2;
        Mon, 16 Aug 2021 07:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRKDceU3mYZYX25ILhTGVfCF7ZiGQ+F4qa4yz3TodTY=;
        b=h1IZyY9J/x0hGY9XoqXMt0umxGozmjm6S9aJZiPMDhvOcqreu+XR5uZwzz+gfZDMur
         8h/9uIPKtsHkkUhhJjzYAW7aMUHiaJMLVzNhWBjFVQn1M1eQP/kY5amd3HYo8nfuttcK
         y3WjG3uavbeYqNVbGkni+JXVGl7AFxqp9amWHjjGd9RDHHS9Amun/6K1/NPMhun2ucVN
         eRdurYIskcN1uLHqEYfAXbHR4YqQuo0orCte3wru/StIM1WNGw2zQln9BYLpIFyWv0ik
         sGru3nFXa/ZOeMVBKhDKNfmh/RrDfcIUfkBJ8NNO90oBSx5HfF6pyEcl/8X6mqvArFGy
         siCg==
X-Gm-Message-State: AOAM5331y24jeYmjKS0gSxzAYA219m8ksVu4Gh37M+qhmKyZOzu8ubwN
        W1uKBqOxDp9vvkrzlo/DoXW/wLHzQmjjnHlmOi8=
X-Google-Smtp-Source: ABdhPJzOdg3EzWB1728dV5c78AxtjaL0FOKppTxbZlVBy1uVvoUG+e3bXhxL9cLwgjZnAzYITWjRnwYsZLREFWQZJLM=
X-Received: by 2002:a05:6808:220c:: with SMTP id bd12mr12187934oib.157.1629122722961;
 Mon, 16 Aug 2021 07:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210813161842.222414-1-mario.limonciello@amd.com>
In-Reply-To: <20210813161842.222414-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 16:04:57 +0200
Message-ID: <CAJZ5v0jynpMMnMBQuyJPYfSG-6JSe5=a6wW0UtUnpGuh68CqkA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/acpi: Don't add CPUs that are not online capable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Ray Huang <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 13, 2021 at 6:19 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> A number of systems are showing "hotplug capable" CPUs when they
> are not really hotpluggable.  This is because the MADT has extra
> CPU entries to support different CPUs that may be inserted into
> the socket with different numbers of cores.
>
> Starting with ACPI 6.3 the spec has an Online Capable bit in the
> MADT used to determine whether or not a CPU is hotplug capable
> when the enabled bit is not set.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 10 ++++++++++
>  include/acpi/actbl2.h       |  1 +
>  2 files changed, 11 insertions(+)
>
> Changes from v1->v2:
>  * Check the revision field in MADT to determine if it matches the
>    bump from ACPI 6.3 as suggested by Hanjun Guo
>  * Update description
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index e55e0c1fad8c..bfa69a5c9c0b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -53,6 +53,8 @@ int acpi_ioapic;
>  int acpi_strict;
>  int acpi_disable_cmcff;
>
> +bool acpi_support_online_capable;

Missing static?

> +
>  /* ACPI SCI override configuration */
>  u8 acpi_sci_flags __initdata;
>  u32 acpi_sci_override_gsi __initdata = INVALID_ACPI_IRQ;
> @@ -138,6 +140,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
>
>                 pr_debug("Local APIC address 0x%08x\n", madt->address);
>         }
> +       if (madt->header.revision >= 5)
> +               acpi_support_online_capable = true;
>
>         default_acpi_madt_oem_check(madt->header.oem_id,
>                                     madt->header.oem_table_id);
> @@ -239,6 +243,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
>         if (processor->id == 0xff)
>                 return 0;
>
> +       /* don't register processors that can not be onlined */
> +       if (acpi_support_online_capable &&
> +           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +               return 0;
> +
>         /*
>          * We need to register disabled CPU as well to permit
>          * counting disabled CPUs. This allows us to size
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2069ac38a4e2..fae45e383987 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h

The one below is an ACPICA change and I'd prefer it to be integrated
via the upstream ACPICA.

Could you prepare an ACPICA pull request for just the bit below and
send it via GitHub?

> @@ -808,6 +808,7 @@ struct acpi_madt_multiproc_wakeup_mailbox {
>  /* MADT Local APIC flags */
>
>  #define ACPI_MADT_ENABLED           (1)        /* 00: Processor is usable if set */
> +#define ACPI_MADT_ONLINE_CAPABLE    (2)        /* 01: System HW supports enabling processor at runtime */
>
>  /* MADT MPS INTI flags (inti_flags) */
>
> --
