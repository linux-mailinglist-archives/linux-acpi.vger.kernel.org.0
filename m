Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDA3A2C4F
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhFJNCe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 09:02:34 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40844 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJNCd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 09:02:33 -0400
Received: by mail-ot1-f48.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so3508447otr.7;
        Thu, 10 Jun 2021 06:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6llwn+tAyxhNtIDtiMmXbYyDut7cQGn+uwgoIvVkUY=;
        b=t9UZmeZwFmga9aQSYY3SEF+8wc+cNwgvn7v/9d5TYGCP7GzD9KGZQPYG4nrm/yijun
         nYwWTHowFZZ5Pzp4ScqvOeSHFa0VExD8pTgVIf0Ub90SNcT4yWMlA5UZ09oFINT8WLPK
         lqriF2kIJsDFAHXvX3da2YMexR+ZOMTMGHQOk5uNdE4kdowTbDPku46oIdUM9OORsRNb
         Qxdq4JsTIuRu9Tj8RPsfmhkVZijAHN/pcOMOVRvIiV4pvrEwjgrnv0+AHKHDDcGEFC+4
         TdWbiJB5sCoXVIUzPunjVHbPpsWdY3pc8SgCqQu5KaIB6OLYxoP99BjWC+oEfwXNRWtj
         5JFA==
X-Gm-Message-State: AOAM531gdpxNTek28HR7q/Kq2u8AHC1yfMEQDJexA2N7NBu/FS/POjJo
        3WfJ7ba77dc6XhgI7yRLLn2YqNqAi25oWR4/oPimzaF1
X-Google-Smtp-Source: ABdhPJy8MgNECmmgQIG338LOVlCxAFayIc9KMY9uTEAP1rrPg5Lg3Lb6SZbegfCEZJDdjRLAqBEJRugmw76B1mRvsXs=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr2359706otg.260.1623330021209;
 Thu, 10 Jun 2021 06:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215047.1955866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609215047.1955866-6-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210609215047.1955866-6-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jun 2021 15:00:10 +0200
Message-ID: <CAJZ5v0gWPrL4VPds2jkMte_dymV8GyaarY3338OUkAGgTrTbEg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] x86: Skip WBINVD instruction for VM guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 9, 2021 at 11:51 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> VM guests that supports ACPI, use standard ACPI mechanisms to signal
> sleep state entry (including reboot) to the host. The ACPI
> specification mandates WBINVD on any sleep state entry with the
> expectation that the platform is only responsible for maintaining the
> state of memory over sleep states, not preserving dirty data in any
> CPU caches. ACPI cache flushing requirements pre-date the advent of
> virtualization. Given guest sleep state entry does not affect any
> host power rails it is not required to flush caches. The host is
> responsible for maintaining cache state over its own bare metal sleep
> state transitions that power-off the cache. A TDX guest, unlike a
> typical guest, will machine check if the CPU cache is powered off.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-acpi@vger.kernel.org
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/acenv.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
> index 9aff97f0de7f..d4162e94bee8 100644
> --- a/arch/x86/include/asm/acenv.h
> +++ b/arch/x86/include/asm/acenv.h
> @@ -10,10 +10,15 @@
>  #define _ASM_X86_ACENV_H
>
>  #include <asm/special_insns.h>
> +#include <asm/cpu.h>
>
>  /* Asm macros */
>
> -#define ACPI_FLUSH_CPU_CACHE() wbinvd()
> +#define ACPI_FLUSH_CPU_CACHE()                         \
> +do {                                                   \
> +       if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))      \
> +               wbinvd();                               \
> +} while (0)
>
>  int __acpi_acquire_global_lock(unsigned int *lock);
>  int __acpi_release_global_lock(unsigned int *lock);
> --
> 2.25.1
>
