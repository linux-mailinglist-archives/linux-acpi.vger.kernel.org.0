Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315783A0655
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 23:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhFHVov (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 17:44:51 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:36497 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhFHVov (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 17:44:51 -0400
Received: by mail-pf1-f169.google.com with SMTP id c12so16790654pfl.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UTFwgGaZl+fn/RYJyiPsWbP182wWR0oIXNeHYzwJQA=;
        b=vjMLtn3OfN3Eun12/4wGEsK4B3v7SKRflcwqzjuqPCqhj+YyNKYgfhxXFTdqZM1Cqd
         HlCv+z/ZOJrjWw6tv2kuBukESKyE1Y9tkYFX6Qcmtp5yOnX/rwFI9rOk8+M9rfnGuUeM
         hPutUZt2M7CVvVJqDQfm56pTN7s+FdAD/GnjhFKjjq8vk4/crY3lazNZDaVFvlzYQ6Oi
         9cMaLGpHF/blQ1Hpu77FJbEFMwtIeuEqBHrda0h14qh+8ualtiKfK9CpUik8k7VCriWq
         BPZi6cWJozc0ZDkDzn1BrobRbN4KQZd4h6KVYjTfFnbtbKopcQSR/FTjMYWj+dc1I+6J
         NkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UTFwgGaZl+fn/RYJyiPsWbP182wWR0oIXNeHYzwJQA=;
        b=Xk7WTkgtbIEXniw2YQD6CkA3f1GtfyqSNuHoP/TUogyoHyhED4TLHBeue288ZRUxNe
         JXAWWbtFlLynudGqLdTcOkA0k77ku51U7X9+HQQGGR+bgeIzkoW21fJo/iIiJYhuCOrK
         z1988GjuXtM+GYpRtAMYHZ3uZGmGfKXeZUvNnNAwl30gvF8TFjR813qcfknk256uw3DA
         /ImaTOGRDc58Uh010JGkWPjYxCPxEmbX2VsGLzgd2Z9sXq9pqPYW88UinjLUtPYgll9W
         FCtCVyEcQuNBi1uWaJnlibj2fcl5k98dktgUVTbRZebkf2kxWu0tz8f+SUOj2TUq+iYA
         F/VQ==
X-Gm-Message-State: AOAM531Kq1L1LNJj+hO2P/UxQ9ITsx7Y6N/tutf61sELvaTeWMV3XiQ7
        jFjpFt5vYVIt7vG8ZyQDuPAxG2LFhXyRDbsOcuTl5A==
X-Google-Smtp-Source: ABdhPJy8nUBzFUu6yHxfMYdoVePFeGsHZXT9FY1ei/AKa0MmJL5mxsQjULhKDFOv/h4+45S0FWBT+cXuoTHXoAdzlJ8=
X-Received: by 2002:a63:195b:: with SMTP id 27mr287943pgz.450.1623188517724;
 Tue, 08 Jun 2021 14:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 14:41:46 -0700
Message-ID: <CAPcyv4iD2YBSZ8tp3Eue9+gmJ8=4gWRXy-CJucdppvBbcUo1kw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[ add Rafael and linux-acpi ]

On Tue, Jun 8, 2021 at 2:35 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Current TDX spec does not have support to emulate the WBINVD
> instruction. So, add support to skip WBINVD instruction in
> drivers that are currently enabled in the TDX guest.
>
> Functionally only devices outside the CPU (such as DMA devices,
> or persistent memory for flushing) can notice the external side
> effects from WBINVD's cache flushing for write back mappings.
> One exception here is MKTME, but that is not visible outside
> the TDX module and not possible inside a TDX guest.
>
> Currently TDX does not support DMA, because DMA typically needs
> uncached access for MMIO, and the current TDX module always
> sets the IgnorePAT bit, which prevents that.
>
> Persistent memory is also currently not supported. Another code
> path that uses WBINVD is the MTRR driver, but EPT/virtualization
> always disables MTRRs so those are not needed. This all implies
> WBINVD is not needed with current TDX.
>
> So, most drivers/code-paths that use wbinvd instructions are
> already disabled for TDX guest platforms via config-option/BIOS.
> Following are the list of drivers that use wbinvd instruction
> and are still enabled for TDX guests.
>
> drivers/acpi/sleep.c
> drivers/acpi/acpica/hwsleep.c
>
> Since cache is always coherent in TDX guests, making wbinvd as
> noop should not cause any issues. This behavior is the same as
> KVM guest.
>
> Also, hwsleep shouldn't happen for TDX guest because the TDX
> BIOS won't enable it, but it's better to disable it anyways
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since RFC v2-fix-v2:
>  * Instead of handling WBINVD #VE exception as nop, we skip its
>    usage in currently enabled drivers.
>  * Adapted commit log for above change.
>
>  arch/x86/kernel/tdx.c           |  1 +
>  drivers/acpi/acpica/hwsleep.c   | 12 +++++++++---
>  drivers/acpi/sleep.c            | 26 +++++++++++++++++++++++---
>  include/linux/protected_guest.h |  2 ++
>  4 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 1caf9fa5bb30..e33928131e6a 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -100,6 +100,7 @@ bool tdx_protected_guest_has(unsigned long flag)
>         case PR_GUEST_MEM_ENCRYPT_ACTIVE:
>         case PR_GUEST_UNROLL_STRING_IO:
>         case PR_GUEST_SHARED_MAPPING_INIT:
> +       case PR_GUEST_DISABLE_WBINVD:
>                 return true;
>         }
>
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index 14baa13bf848..9d40df1b8a74 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -9,6 +9,7 @@
>   *****************************************************************************/
>
>  #include <acpi/acpi.h>
> +#include <linux/protected_guest.h>
>  #include "accommon.h"
>
>  #define _COMPONENT          ACPI_HARDWARE
> @@ -108,9 +109,14 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
>         pm1a_control |= sleep_enable_reg_info->access_bit_mask;
>         pm1b_control |= sleep_enable_reg_info->access_bit_mask;
>
> -       /* Flush caches, as per ACPI specification */
> -
> -       ACPI_FLUSH_CPU_CACHE();
> +       /*
> +        * WBINVD instruction is not supported in TDX
> +        * guest. Since ACPI_FLUSH_CPU_CACHE() uses
> +        * WBINVD, skip cache flushes for TDX guests.
> +        */
> +       if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
> +               /* Flush caches, as per ACPI specification */
> +               ACPI_FLUSH_CPU_CACHE();
>
>         status = acpi_os_enter_sleep(sleep_state, pm1a_control, pm1b_control);
>         if (status == AE_CTRL_TERMINATE) {
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index df386571da98..3d6c213481f0 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -18,6 +18,7 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/protected_guest.h>
>  #include <asm/io.h>
>  #include <trace/events/power.h>
>
> @@ -71,7 +72,14 @@ static int acpi_sleep_prepare(u32 acpi_state)
>                 acpi_set_waking_vector(acpi_wakeup_address);
>
>         }
> -       ACPI_FLUSH_CPU_CACHE();
> +
> +       /*
> +        * WBINVD instruction is not supported in TDX
> +        * guest. Since ACPI_FLUSH_CPU_CACHE() uses
> +        * WBINVD, skip cache flushes for TDX guests.
> +        */
> +       if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
> +               ACPI_FLUSH_CPU_CACHE();
>  #endif
>         printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
>                 acpi_state);
> @@ -566,7 +574,13 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>         u32 acpi_state = acpi_target_sleep_state;
>         int error;
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       /*
> +        * WBINVD instruction is not supported in TDX
> +        * guest. Since ACPI_FLUSH_CPU_CACHE() uses
> +        * WBINVD, skip cache flushes for TDX guests.
> +        */
> +       if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
> +               ACPI_FLUSH_CPU_CACHE();
>
>         trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
>         switch (acpi_state) {
> @@ -899,7 +913,13 @@ static int acpi_hibernation_enter(void)
>  {
>         acpi_status status = AE_OK;
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       /*
> +        * WBINVD instruction is not supported in TDX
> +        * guest. Since ACPI_FLUSH_CPU_CACHE() uses
> +        * WBINVD, skip cache flushes for TDX guests.
> +        */
> +       if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
> +               ACPI_FLUSH_CPU_CACHE();
>
>         /* This shouldn't return.  If it returns, we have a problem */
>         status = acpi_enter_sleep_state(ACPI_STATE_S4);
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> index adfa62e2615e..0ec4dab86f67 100644
> --- a/include/linux/protected_guest.h
> +++ b/include/linux/protected_guest.h
> @@ -18,6 +18,8 @@
>  #define PR_GUEST_HOST_MEM_ENCRYPT              0x103
>  /* Support for shared mapping initialization (after early init) */
>  #define PR_GUEST_SHARED_MAPPING_INIT           0x104
> +/* Support to disable WBINVD */
> +#define PR_GUEST_DISABLE_WBINVD                        0x105
>
>  #if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
>
> --
> 2.25.1
>
