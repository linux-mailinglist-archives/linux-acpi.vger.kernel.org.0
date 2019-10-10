Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB64DD20EB
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 08:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfJJGoz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 02:44:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfJJGoz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2019 02:44:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so6296645wrv.7
        for <linux-acpi@vger.kernel.org>; Wed, 09 Oct 2019 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBnvpPtiriRmjXEbUWwFcMd/j3RNITh3zBD7b/tJiqE=;
        b=yGHsbdWAtvNIvwR1e8vZVOv9s9BXT7ZGWYqVypBZLblozW6hexBZ3yEppXk4YXhjoe
         TAoJNPrvFSItENE8czPaD7JB4/2twXNDvd1W/tan3Pxz3Yrr11np9QWXbWOlh5dgukxa
         rYHZJbPJuA6CTaoD6HRqtNplryy3j7KC81XOgFdxgC1G/yQCDF7UP+/3v8EqSkyKtf0T
         CL5DLDUF/D9iql6di292hKgiDtUMLMTMAkTl62qMBi3Zf3MDXPEkax8pCsAqFpEYNA3b
         hv2wTabXRlDl9eDfBP1iQNNuFguioh/UvHQITHRujpvwupbGbzB3DQJDIkwgWsOPtyYy
         K+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBnvpPtiriRmjXEbUWwFcMd/j3RNITh3zBD7b/tJiqE=;
        b=WJjWSu5bq3WWXlu1SbKv8ZQTqDOGedD2sPuv9M6i45uPXkyjzhg4YV4YoRjdjcQg2T
         8scmjg0x9FkwfdbkZzj3fBWbNqqebuDVGj+w90UzQnv1i9S4fCfVy7bqsOLzb57JL4H3
         TkpXsq4WsVE8bmq1BAI0PKL9MOh9W5HSGCofVdnFCpxv5ETRqGmQaym+5PtQapPeSNA2
         S1o0+6U6LuXRpIKFK3+E95hQ64raI3NRlSFX5ZZA6WrrsoVY4gYuDloOyCLAnwY2M0oT
         dUfpS3MIF61jOpNnRWks5REVWeESHGY9RaOEJl61qXb2XBiydlHhozLsZGBRxYoKH7Lj
         RBVA==
X-Gm-Message-State: APjAAAXW7K2F84hC6Z2/t1xXMYTJwrwpXnezi1kAMgJBZIwHmJ6YY/Ch
        M6RlH2B8f0gdsLWLly52t5g/xB7SJqweDa1oRAe3Ug==
X-Google-Smtp-Source: APXvYqzHYmU5ww+pyjFSoEdFV5KFjQJcu7f3O1cbi1yIhMMEn7zDl3srtVjjrNPJgypImZ1AMMWUAxybYkA6F8IABhw=
X-Received: by 2002:adf:9f08:: with SMTP id l8mr6498960wrf.325.1570689891000;
 Wed, 09 Oct 2019 23:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066230358.1059972.1736585303527133478.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157066230358.1059972.1736585303527133478.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 10 Oct 2019 08:44:38 +0200
Message-ID: <CAKv+Gu8ih2RffZHdwAnHZicL_v8CxV9WnCy+uA1jSSyh58xapA@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] x86/efi: EFI soft reservation to E820 enumeration
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
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
> This patch introduces 2 new concepts at once given the entanglement
> between early boot enumeration relative to memory that can optionally be
> reserved from the kernel page allocator by default. The new concepts
> are:
>
> - E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
>   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
>   new type. Only perform this classification if the
>   CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
>   typical ram.
>
> - IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
>   a device driver to search iomem resources for application specific
>   memory. Teach the iomem code to identify such ranges as "Soft Reserved".
>
> A follow-on change integrates parsing of the ACPI HMAT to identify the
> node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> now, just identify and reserve memory of this type.
>
> Cc: <x86@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

For the EFI changes

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

although I must admit I don't follow the enum add_efi_mode logic 100%


> ---
>  arch/x86/boot/compressed/eboot.c  |    6 ++++-
>  arch/x86/boot/compressed/kaslr.c  |    4 +++
>  arch/x86/include/asm/e820/types.h |    8 ++++++
>  arch/x86/kernel/e820.c            |   12 ++++++++-
>  arch/x86/platform/efi/efi.c       |   48 +++++++++++++++++++++++++++++++++----
>  include/linux/ioport.h            |    1 +
>  6 files changed, 71 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index d6662fdef300..f3b03229c44c 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -553,7 +553,11 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>                 case EFI_BOOT_SERVICES_CODE:
>                 case EFI_BOOT_SERVICES_DATA:
>                 case EFI_CONVENTIONAL_MEMORY:
> -                       e820_type = E820_TYPE_RAM;
> +                       if (efi_soft_reserve_enabled() &&
> +                           (d->attribute & EFI_MEMORY_SP))
> +                               e820_type = E820_TYPE_SOFT_RESERVED;
> +                       else
> +                               e820_type = E820_TYPE_RAM;
>                         break;
>
>                 case EFI_ACPI_MEMORY_NVS:
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c056ba20..ff6fa81949cd 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -760,6 +760,10 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>                 if (md->type != EFI_CONVENTIONAL_MEMORY)
>                         continue;
>
> +               if (efi_soft_reserve_enabled() &&
> +                   (md->attribute & EFI_MEMORY_SP))
> +                       continue;
> +
>                 if (efi_mirror_found &&
>                     !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>                         continue;
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index c3aa4b5e49e2..314f75d886d0 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -28,6 +28,14 @@ enum e820_type {
>          */
>         E820_TYPE_PRAM          = 12,
>
> +       /*
> +        * Special-purpose memory is indicated to the system via the
> +        * EFI_MEMORY_SP attribute. Define an e820 translation of this
> +        * memory type for the purpose of reserving this range and
> +        * marking it with the IORES_DESC_SOFT_RESERVED designation.
> +        */
> +       E820_TYPE_SOFT_RESERVED = 0xefffffff,
> +
>         /*
>          * Reserved RAM used by the kernel itself if
>          * CONFIG_INTEL_TXT=y is enabled, memory of this type
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 7da2bcd2b8eb..9976106b57ec 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -190,6 +190,7 @@ static void __init e820_print_type(enum e820_type type)
>         case E820_TYPE_RAM:             /* Fall through: */
>         case E820_TYPE_RESERVED_KERN:   pr_cont("usable");                      break;
>         case E820_TYPE_RESERVED:        pr_cont("reserved");                    break;
> +       case E820_TYPE_SOFT_RESERVED:   pr_cont("soft reserved");               break;
>         case E820_TYPE_ACPI:            pr_cont("ACPI data");                   break;
>         case E820_TYPE_NVS:             pr_cont("ACPI NVS");                    break;
>         case E820_TYPE_UNUSABLE:        pr_cont("unusable");                    break;
> @@ -1037,6 +1038,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
>         case E820_TYPE_PRAM:            return "Persistent Memory (legacy)";
>         case E820_TYPE_PMEM:            return "Persistent Memory";
>         case E820_TYPE_RESERVED:        return "Reserved";
> +       case E820_TYPE_SOFT_RESERVED:   return "Soft Reserved";
>         default:                        return "Unknown E820 type";
>         }
>  }
> @@ -1052,6 +1054,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
>         case E820_TYPE_PRAM:            /* Fall-through: */
>         case E820_TYPE_PMEM:            /* Fall-through: */
>         case E820_TYPE_RESERVED:        /* Fall-through: */
> +       case E820_TYPE_SOFT_RESERVED:   /* Fall-through: */
>         default:                        return IORESOURCE_MEM;
>         }
>  }
> @@ -1064,6 +1067,7 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>         case E820_TYPE_PMEM:            return IORES_DESC_PERSISTENT_MEMORY;
>         case E820_TYPE_PRAM:            return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
>         case E820_TYPE_RESERVED:        return IORES_DESC_RESERVED;
> +       case E820_TYPE_SOFT_RESERVED:   return IORES_DESC_SOFT_RESERVED;
>         case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
>         case E820_TYPE_RAM:             /* Fall-through: */
>         case E820_TYPE_UNUSABLE:        /* Fall-through: */
> @@ -1078,11 +1082,12 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
>                 return true;
>
>         /*
> -        * Treat persistent memory like device memory, i.e. reserve it
> -        * for exclusive use of a driver
> +        * Treat persistent memory and other special memory ranges like
> +        * device memory, i.e. reserve it for exclusive use of a driver
>          */
>         switch (type) {
>         case E820_TYPE_RESERVED:
> +       case E820_TYPE_SOFT_RESERVED:
>         case E820_TYPE_PRAM:
>         case E820_TYPE_PMEM:
>                 return false;
> @@ -1285,6 +1290,9 @@ void __init e820__memblock_setup(void)
>                 if (end != (resource_size_t)end)
>                         continue;
>
> +               if (entry->type == E820_TYPE_SOFT_RESERVED)
> +                       memblock_reserve(entry->addr, entry->size);
> +
>                 if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>                         continue;
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 0bb58eb33ca0..c96657993167 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -151,10 +151,18 @@ void __init efi_find_mirror(void)
>   * more than the max 128 entries that can fit in the e820 legacy
>   * (zeropage) memory map.
>   */
> +enum add_efi_mode {
> +       ADD_EFI_ALL,
> +       ADD_EFI_SOFT_RESERVED,
> +};
>
> -static void __init do_add_efi_memmap(void)
> +static void __init do_add_efi_memmap(enum add_efi_mode mode)
>  {
>         efi_memory_desc_t *md;
> +       int add = 0;
> +
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return;
>
>         for_each_efi_memory_desc(md) {
>                 unsigned long long start = md->phys_addr;
> @@ -167,7 +175,10 @@ static void __init do_add_efi_memmap(void)
>                 case EFI_BOOT_SERVICES_CODE:
>                 case EFI_BOOT_SERVICES_DATA:
>                 case EFI_CONVENTIONAL_MEMORY:
> -                       if (md->attribute & EFI_MEMORY_WB)
> +                       if (efi_soft_reserve_enabled()
> +                           && (md->attribute & EFI_MEMORY_SP))
> +                               e820_type = E820_TYPE_SOFT_RESERVED;
> +                       else if (md->attribute & EFI_MEMORY_WB)
>                                 e820_type = E820_TYPE_RAM;
>                         else
>                                 e820_type = E820_TYPE_RESERVED;
> @@ -193,9 +204,17 @@ static void __init do_add_efi_memmap(void)
>                         e820_type = E820_TYPE_RESERVED;
>                         break;
>                 }
> +
> +               if (e820_type == E820_TYPE_SOFT_RESERVED)
> +                       /* always add E820_TYPE_SOFT_RESERVED */;
> +               else if (mode == ADD_EFI_SOFT_RESERVED)
> +                       continue;
> +
> +               add++;
>                 e820__range_add(start, size, e820_type);
>         }
> -       e820__update_table(e820_table);
> +       if (add)
> +               e820__update_table(e820_table);
>  }
>
>  int __init efi_memblock_x86_reserve_range(void)
> @@ -227,8 +246,18 @@ int __init efi_memblock_x86_reserve_range(void)
>         if (rv)
>                 return rv;
>
> -       if (add_efi_memmap)
> -               do_add_efi_memmap();
> +       if (add_efi_memmap) {
> +               do_add_efi_memmap(ADD_EFI_ALL);
> +       } else {
> +               /*
> +                * Given add_efi_memmap defaults to 0 and there there is no e820
> +                * mechanism for soft-reserved memory. Explicitly scan for
> +                * soft-reserved memory. Otherwise, the mechanism to disable the
> +                * kernel's consideration of EFI_MEMORY_SP is the
> +                * efi=nosoftreserve option.
> +                */
> +               do_add_efi_memmap(ADD_EFI_SOFT_RESERVED);
> +       }
>
>         WARN(efi.memmap.desc_version != 1,
>              "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
> @@ -781,6 +810,15 @@ static bool should_map_region(efi_memory_desc_t *md)
>         if (IS_ENABLED(CONFIG_X86_32))
>                 return false;
>
> +       /*
> +        * EFI specific purpose memory may be reserved by default
> +        * depending on kernel config and boot options.
> +        */
> +       if (md->type == EFI_CONVENTIONAL_MEMORY &&
> +           efi_soft_reserve_enabled() &&
> +           (md->attribute & EFI_MEMORY_SP))
> +               return false;
> +
>         /*
>          * Map all of RAM so that we can access arguments in the 1:1
>          * mapping when making EFI runtime calls.
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 7bddddfc76d6..a9b9170b5dd2 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -134,6 +134,7 @@ enum {
>         IORES_DESC_PERSISTENT_MEMORY_LEGACY     = 5,
>         IORES_DESC_DEVICE_PRIVATE_MEMORY        = 6,
>         IORES_DESC_RESERVED                     = 7,
> +       IORES_DESC_SOFT_RESERVED                = 8,
>  };
>
>  /*
>
