Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D21F3794AB
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhEJQ4c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 10 May 2021 12:56:32 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45666 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhEJQ4a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 12:56:30 -0400
Received: by mail-oi1-f179.google.com with SMTP id n184so16341573oia.12;
        Mon, 10 May 2021 09:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cPyie1bpvv2C9/f/GH9XGDxIlXS7zPMtbfsdirSWxZ4=;
        b=TGi2QhRe7BIVYkCAfHRrmGysqwVh5YHRgCT5ARRVXtuHgtFN30afe2ji9L4w29QjMj
         Vfr0alrt4PYbJHlKjU4EgsjwNARWWrO/jvHqbir0oG5mTPcubMRpNbO0XSix4pffDKc4
         jL3gUszIlniRoYxtrnhTv8u1QWJehwlnNvixId5MAmN12sicDWgcPKS8NOSI3bFtLdDD
         fl0wPQFxECN9k0G7edSjJZj8GVhVwztL+Ln2+DwNtoQKaVqXlvQa6QCkOfncld+ThTnm
         aIZlU4h+vOlB5xsejxtWhqnNb5JqjPVXuvuQOyp/afwO3cVcr5ceL3yJoYTPvR0LZcKo
         zeeA==
X-Gm-Message-State: AOAM533+aZL8EFXHu6S7IrBawDy25LhJ8ll0OBOfgQ2o6Sr9oFS9M35H
        9kYZBX2BwneyXUCo7vCgCVhsEnQieicziqdcwsk=
X-Google-Smtp-Source: ABdhPJxIXkxmGnMXcVchyIr/sm5vUY6x/83ngXdFjXk/+4+y5dgO7XdCBUU/swzgTEM5VfnNpa2tLzgQF0SIkiTfghQ=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr4014221oih.71.1620665725480;
 Mon, 10 May 2021 09:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com> <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com>
In-Reply-To: <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 18:55:14 +0200
Message-ID: <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
To:     "Kuppuswamy, Sathyanarayanan" 
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 6:33 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Rafael/Thomas,
>
> On 4/25/21 7:39 PM, Kuppuswamy Sathyanarayanan wrote:
> > As per ACPI specification r6.4, sec 5.2.12.19, a new sub
> > structure – multiprocessor wake-up structure - is added to the
> > ACPI Multiple APIC Description Table (MADT) to describe the
> > information of the mailbox. If a platform firmware produces the
> > multiprocessor wake-up structure, then OS may use this new
> > mailbox-based mechanism to wake up the APs.
> >
> > Add ACPI MADT wake table parsing support for x86 platform and if
> > MADT wake table is present, update apic->wakeup_secondary_cpu with
> > new API which uses MADT wake mailbox to wake-up CPU.
>
> Gentle ping. Any comments on this patch? I think I have addressed
> the concerns raised by you in previous version.
>
> >
> > Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >   arch/x86/include/asm/apic.h |  3 ++
> >   arch/x86/kernel/acpi/boot.c | 79 +++++++++++++++++++++++++++++++++++++
> >   arch/x86/kernel/apic/apic.c |  8 ++++
> >   3 files changed, 90 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> > index 412b51e059c8..3e94e1f402ea 100644
> > --- a/arch/x86/include/asm/apic.h
> > +++ b/arch/x86/include/asm/apic.h
> > @@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
> >       return apic->get_apic_id(reg);
> >   }
> >
> > +typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
> > +extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
> > +
> >   extern int default_apic_id_valid(u32 apicid);
> >   extern int default_acpi_madt_oem_check(char *, char *);
> >   extern void default_setup_apic_routing(void);
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 14cd3186dc77..fce2aa7d718f 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -65,6 +65,9 @@ int acpi_fix_pin2_polarity __initdata;
> >   static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> >   #endif
> >
> > +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> > +static u64 acpi_mp_wake_mailbox_paddr;
> > +
> >   #ifdef CONFIG_X86_IO_APIC
> >   /*
> >    * Locks related to IOAPIC hotplug
> > @@ -329,6 +332,52 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
> >       return 0;
> >   }
> >
> > +static void acpi_mp_wake_mailbox_init(void)
> > +{
> > +     if (acpi_mp_wake_mailbox)
> > +             return;
> > +
> > +     acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> > +                     sizeof(*acpi_mp_wake_mailbox), MEMREMAP_WB);
> > +}
> > +
> > +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> > +{
> > +     u8 timeout = 0xFF;
> > +
> > +     acpi_mp_wake_mailbox_init();
> > +
> > +     if (!acpi_mp_wake_mailbox)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Mailbox memory is shared between firmware and OS. Firmware will
> > +      * listen on mailbox command address, and once it receives the wakeup
> > +      * command, CPU associated with the given apicid will be booted. So,
> > +      * the value of apic_id and wakeup_vector has to be set before updating
> > +      * the wakeup command. So use WRITE_ONCE to let the compiler know about
> > +      * it and preserve the order of writes.
> > +      */
> > +     WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
> > +     WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> > +     WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
> > +
> > +     /*
> > +      * After writing wakeup command, wait for maximum timeout of 0xFF
> > +      * for firmware to reset the command address back zero to indicate
> > +      * the successful reception of command.
> > +      * NOTE: 255 as timeout value is decided based on our experiments.
> > +      *
> > +      * XXX: Change the timeout once ACPI specification comes up with
> > +      *      standard maximum timeout value.
> > +      */
> > +     while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> > +             cpu_relax();
> > +
> > +     /* If timedout, return error */
> > +     return timeout ? 0 : -EIO;

I'm not sure how my comment regarding the fact that for a given CPU
this function is only usable once has been addressed.

While it may not be a practical concern in the use case that you are
after (TDX), this is a generic mechanism and it needs to cover other
possible usage scenarios.

> > +}
> > +
> >   #endif                              /*CONFIG_X86_LOCAL_APIC */
> >
> >   #ifdef CONFIG_X86_IO_APIC
> > @@ -1086,6 +1135,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
> >       }
> >       return 0;
> >   }
> > +
> > +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > +                                   const unsigned long end)
> > +{
> > +     struct acpi_madt_multiproc_wakeup *mp_wake;
> > +
> > +     if (acpi_mp_wake_mailbox)
> > +             return -EINVAL;
> > +
> > +     if (!IS_ENABLED(CONFIG_SMP))
> > +             return -ENODEV;
> > +
> > +     mp_wake = (struct acpi_madt_multiproc_wakeup *) header;
> > +     if (BAD_MADT_ENTRY(mp_wake, end))
> > +             return -EINVAL;
> > +
> > +     acpi_table_print_madt_entry(&header->common);
> > +
> > +     acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> > +
> > +     acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
> > +
> > +     return 0;
> > +}
> >   #endif                              /* CONFIG_X86_LOCAL_APIC */
> >
> >   #ifdef      CONFIG_X86_IO_APIC
> > @@ -1284,6 +1357,12 @@ static void __init acpi_process_madt(void)
> >
> >                               smp_found_config = 1;
> >                       }
> > +
> > +                     /*
> > +                      * Parse MADT MP Wake entry.
> > +                      */
> > +                     acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
> > +                                           acpi_parse_mp_wake, 1);
> >               }
> >               if (error == -EINVAL) {
> >                       /*
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index 4f26700f314d..f1b90a4b89e8 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -2554,6 +2554,14 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
> >   }
> >   EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
> >
> > +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> > +{
> > +     struct apic **drv;
> > +
> > +     for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> > +             (*drv)->wakeup_secondary_cpu = handler;
> > +}
> > +
> >   /*
> >    * Override the generic EOI implementation with an optimized version.
> >    * Only called during early boot when only one CPU is active and with
> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
