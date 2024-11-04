Return-Path: <linux-acpi+bounces-9284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60079BBFC1
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 22:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3764A1F23352
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9E1FA265;
	Mon,  4 Nov 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnEKnPxe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D801C876D;
	Mon,  4 Nov 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754672; cv=none; b=uHAridVcD40JiYYozOquQBS4bgKbxoLhHY0abfzWWkI5xGhFkvvBUq6vIc63aj5Avl9gYy3+m09AgUN8PnEA/58nIiVZrHxiHXRezCif3G4CXHvFULIxOWitmNWwceiplhdt4C8qTHnChpe1zHZgEwpiBSyyegsA8l4WCHd+QI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754672; c=relaxed/simple;
	bh=dQJAHDZPkaQ1elKvGqR9MWtVFrZyHUlneIbX5pzOS+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQHN0NLBfGj12lgaIQ5QSBWcej0lzelriqG435pZQPM0oYKaxuXisJDd7UF+kdqxSo8OGu2AELxqsfEKfzUAaoGhzTnGn/i/QOLE88MYzQ7zXAWaj/bLjL2HUVbdQ8tay1zKNvanK303M/zwKJ0u78yjMAFM9GE5GDhW0WozwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnEKnPxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395DCC4CED4;
	Mon,  4 Nov 2024 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730754672;
	bh=dQJAHDZPkaQ1elKvGqR9MWtVFrZyHUlneIbX5pzOS+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TnEKnPxeRrKFbMTFllInzcM0BJo2xxr2WING5KCnGthbWbKZsumWvyg+06BE0lE9p
	 ViAFFNF4i2aQdAGGqvXT3z+SuxAhbAgCIB/muDKeGtb6MOUv0glSQL3GqtU9aommq6
	 U9tllRXmOFe8y9pNbRv315v6jzOMLvQh3OKOiWtyG/FdLMr0e6LtOb18Fmv4MC9Cwm
	 RM+9vI/YCg9u8MkEPj2L+2STSwzyIEaFXry/6owX0SwJMXLEmL11VYsCzXHd3Ff3Mb
	 K9qszDpfOZDyAu9uDyF9UOlKmjfW4ypuGGbZPtOocjVR5rLXB/f1DHUo+VOkLFIevE
	 pSV0DX30iWdlw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2890f273296so1959947fac.2;
        Mon, 04 Nov 2024 13:11:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNIgxutHfPocDSY9rqlfWTtUXRvDcECFSy1bCBpAfR0oh1O9pCdmiiGvNf6MKYsgxDdyOc9VxJeTf+v8rL@vger.kernel.org, AJvYcCVnYCAlnQQTzvqbroXzXIGln4QCD4/PnHOGXgPtbmcJsPbNYIxIEn9femz0HDSjp//yc3g5JB34asH2@vger.kernel.org
X-Gm-Message-State: AOJu0YzrpkJF8mQ/k2+VG9bFQK66B/J333C3tVJbuSUUB+ahcDntxIU7
	7LcTZoALmXQJDoDpFomlDS5q/L5TX1YJhItQXaSpiEBQsq/UcokkJB5w54mpO1vusKyboGfX26l
	P4CuujSp4mYSpymg1arIO1yyXuIk=
X-Google-Smtp-Source: AGHT+IFd6T1TiQVm4YOoh3yySKzr912lkEMBOegtbZIx68PqAKR5+L/1VyOkj6rqHuuqQDbo5JCanwg42MhJ/a5AGoA=
X-Received: by 2002:a05:6870:d10e:b0:270:276d:fb54 with SMTP id
 586e51a60fabf-29051c0405fmr28384763fac.21.1730754671402; Mon, 04 Nov 2024
 13:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104205446.3874509-1-superm1@kernel.org>
In-Reply-To: <20241104205446.3874509-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 22:10:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
Message-ID: <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: processor: Move arch_init_invariance_cppc() call later
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

On Mon, Nov 4, 2024 at 9:54=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
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
>
> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ra=
tio_numerator()")
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Weak symbol instead of macro to help riscv build failure
>  * Update commit message
>  * Add comment
> ---
>  arch/arm64/include/asm/topology.h | 2 +-
>  arch/x86/include/asm/topology.h   | 2 +-
>  drivers/acpi/cppc_acpi.c          | 6 ------
>  drivers/acpi/processor_driver.c   | 9 +++++++++
>  include/acpi/processor.h          | 2 ++
>  5 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/t=
opology.h
> index 5fc3af9f8f29b..8a1860877967e 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -27,7 +27,7 @@ void update_freq_counters_refs(void);
>  #define arch_scale_freq_ref topology_get_freq_ref
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> -#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> +#define acpi_processor_init_invariance_cppc topology_init_cpu_capacity_c=
ppc
>  #endif
>
>  /* Replace task scheduler's default cpu-invariant accounting */
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topol=
ogy.h
> index aef70336d6247..0fb705524aeaa 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -307,7 +307,7 @@ extern void arch_scale_freq_tick(void);
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  void init_freq_invariance_cppc(void);
> -#define arch_init_invariance_cppc init_freq_invariance_cppc
> +#define acpi_processor_init_invariance_cppc init_freq_invariance_cppc
>  #endif
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
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

Does this actually work if acpi_processor_init_invariance_cppc is a
macro?  How does the compiler know that it needs to use
init_freq_invariance_cppc() instead of this?

It would work if a __weak definition of init_freq_invariance_cppc() was pre=
sent.

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
ne CPUs.
> +        */
> +       acpi_processor_init_invariance_cppc();
>         return 0;
>  err:
>         driver_unregister(&acpi_processor_driver);
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
>
> base-commit: 6db936d4ac0fe281af48b4d1ebf69b1523bbac31
> --
> 2.43.0
>

