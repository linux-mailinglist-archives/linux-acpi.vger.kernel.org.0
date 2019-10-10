Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36913D20EE
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfJJGqP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 02:46:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36577 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfJJGqP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2019 02:46:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so5436325wmc.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Oct 2019 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQ0pOkrTugUN+MRdoYob0IQtm246jU1zJx3wIxD5k2g=;
        b=FtzY8BH9zAP0+byU2mxad4nsqp/wZ3frTSnldB3oAJWIVF8RSmveuG/8yQYaWFRKn0
         M49AIhcEmJESVMT9laQn37RP6IzHNONwpUapImAnSBJlz69v09DAlYb1neHfgo3tVEyo
         mHoU4T7qBN9HMvVtn8NGblABHXNFaEnXt61hd7xtcwHTKEd7qVQA7VjOnomZ0q/AJWp3
         2KFMA7p26wMMYDbyDHzQNP+MOXUvK0cIrOWm92jWe2l+x1vkYpTrp7NuwUgEI/ZhvYZH
         1qI3rhfYBRt3/vHz7zPt9xMPNYf8ZFjRfJ6VjWm17MpDA3Iibq2glD1MjAMMPnP/Ea2/
         NvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQ0pOkrTugUN+MRdoYob0IQtm246jU1zJx3wIxD5k2g=;
        b=i5BU6a8XpnI2bA6iWKNcUJzyEjTvjIbhn9Uz9lnzWsuTCufMM2AHcrWPNrCnqtV7PY
         mgsSQm++0LhwgDJ04WAylmys6aFG+WWa+Cy5in4J0r+2d5gqgvFaDSEKU1SMToPLRaIP
         r9yLP+0KjpL/TIYVaUuFoblk4DE5/SwpGMr8tb408EFGpf32PBwIXH4f2//JbzUiF4zt
         +t1Kv0edMDBBIq7eczJFCa9qIms/g97nTs/SIl5DgW2RCdIgPZ9U3ZeScepQrAz35+ZL
         tQ21rbTdiOxe9uIyTs/O2aCXui/v/q/Gv+TZfVc17pDRojSlz5m93W6H0fr2MeXnpPNm
         GsdA==
X-Gm-Message-State: APjAAAUE9+b3a7JiqBGVDZcQblvIbNnTflSHJIo+49/FJ0p7hQzahWiG
        tVQM5wj5/4bR3PVyrLxAYJuJSZVMlubtgZGQ7vBBKQ==
X-Google-Smtp-Source: APXvYqzwxj0Itvjoz7lAZd3VLuqGV7ufNrUftdD6JbEeV/KK874YPrNX4z5myyCPlFxm5qg4kG8fbWFDTyifVRJc3NM=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr5817995wmj.119.1570689972510;
 Wed, 09 Oct 2019 23:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066230919.1059972.9000449870543851830.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157066230919.1059972.9000449870543851830.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 10 Oct 2019 08:46:00 +0200
Message-ID: <CAKv+Gu9X2B1e56DwGw=MDfwgkMmGoNnHM7BZ3dV8LVKOJbZrSA@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] arm/efi: EFI soft reservation to memblock
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
>
> UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> interpretation of the EFI Memory Types as "reserved for a specific
> purpose".
>
> The proposed Linux behavior for specific purpose memory is that it is
> reserved for direct-access (device-dax) by default and not available for
> any kernel usage, not even as an OOM fallback.  Later, through udev
> scripts or another init mechanism, these device-dax claimed ranges can
> be reconfigured and hot-added to the available System-RAM with a unique
> node identifier. This device-dax management scheme implements "soft" in
> the "soft reserved" designation by allowing some or all of the
> reservation to be recovered as typical memory. This policy can be
> disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> efi=nosoftreserve.
>
> For this patch, update the ARM paths that consider
> EFI_CONVENTIONAL_MEMORY to optionally take the EFI_MEMORY_SP attribute
> into account as a reservation indicator. Publish the soft reservation as
> IORES_DESC_SOFT_RESERVED memory, similar to x86.
>
> (Based on an original patch by Ard)
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/mm/mmu.c                       |    2 ++
>  drivers/firmware/efi/arm-init.c           |    9 +++++++++
>  drivers/firmware/efi/arm-runtime.c        |   24 ++++++++++++++++++++++++
>  drivers/firmware/efi/libstub/arm32-stub.c |    5 +++++
>  drivers/firmware/efi/libstub/random.c     |    4 ++++
>  5 files changed, 44 insertions(+)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 60c929f3683b..2c385fe05fde 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1061,6 +1061,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>                              size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
>
> +       memblock_clear_nomap(start, size);
> +
>         return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>                            restrictions);
>  }
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 311cd349a862..904fa09e6a6b 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -163,6 +163,15 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
>         case EFI_BOOT_SERVICES_DATA:
>         case EFI_CONVENTIONAL_MEMORY:
>         case EFI_PERSISTENT_MEMORY:
> +               /*
> +                * Special purpose memory is 'soft reserved', which means it
> +                * is set aside initially, but can be hotplugged back in or
> +                * be assigned to the dax driver after boot.
> +                */
> +               if (efi_soft_reserve_enabled() &&
> +                   (md->attribute & EFI_MEMORY_SP))
> +                       return false;
> +
>                 /*
>                  * According to the spec, these regions are no longer reserved
>                  * after calling ExitBootServices(). However, we can only use
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index e2ac5fa5531b..899b803842bb 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -121,6 +121,30 @@ static int __init arm_enable_runtime_services(void)
>                 return 0;
>         }
>
> +       if (efi_soft_reserve_enabled()) {
> +               efi_memory_desc_t *md;
> +
> +               for_each_efi_memory_desc(md) {
> +                       int md_size = md->num_pages << EFI_PAGE_SHIFT;
> +                       struct resource *res;
> +
> +                       if (!(md->attribute & EFI_MEMORY_SP))
> +                               continue;
> +
> +                       res = kzalloc(sizeof(*res), GFP_KERNEL);
> +                       if (WARN_ON(!res))
> +                               break;
> +
> +                       res->start      = md->phys_addr;
> +                       res->end        = md->phys_addr + md_size - 1;
> +                       res->name       = "Soft Reserved";
> +                       res->flags      = IORESOURCE_MEM;
> +                       res->desc       = IORES_DESC_SOFT_RESERVED;
> +
> +                       insert_resource(&iomem_resource, res);
> +               }
> +       }
> +
>         if (efi_runtime_disabled()) {
>                 pr_info("EFI runtime services will be disabled.\n");
>                 return 0;
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> index e8f7aefb6813..3cd54d2096c6 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -146,6 +146,11 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
>                         continue;
>
>                 case EFI_CONVENTIONAL_MEMORY:
> +                       /* Skip soft reserved conventional memory */
> +                       if (efi_soft_reserve_enabled() &&
> +                           (desc->attribute & EFI_MEMORY_SP))
> +                               continue;
> +
>                         /*
>                          * Reserve the intersection between this entry and the
>                          * region.
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index b4b1d1dcb5fd..6c188695e730 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -46,6 +46,10 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
>         if (md->type != EFI_CONVENTIONAL_MEMORY)
>                 return 0;
>
> +       if (efi_soft_reserve_enabled() &&
> +           (md->attribute & EFI_MEMORY_SP))
> +               return 0;
> +
>         region_end = min((u64)ULONG_MAX, md->phys_addr + md->num_pages*EFI_PAGE_SIZE - 1);
>
>         first_slot = round_up(md->phys_addr, align);
>
