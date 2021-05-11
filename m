Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19737A4D7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhEKKqg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 06:46:36 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44740 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhEKKqg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 06:46:36 -0400
Received: by mail-oi1-f177.google.com with SMTP id d21so18587629oic.11;
        Tue, 11 May 2021 03:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6u/v5pBgRg/r9/xunKJA/aeWT5HHENr+pYBgEABwaM=;
        b=q/4k+4OGGYRDa9kbEsfj1VEhPY/iot2u8WacJO58PfbR0lBc3dm55m0xRG6DeIbPH2
         oi9ygkjp4xo9fr/oFCQha7/he5s3JOvf+QwD5/t8uI1NNSzudkLWYqjZeSs1CWTSF4LR
         F3e8upnpZ6a7ggux4tsHemuIEpyjXjBu0+4tX8A3peYfJlvsAIoD2gaUMlXlroKEVMS3
         rfkCKzr9S5Gq4v5dQVD5ZNIJWCR8rVsLptTq0J8RdidzM5VF8wu8skEPdK+VLmH4Q++M
         THwYjA+5KfzJcuo/DOnl8LxnDGP/VuqL2QuSdHhhjTKgN7sUBR6/tulVvz9ATQkwoPU+
         HEzw==
X-Gm-Message-State: AOAM5308nATc1dNf0f/lUopDZLtXSnAXo7Teu2f9j/LycHLktQgpAsGs
        ksp4QLshuKeuXGWthEIVILlxnFW3HKNlE5IpsPs=
X-Google-Smtp-Source: ABdhPJwdZXJ1ob0LZQ7EGgUCIILvcrD+X3ZUrC0FuYdEvHrdhEo5dPSceGjRdF/CLveke651T/GDoEkrNARhJEq2tH8=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr6972892oih.71.1620729928220;
 Tue, 11 May 2021 03:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com> <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
 <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com> <20210510172237.GU4032392@tassilo.jf.intel.com>
 <CAJZ5v0iFsBWwXhqtLbTMicBSFme0HCvg+2xgtMgpkFMupk_Rkw@mail.gmail.com> <bc14b461-6431-c5ce-7117-854af8454900@linux.intel.com>
In-Reply-To: <bc14b461-6431-c5ce-7117-854af8454900@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 12:45:17 +0200
Message-ID: <CAJZ5v0hFfVCm25wUCetOm4YdZKwt5h2jknN9ad1nnpxuR16KkQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
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
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 11:15 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 5/10/21 10:24 AM, Rafael J. Wysocki wrote:
> > The wakeup function can return an error when it is called for the
> > second time on the same CPU.
>
> To do this, we can only maintain the wakeup status of the CPUs. Can
> you check whether following physid_mask based status maintenance is
> acceptable?

It would work for me except for a couple of nits below.

> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -67,6 +67,7 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>
>   static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>   static u64 acpi_mp_wake_mailbox_paddr;
> +static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
>
>   #ifdef CONFIG_X86_IO_APIC
>   /*
> @@ -347,6 +348,13 @@ static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>
>          acpi_mp_wake_mailbox_init();
>
> +       /* Check if the given CPU (apicid) is already awake */

The reason why is that the wakeup mechanism used here is only usable
once per CPU by the spec, so I would add this information to the
comment.  Maybe something like "According to the ACPI specification
(ACPI 6.4, Section ...), the mailbox-based wakeup mechanism cannot be
used more than once for the same CPU, so avoid doing that."

> +       if (physid_isset(apicid, apic_id_wakemap)) {
> +               pr_err("APIC ID %x is already awake, so failed to wakeup\n",
> +                               apicid);

And I would reword the message like this "CPU already awake (APIC ID
%x), skipping wakeup\n".

> +               return -EINVAL;
> +       }
> +
>          if (!acpi_mp_wake_mailbox)

Note, though, that instead of having this additional flag, you may as
well create a mask that is fully populated initially and clear the IDs
of the woken-up CPUs in it.  Then, you'd only need one check here
instead of two.

>                  return -EINVAL;
>
> @@ -374,8 +382,18 @@ static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>          while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
>                  cpu_relax();
>
> -       /* If timedout, return error */
> -       return timeout ? 0 : -EIO;
> +       if (timeout) {
> +               /*
> +                * If the CPU wakeup process is successful, store the
> +                * status in apic_id_wakemap to prevent re-wakeup
> +                * requests.
> +                */
> +               physid_set(apicid, apic_id_wakemap);
> +               return 0;
> +       }
> +
> +       /* If timed out (timeout == 0), return error */
> +       return -EIO;
>   }
>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
