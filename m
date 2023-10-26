Return-Path: <linux-acpi+bounces-1031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6247D8860
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71671C20CD9
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F23AC03
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1137381C9;
	Thu, 26 Oct 2023 17:15:30 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F55C10A;
	Thu, 26 Oct 2023 10:15:29 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5841a3ffd50so174549eaf.1;
        Thu, 26 Oct 2023 10:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340528; x=1698945328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up6fdmcUMJ09KM7otXvgcP25XHUs8+A2jrqzwBf5Mfw=;
        b=GiZ70PA//Xb3hmuuc+VT3V7pxaaof34F/5fMS8rWBdcbqGEQ09fUpNX5M+9u13swjo
         AVlP5M1cN5o0dqYpvhF687Q/9DXKAuijwgEmltQisUZr8vBFzCDyFrkFn9sBe6sVXx1K
         JM8IxmcEpwHlAWDQXpjVptWThqCgTmPcE5WeLUGd2IplYDDooQ7CzGzGArBgcV6Niwzg
         PT4x+UPsbmffQGP+FbOpyyB3cjI9ZKL++vaLOizvJk5gd6z6lmduwQTQ5ymQ8GS0mdf2
         o4R8JWVtkP1m60lfuNaD1xioYvClnxYWbH9FwManStM+rJK5ycHsq8JvvThCcLHGjq+O
         TIdQ==
X-Gm-Message-State: AOJu0YyK7d17qm9+wpIr949ehtbEJZvgBI7KxTwMby7tAIpTRPpbU72B
	/WDZX7CEclvh/91/lRD19iuwnOsQ5QtWzOnt8qE=
X-Google-Smtp-Source: AGHT+IEFceGpeQGoC99bHruICVELRYth0GU0/hl0sLKa7uD4FQeT50X6SNAWxLLrIslty14tZw5AVDBGlRL6WncrRDM=
X-Received: by 2002:a4a:d68a:0:b0:584:1080:f0a5 with SMTP id
 i10-20020a4ad68a000000b005841080f0a5mr75517oot.1.1698340528546; Thu, 26 Oct
 2023 10:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026170330.4657-1-mario.limonciello@amd.com> <20231026170330.4657-2-mario.limonciello@amd.com>
In-Reply-To: <20231026170330.4657-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Oct 2023 19:15:17 +0200
Message-ID: <CAJZ5v0hgvm17dsmf1Bv_k0+HdQ-NKGETx1P6heV5bBz_zMYUcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86: Enable x2apic during resume from suspend if
 used previously
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, David Woodhouse <dwmw@amazon.co.uk>, Sandipan Das <sandipan.das@amd.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 7:03=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If x2apic was enabled during boot with parallel startup
> it will be needed during resume from suspend to ram as well.
>
> Store whether to enable into the smpboot_control global variable
> and during startup re-enable it if necessary.
>
> This fixes resume from suspend on workstation CPUs with x2apic
> enabled.
>
> It will also work on systems with one maxcpus=3D1 but still using
> x2apic since x2apic is also re-enabled in lapic_resume().
>
> Cc: stable@vger.kernel.org # 6.5
> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_=
bringup() and enable it")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v1->v2:
>  * Clarify it's in workstations in commit message
>  * Fix style issues in comment and curly braces
> ---
>  arch/x86/include/asm/smp.h   |  1 +
>  arch/x86/kernel/acpi/sleep.c | 13 +++++++++----
>  arch/x86/kernel/head_64.S    | 15 +++++++++++++++
>  3 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index c31c633419fe..86584ffaebc3 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
>  #endif /* !__ASSEMBLY__ */
>
>  /* Control bits for startup_64 */
> +#define STARTUP_ENABLE_X2APIC  0x40000000
>  #define STARTUP_READ_APICID    0x80000000
>
>  /* Top 8 bits are reserved for control */
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 6dfecb27b846..10d8921b4bb8 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -11,6 +11,7 @@
>  #include <linux/dmi.h>
>  #include <linux/cpumask.h>
>  #include <linux/pgtable.h>
> +#include <asm/apic.h>
>  #include <asm/segment.h>
>  #include <asm/desc.h>
>  #include <asm/cacheflush.h>
> @@ -129,12 +130,16 @@ int x86_acpi_suspend_lowlevel(void)
>          */
>         current->thread.sp =3D (unsigned long)temp_stack + sizeof(temp_st=
ack);
>         /*
> -        * Ensure the CPU knows which one it is when it comes back, if
> -        * it isn't in parallel mode and expected to work that out for
> -        * itself.
> +        * Ensure x2apic is re-enabled if necessary and the CPU knows whi=
ch
> +        * one it is when it comes back, if it isn't in parallel mode and
> +        * expected to work that out for itself.
>          */
> -       if (!(smpboot_control & STARTUP_PARALLEL_MASK))
> +       if (smpboot_control & STARTUP_PARALLEL_MASK) {
> +               if (x2apic_enabled())
> +                       smpboot_control |=3D STARTUP_ENABLE_X2APIC;
> +       } else {
>                 smpboot_control =3D smp_processor_id();
> +       }
>  #endif
>         initial_code =3D (unsigned long)wakeup_long64;
>         saved_magic =3D 0x123456789abcdef0L;
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index ea6995920b7a..300901af9fa3 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -237,9 +237,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
>          * CPU number is encoded in smpboot_control.
>          *
>          * Bit 31       STARTUP_READ_APICID (Read APICID from APIC)
> +        * Bit 30       STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
>          * Bit 0-23     CPU# if STARTUP_xx flags are not set
>          */
>         movl    smpboot_control(%rip), %ecx
> +
> +       testl   $STARTUP_ENABLE_X2APIC, %ecx
> +       jnz     .Lenable_x2apic
> +
>         testl   $STARTUP_READ_APICID, %ecx
>         jnz     .Lread_apicid
>         /*
> @@ -249,6 +254,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
>         andl    $(~STARTUP_PARALLEL_MASK), %ecx
>         jmp     .Lsetup_cpu
>
> +.Lenable_x2apic:
> +       /* Enable X2APIC if disabled */
> +       mov     $MSR_IA32_APICBASE, %ecx
> +       rdmsr
> +       testl   $X2APIC_ENABLE, %eax
> +       jnz     .Lread_apicid_msr
> +       orl     $X2APIC_ENABLE, %eax
> +       wrmsr
> +       jmp     .Lread_apicid_msr
> +
>  .Lread_apicid:
>         /* Check whether X2APIC mode is already enabled */
>         mov     $MSR_IA32_APICBASE, %ecx
> --
> 2.34.1
>

