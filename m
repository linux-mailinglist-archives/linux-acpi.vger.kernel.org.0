Return-Path: <linux-acpi+bounces-9328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBBC9BD6DA
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 21:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31C31C22AB3
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29320D509;
	Tue,  5 Nov 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQcegzw+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517791FF7B2;
	Tue,  5 Nov 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837856; cv=none; b=ilsc0+1Hie0lqftYLLYfSG0x2hfpHsVB4AcMfi8JEbGOAUVD1J0xyPOVCFplSB9oFvLKwhL7fW7zQ+eMSvqHQIgf3cwyp7+mSPgE1rD9TlAsOFEqG3qTLsV7mHvodVIbMsUvbP5KoluWqlfnAf+6ycg8iBC9p8lBSwBi6bPNuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837856; c=relaxed/simple;
	bh=bOgEht1HbE20KTGeOb0qOu0iQUipT6sjJUQ/+qW31S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNQ6iS2/qPkzN8E8W5jOJ2+SHFmNPlPYzpaKn1WgIMe4arPvfBpNw+TcKJAy1GLaC4imyV+hkMe1LihZfCy/qI4VuJ/NhdqiNXzCC9M9u9axOqJkkpiisOvRtHpNbqYrk9CPyDtUsoHf0bXD9v19sXhARceetum5TeymynNUHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQcegzw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB970C4CED8;
	Tue,  5 Nov 2024 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730837855;
	bh=bOgEht1HbE20KTGeOb0qOu0iQUipT6sjJUQ/+qW31S4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vQcegzw+EaIm6xV+T7LwPrRddgPo+r38tEx1Kh8tSseI3VfPpoArvFsqMRDpCker5
	 IZpD6Qyq4N8kc3ZJUCcZwQhjtw8/ey08oOpngY1y3LxSODn7l1b+dAhzc7Vv8X5xen
	 W79vu/vX3ZwMLb5/UHJKc9RiIe498ztC+PhkWw44zMf0mvoPyoGb1e03kI2APgnyJZ
	 8ahPSO1yE8nuwsYCD1PBrwkylDlGJjCcTThRibKxi9T+NDks8Y1uyHpzNPbF6ZmlCO
	 7kgvN8bdxLXbCjwATCrlOfMIE7reqT6q4yZ0+Fqaac3Zpf5pL+SpsVLvDeoJlqwkBE
	 fvk5b6JyCY7Nw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5eba450531eso89362eaf.1;
        Tue, 05 Nov 2024 12:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqOh9xc1dyYeKdNfRnL0HIvoEOx3FGoAHS10nMC0D9AoycWvkpkA+w4G56GYgaKvUSTvmO6aJI+V1NUow/@vger.kernel.org, AJvYcCWzp3P5R2kHe1FtQx6oDulg4Th7zgLMCb0g/PZxlMDswCpAW1MXr7aBVjgzTvxB/PDFnfLY8wQYEzrN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0K9Cgx+fgNwWULVRvg7SOd9uOcPrLPX2iKZWvsX9lCzyvxjd
	r8pD5kEaGQy9m10LLqa4Fx2j4/Obz2TjvYlaapO1Am15qT+AoGMRMgp6isevcK4ynZLqXLfwQeC
	LSHleeC5Ia0r4ccMpIFCtZFO/5S0=
X-Google-Smtp-Source: AGHT+IFkodElR8vqcP0ei2g3pVy9P9Ca9E11kdVBmcFBRuGP6ndcGa+mT5uVkzl1F1GNokRHPaZFe+NsiE4u0NZn/P0=
X-Received: by 2002:a05:6871:d20d:b0:288:4a73:1fe6 with SMTP id
 586e51a60fabf-2949d1eba5cmr10229030fac.21.1730837855120; Tue, 05 Nov 2024
 12:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104222855.3959267-1-superm1@kernel.org>
In-Reply-To: <20241104222855.3959267-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Nov 2024 21:17:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iVfdfetFBrq93hcaTgVTN-=WoWYnK5G65q+kRA-qNtwQ@mail.gmail.com>
Message-ID: <CAJZ5v0iVfdfetFBrq93hcaTgVTN-=WoWYnK5G65q+kRA-qNtwQ@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: processor: Move arch_init_invariance_cppc() call later
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, Ivan Shapovalov <intelfx@intelfx.name>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:29=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> arch_init_invariance_cppc() is called at the end of
> acpi_cppc_processor_probe() in order to configure frequency invariance
> based upon the values from _CPC.
>
> This however doesn't work on AMD CPPC shared memory designs that have
> AMD preferred cores enabled because _CPC needs to be analyzed from all
> cores to judge if preferred cores are enabled.
>
> This issue manifests to users as a warning since commit 21fb59ab4b97
> ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn")=
:
> ```
> Could not retrieve highest performance (-19)
> ```
>
> However the warning isn't the cause of this, it was actually
> commit 279f838a61f9 ("x86/amd: Detect preferred cores in
> amd_get_boost_ratio_numerator()") which exposed the issue.
>
> To fix this problem, change arch_init_invariance_cppc() into a new weak
> symbol that is called at the end of acpi_processor_driver_init().
> Each architecture that supports it can declare the symbol to override
> the weak one.

"Define it for x86, in arch/x86/kernel/acpi/cppc.c, and for all of the
architectures using the generic arch_topology.c code."

> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ra=
tio_numerator()")
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>  * Drop macros and only use symbols
> v3:
>  * Weak symbol instead of macro to help riscv build failure
>  * Update commit message
>  * Add comment
> ---
>  arch/arm64/include/asm/topology.h | 4 ----
>  arch/x86/include/asm/topology.h   | 5 -----
>  arch/x86/kernel/acpi/cppc.c       | 7 ++++++-
>  drivers/acpi/cppc_acpi.c          | 6 ------
>  drivers/acpi/processor_driver.c   | 9 +++++++++
>  drivers/base/arch_topology.c      | 6 +++++-
>  include/acpi/processor.h          | 2 ++
>  include/linux/arch_topology.h     | 4 ----
>  8 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/t=
opology.h
> index 5fc3af9f8f29b..341174bf91063 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -26,10 +26,6 @@ void update_freq_counters_refs(void);
>  #define arch_scale_freq_invariant topology_scale_freq_invariant
>  #define arch_scale_freq_ref topology_get_freq_ref
>
> -#ifdef CONFIG_ACPI_CPPC_LIB
> -#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> -#endif
> -
>  /* Replace task scheduler's default cpu-invariant accounting */
>  #define arch_scale_cpu_capacity topology_get_cpu_scale
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topol=
ogy.h
> index aef70336d6247..92f3664dd933b 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -305,9 +305,4 @@ static inline void freq_invariance_set_perf_ratio(u64=
 ratio, bool turbo_disabled
>  extern void arch_scale_freq_tick(void);
>  #define arch_scale_freq_tick arch_scale_freq_tick
>
> -#ifdef CONFIG_ACPI_CPPC_LIB
> -void init_freq_invariance_cppc(void);
> -#define arch_init_invariance_cppc init_freq_invariance_cppc
> -#endif
> -
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 956984054bf30..aab9d0570841a 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -110,7 +110,7 @@ static void amd_set_max_freq_ratio(void)
>
>  static DEFINE_MUTEX(freq_invariance_lock);
>
> -void init_freq_invariance_cppc(void)
> +static inline void init_freq_invariance_cppc(void)
>  {
>         static bool init_done;
>
> @@ -127,6 +127,11 @@ void init_freq_invariance_cppc(void)
>         mutex_unlock(&freq_invariance_lock);
>  }
>
> +void acpi_processor_init_invariance_cppc(void)
> +{
> +       init_freq_invariance_cppc();
> +}
> +
>  /*
>   * Get the highest performance register value.
>   * @cpu: CPU from which to get highest performance.
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1a40f0514eaa3..5c0cc7aae8726 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
>   *  )
>   */
>
> -#ifndef arch_init_invariance_cppc
> -static inline void arch_init_invariance_cppc(void) { }
> -#endif
> -
>  /**
>   * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
>   * @pr: Ptr to acpi_processor containing this CPU's logical ID.
> @@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                 goto out_free;
>         }
>
> -       arch_init_invariance_cppc();
> -
>         kfree(output.pointer);
>         return 0;
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index cb52dd000b958..3b281bc1e73c3 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -237,6 +237,9 @@ static struct notifier_block acpi_processor_notifier_=
block =3D {
>         .notifier_call =3D acpi_processor_notifier,
>  };
>
> +void __weak acpi_processor_init_invariance_cppc(void)
> +{ }
> +
>  /*
>   * We keep the driver loaded even when ACPI is not running.
>   * This is needed for the powernow-k8 driver, that works even without
> @@ -270,6 +273,12 @@ static int __init acpi_processor_driver_init(void)
>                                   NULL, acpi_soft_cpu_dead);
>
>         acpi_processor_throttling_init();
> +
> +       /*
> +        * Frequency invariance calculations on AMD platforms can't be ru=
n until
> +        * after acpi_cppc_processor_probe() has been called for all onli=
ne CPUs
> +        */
> +       acpi_processor_init_invariance_cppc();
>         return 0;
>  err:
>         driver_unregister(&acpi_processor_driver);
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75fcb75d55155..3ebe77566788b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -366,7 +366,7 @@ void __weak freq_inv_set_max_ratio(int cpu, u64 max_r=
ate)
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  #include <acpi/cppc_acpi.h>
>
> -void topology_init_cpu_capacity_cppc(void)
> +static inline void topology_init_cpu_capacity_cppc(void)
>  {
>         u64 capacity, capacity_scale =3D 0;
>         struct cppc_perf_caps perf_caps;
> @@ -417,6 +417,10 @@ void topology_init_cpu_capacity_cppc(void)
>  exit:
>         free_raw_capacity();
>  }
> +void acpi_processor_init_invariance_cppc(void)
> +{
> +       topology_init_cpu_capacity_cppc();
> +}
>  #endif
>
>  #ifdef CONFIG_CPU_FREQ
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index e6f6074eadbf3..a17e97e634a68 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -465,4 +465,6 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int =
cpu);
>  extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
>  #endif
>
> +void acpi_processor_init_invariance_cppc(void);
> +
>  #endif
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.=
h
> index b721f360d7592..4a952c4885edc 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -11,10 +11,6 @@
>  void topology_normalize_cpu_scale(void);
>  int topology_update_cpu_topology(void);
>
> -#ifdef CONFIG_ACPI_CPPC_LIB
> -void topology_init_cpu_capacity_cppc(void);
> -#endif
> -
>  struct device_node;
>  bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>
>
> base-commit: 6db936d4ac0fe281af48b4d1ebf69b1523bbac31
> --
> 2.43.0
>

