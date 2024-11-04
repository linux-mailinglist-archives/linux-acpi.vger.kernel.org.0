Return-Path: <linux-acpi+bounces-9275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEE19BBAA8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5221C22872
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525831C3034;
	Mon,  4 Nov 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0U7Al4L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFD1C2DB0;
	Mon,  4 Nov 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739329; cv=none; b=NNKofDDnIx1Qzgiy88KVTeLdFC3XY9a8qEgx1KygqpZVnHUTfgoobjtd3RQZg2EJZAf59CH4fsvoA29mW5zrOrlM2b0PHUKiEhRr/pxvmJKTl8NCmj/CZAcQSWWo1fX2GogNNCQDnTXELvtlUT8/DhIxhCEY1Y9viKGTW4mfaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739329; c=relaxed/simple;
	bh=s/cEyXTysCb0R1C2uiaHoV1C76ecFccLT4ZoCw7EVLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsrCS7WkrROsItna8Hyq28UEyJgA4aOY6CbM4kGRNhX3laGbk24YILrbDjV7z7J49PuiLQ/PBbP959czAAPJ/zi9zxnYfU9EgLk+jM8eeKYZb187PpJf3F/vCb7PEhrh/7fuWFC/r9k/vh2NypP1e7A8LXksSnSo/tA/dKvThEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0U7Al4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4DCC4CED6;
	Mon,  4 Nov 2024 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730739328;
	bh=s/cEyXTysCb0R1C2uiaHoV1C76ecFccLT4ZoCw7EVLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a0U7Al4Lm91F/JfDhvMobWgEmIYWD2kx/rDC9bZe52JYZxyN+5LKGnFF3Fthru0iL
	 RJzei+7ojNdteW2eVx0rbsdcIzlCUjzCrHXPcAVQiZN5j320llmWd/eGotVPsozXyG
	 8sIxh3b+BDDjiW4GWVSh7XyePgCT3JjiBgePxE3dPvJxuyLgc3xcdqNOgDYkxDGkDS
	 01ojCVK10LLdg8Ddq+LzoH5jY48UMC3rLn/jqm99FLC8QA0helJQU12bUiRXVFYK5z
	 DMpq9nb0Hgp774gnDKJRAgyQ+0eH4Nv8IoPcY4kED5uMaegjERIwx7MiJQhtCpbmUb
	 j+kfEeHUl5zNw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e63e5c0c50so2229544b6e.0;
        Mon, 04 Nov 2024 08:55:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2ldLOS1TOlKZPcbVsQ3W6+7R5oLJBEXtYponKjwhu+l1nFlc8iBCOZ/VNVy7VwjDHPuaOSEp6+x7AAxQw@vger.kernel.org, AJvYcCWCdZ6cKKutr8e6UdecCW85LjJJCDZ1vJ7btaI0dAyZQ2UTswSsMG53P5JMMUSTNmoMyoUKPDJDRsko@vger.kernel.org
X-Gm-Message-State: AOJu0Yyts3M+ysQ5AsIU5A9/lilS83ixG0M2/lBtMf4JLyKVkYzK2v2B
	hkSvQfhmoU6pZk5m5+ypVd4n+6bYxOlHVChPAZ5Qc9K2krB5iXGImBhFMhQ9sCko2bqUuoBPOWL
	H8PEPlMLsEnQ/+6L6YgCeETAHwKM=
X-Google-Smtp-Source: AGHT+IEHt7vhaUxYa6RIIorHyqreoOHTEnTqJZWBB2MMj02UvbDZfcO0Q8cS//8Lvhp49uVO7OWHUySZ1hHtxnH9cck=
X-Received: by 2002:a05:6808:15a8:b0:3e5:fd5f:e881 with SMTP id
 5614622812f47-3e74c3daf85mr6664430b6e.16.1730739327854; Mon, 04 Nov 2024
 08:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102032353.2372544-1-superm1@kernel.org>
In-Reply-To: <20241102032353.2372544-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 17:55:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVbJctHHMS4=c74Y1+qOw2VRfevkPi9W99nHHPejNw0w@mail.gmail.com>
Message-ID: <CAJZ5v0hVbJctHHMS4=c74Y1+qOw2VRfevkPi9W99nHHPejNw0w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: Move arch_init_invariance_cppc() call later
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

On Sat, Nov 2, 2024 at 4:24=E2=80=AFAM Mario Limonciello <superm1@kernel.or=
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
> To fix this problem, push the call to the arch_init_invariance_cppc()
> macro to the end of acpi_processor_driver_init().
>
> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ra=
tio_numerator()")
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Fix LKP robot issue when CONFIG_ACPI_CPPC_LIB not defined
> ---
>  arch/x86/include/asm/topology.h | 2 ++
>  drivers/acpi/cppc_acpi.c        | 6 ------
>  drivers/acpi/processor_driver.c | 1 +
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topol=
ogy.h
> index abe3a8f22cbd..b04c5db7e945 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -295,6 +295,8 @@ extern void arch_scale_freq_tick(void);
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  void init_freq_invariance_cppc(void);
>  #define arch_init_invariance_cppc init_freq_invariance_cppc
> +#else
> +static inline void arch_init_invariance_cppc(void) { }
>  #endif
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ed91dfd4fdca..9d48cd706659 100644
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
> index cb52dd000b95..59620e7bc664 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -270,6 +270,7 @@ static int __init acpi_processor_driver_init(void)
>                                   NULL, acpi_soft_cpu_dead);
>
>         acpi_processor_throttling_init();
> +       arch_init_invariance_cppc();
>         return 0;
>  err:
>         driver_unregister(&acpi_processor_driver);
> --

Applied as a fix for 6.12-rc7.

However, it would be good to add a comment explaining why
acpi_processor_driver_init() calls arch_init_invariance_cppc() at the
end.  The ACPI processor driver and CPPC are not otherwise related I
think?

