Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3D3692A6
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 15:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbhDWNGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 23 Apr 2021 09:06:25 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34727 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWNGZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 09:06:25 -0400
Received: by mail-oi1-f172.google.com with SMTP id k18so44180596oik.1;
        Fri, 23 Apr 2021 06:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7txDfozLZuDxpt0Jozzob2BwaswCNhJSJgn0anaNs5Y=;
        b=T9vu/3+FWk52vNmr5baz+MV2LNklFb2Gvw+SqYGEM2s6Gdo4paXcmS5GPd6Sx1MYEA
         P0WWgsgh0NvGQA/7KtAgmawXpg3rLGleizKR+gcGK+ps5VSV3K3jKsI3PubdEjOXG+6T
         zkkmbKT0dC9HVLFGzbwh8mwRjKNmi35MixwLyE/0AzTYH4iWH8N6PY9dCN8/WuY8HGt6
         VSu9dVZuEKBdtbxdDukU6pjFfBVT2vr2q5yNup/b36WcdUtKGAB6ba8B72pKVCrFm5DS
         tBG99dgs4jJevrwhwg5Az22zcpP2x80nrbqtqIF/aOOjezhLX1qa6irYShyuymh8v2Bt
         gnIw==
X-Gm-Message-State: AOAM530wu8BgIzVElHKfo1wQI+ODFwyU1dwwG7fU3Hvmh5AMvYH8JMLO
        UnivJvpLd9oVSWMdFMX7+dA17RMjgChnp7GCoIk=
X-Google-Smtp-Source: ABdhPJxed4kshy/7T2vF2FVpzLoNQh2hWfwfRXBuCHzZRW1wwYQaRWjt0/xjcHZkD1XCOJfvQUdTvMF7N4kOewn9pDw=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr2656356oib.69.1619183148339;
 Fri, 23 Apr 2021 06:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-4-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210422214708.716164-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 15:05:37 +0200
Message-ID: <CAJZ5v0iv0r3x0rDiB6+M+CZcAPcFK8i6R1n=v1NPcNg16invTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 11:47 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> As per ACPI specification r6.4, sec 5.2.12.19, a new sub
> structure – multiprocessor wake-up structure - is added to the
> ACPI Multiple APIC Description Table (MADT) to describe the
> information of the mailbox. If a platform firmware produces the
> multiprocessor wake-up structure, then OS may use this new
> mailbox-based mechanism to wake up the APs.
>
> Add ACPI MADT wake table parsing support for x86 platform and if
> MADT wake table is present, update apic->wakeup_secondary_cpu with
> new API which uses MADT wake mailbox to wake-up CPU.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/include/asm/apic.h     |  3 ++
>  arch/x86/kernel/acpi/boot.c     | 56 +++++++++++++++++++++++++++++++++
>  arch/x86/kernel/apic/probe_32.c |  8 +++++
>  arch/x86/kernel/apic/probe_64.c |  8 +++++
>  4 files changed, 75 insertions(+)
>
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 412b51e059c8..3e94e1f402ea 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
>         return apic->get_apic_id(reg);
>  }
>
> +typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
> +extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
> +
>  extern int default_apic_id_valid(u32 apicid);
>  extern int default_acpi_madt_oem_check(char *, char *);
>  extern void default_setup_apic_routing(void);
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 14cd3186dc77..a4a6b97910e1 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -65,6 +65,9 @@ int acpi_fix_pin2_polarity __initdata;
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>  #endif
>
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +static u64 acpi_mp_wake_mailbox_paddr;
> +
>  #ifdef CONFIG_X86_IO_APIC
>  /*
>   * Locks related to IOAPIC hotplug
> @@ -329,6 +332,29 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>         return 0;
>  }
>
> +static void acpi_mp_wake_mailbox_init(void)
> +{
> +       if (acpi_mp_wake_mailbox)
> +               return;
> +
> +       acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +                       sizeof(*acpi_mp_wake_mailbox), MEMREMAP_WB);
> +}
> +
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +       acpi_mp_wake_mailbox_init();
> +
> +       if (!acpi_mp_wake_mailbox)
> +               return -EINVAL;
> +
> +       WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
> +       WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +       WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
> +
> +       return 0;
> +}
> +
>  #endif                         /*CONFIG_X86_LOCAL_APIC */
>
>  #ifdef CONFIG_X86_IO_APIC
> @@ -1086,6 +1112,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
>         }
>         return 0;
>  }
> +
> +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +                                     const unsigned long end)
> +{
> +       struct acpi_madt_multiproc_wakeup *mp_wake;
> +
> +       if (acpi_mp_wake_mailbox)
> +               return -EINVAL;
> +
> +       if (!IS_ENABLED(CONFIG_SMP))
> +               return -ENODEV;
> +
> +       mp_wake = (struct acpi_madt_multiproc_wakeup *) header;
> +       if (BAD_MADT_ENTRY(mp_wake, end))
> +               return -EINVAL;
> +
> +       acpi_table_print_madt_entry(&header->common);
> +
> +       acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +
> +       acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
> +
> +       return 0;
> +}
>  #endif                         /* CONFIG_X86_LOCAL_APIC */
>
>  #ifdef CONFIG_X86_IO_APIC
> @@ -1284,6 +1334,12 @@ static void __init acpi_process_madt(void)
>
>                                 smp_found_config = 1;
>                         }
> +
> +                       /*
> +                        * Parse MADT MP Wake entry.
> +                        */
> +                       acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
> +                                             acpi_parse_mp_wake, 1);
>                 }
>                 if (error == -EINVAL) {
>                         /*
> diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
> index a61f642b1b90..d450014841b2 100644
> --- a/arch/x86/kernel/apic/probe_32.c
> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -207,3 +207,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>         }
>         return 0;
>  }
> +
> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> +{
> +       struct apic **drv;
> +
> +       for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> +               (*drv)->wakeup_secondary_cpu = handler;
> +}
> diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
> index c46720f185c0..986dbb68d3c4 100644
> --- a/arch/x86/kernel/apic/probe_64.c
> +++ b/arch/x86/kernel/apic/probe_64.c
> @@ -50,3 +50,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>         }
>         return 0;
>  }
> +
> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> +{
> +       struct apic **drv;
> +
> +       for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> +               (*drv)->wakeup_secondary_cpu = handler;
> +}

Although I've looked at this patch already, I now realize that
according to the spec the mailbox is only suitable for the first AP
wakeup during system initialization.

Shouldn't the original handler be restored then to handle subsequent wakeups?
