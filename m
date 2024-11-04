Return-Path: <linux-acpi+bounces-9288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF09BC03A
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 22:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E0B282A80
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8981FA272;
	Mon,  4 Nov 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfaX+/Hx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6001E5725;
	Mon,  4 Nov 2024 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756587; cv=none; b=OZDpAotl5B4dJPx72g8YlReuvK7MxJexXCBaoRn7n9mbZ1PbQYRfkcECbjt9/N7UKRb+3gphV1Z5VBS9q3d5GrVZIZaU+r+M26pAscze6eXjznoZmd1skPVeLZbmtc7dMCAqvPVUIXgAVbuuEbxiK0Tdrd5I62KnWI4tjfboXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756587; c=relaxed/simple;
	bh=lGDOwJuM3Rye9OegiRmFrnI90zMsxUdYSUdClTWbAac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUNZU7qZ4fujnAOL8sYThMKVaH/bAgSzcqGg4BeoGKODzFzzPKQHkYUHazPfP7j9p861K5M+REQGoRPu/yRlOum2xd96x5lt2qBxP3mJZMR02hcIbBAdyOfMIYkqmzFsMMDveO0kD0W6AQjdpgZK0kJmH5NsLhurVfNI49dPfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfaX+/Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B458AC4CED1;
	Mon,  4 Nov 2024 21:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730756586;
	bh=lGDOwJuM3Rye9OegiRmFrnI90zMsxUdYSUdClTWbAac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qfaX+/HxofYcLJD8SHEXLctP9N+xESKKjyXjPk3OcBHKs6KhWrqJIoHKhu1/cBpPx
	 AcY4upibDEA/hmDjjl3iU2JqtDecQgjUe7B/QO1lueMDxb5/4gh1hTRqsavrwHPkrz
	 eIPK8boDkrZncpLpez61EutK3NuhHO2M5G8mSGVuaEihvBViTg6Mkct2bsWuPry3Ql
	 Dq+fZf9lHqK50VNnNxbZg1yOlVQ/4gqaW0nQo4rSmjBx0vYw22r/Focfpt2mPmnnJm
	 fcvAsKRJDduzBYWq7XIVUMcuTaTgYYdF4WlBp/z1FkYm/2w0bFM0Engaj0j6z5XrvR
	 klttCNhUDWdNA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e63e5c0c50so2450735b6e.0;
        Mon, 04 Nov 2024 13:43:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUFGY5O3FUz6btNNSUMYkaYC/ds8Sq5k/dce1CeqksX/XTbi4eaW8grx6te2REpuciSmrFaKqg79bq/Cl8@vger.kernel.org, AJvYcCVfmuIMm1QHOqNBU/C8OqasFDCpVc+fBREEDbHRS0VlzDSw9w28qiHj2kucJ0ykOkfI/vAzRmluCxBF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yRSU5tOq/Dab94JNNPicWsOYlRDMT2glhX9Zr2yvZZApcH5P
	TyLJWVb1qOH/4oq8kEcEsXognAdu9180V6VrnSIF3NvfMZHMMhiAsln8Az0qPWpCr4atnCJswJu
	3NPcCJZtoJG/UTm53AC26GTiF1D4=
X-Google-Smtp-Source: AGHT+IEtcjMaDjrsZxPW+8CgSKBK4Vp3MbFHNAYHa0VbF3HFMyemSuK4Y0SttLbTJDx2UX6EZeZsC1YAc6vW4V8Nct8=
X-Received: by 2002:a05:6808:2384:b0:3e6:6507:6b90 with SMTP id
 5614622812f47-3e74c39f28amr8714762b6e.11.1730756585975; Mon, 04 Nov 2024
 13:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104205446.3874509-1-superm1@kernel.org> <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
 <814adf82-99ec-44f8-83d0-6540f2cccbcb@kernel.org> <25d7112c4ca6d84e6a1289663cbf172bf7709fee.camel@intelfx.name>
In-Reply-To: <25d7112c4ca6d84e6a1289663cbf172bf7709fee.camel@intelfx.name>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 22:42:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j++NyxtT6KKFUbMhenrQU1g8wLirgz+RC2wvHgHk7qjg@mail.gmail.com>
Message-ID: <CAJZ5v0j++NyxtT6KKFUbMhenrQU1g8wLirgz+RC2wvHgHk7qjg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: processor: Move arch_init_invariance_cppc() call later
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:38=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> On 2024-11-04 at 15:14 -0600, Mario Limonciello wrote:
> > On 11/4/2024 15:10, Rafael J. Wysocki wrote:
> > > On Mon, Nov 4, 2024 at 9:54=E2=80=AFPM Mario Limonciello <superm1@ker=
nel.org> wrote:
> > > >
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > >
> > > > arch_init_invariance_cppc() is called at the end of
> > > > acpi_cppc_processor_probe() in order to configure frequency invaria=
nce
> > > > based upon the values from _CPC.
> > > >
> > > > This however doesn't work on AMD CPPC shared memory designs that ha=
ve
> > > > AMD preferred cores enabled because _CPC needs to be analyzed from =
all
> > > > cores to judge if preferred cores are enabled.
> > > >
> > > > This issue manifests to users as a warning since commit 21fb59ab4b9=
7
> > > > ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to =
warn"):
> > > > ```
> > > > Could not retrieve highest performance (-19)
> > > > ```
> > > >
> > > > However the warning isn't the cause of this, it was actually
> > > > commit 279f838a61f9 ("x86/amd: Detect preferred cores in
> > > > amd_get_boost_ratio_numerator()") which exposed the issue.
> > > >
> > > > To fix this problem, change arch_init_invariance_cppc() into a new =
weak
> > > > symbol that is called at the end of acpi_processor_driver_init().
> > > > Each architecture that supports it can declare the symbol to overri=
de
> > > > the weak one.
> > > >
> > > > Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_bo=
ost_ratio_numerator()")
> > > > Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> > > > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > ---
> > > > v3:
> > > >   * Weak symbol instead of macro to help riscv build failure
> > > >   * Update commit message
> > > >   * Add comment
> > > > ---
> > > >   arch/arm64/include/asm/topology.h | 2 +-
> > > >   arch/x86/include/asm/topology.h   | 2 +-
> > > >   drivers/acpi/cppc_acpi.c          | 6 ------
> > > >   drivers/acpi/processor_driver.c   | 9 +++++++++
> > > >   include/acpi/processor.h          | 2 ++
> > > >   5 files changed, 13 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include=
/asm/topology.h
> > > > index 5fc3af9f8f29b..8a1860877967e 100644
> > > > --- a/arch/arm64/include/asm/topology.h
> > > > +++ b/arch/arm64/include/asm/topology.h
> > > > @@ -27,7 +27,7 @@ void update_freq_counters_refs(void);
> > > >   #define arch_scale_freq_ref topology_get_freq_ref
> > > >
> > > >   #ifdef CONFIG_ACPI_CPPC_LIB
> > > > -#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> > > > +#define acpi_processor_init_invariance_cppc topology_init_cpu_capa=
city_cppc
> > > >   #endif
> > > >
> > > >   /* Replace task scheduler's default cpu-invariant accounting */
> > > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm=
/topology.h
> > > > index aef70336d6247..0fb705524aeaa 100644
> > > > --- a/arch/x86/include/asm/topology.h
> > > > +++ b/arch/x86/include/asm/topology.h
> > > > @@ -307,7 +307,7 @@ extern void arch_scale_freq_tick(void);
> > > >
> > > >   #ifdef CONFIG_ACPI_CPPC_LIB
> > > >   void init_freq_invariance_cppc(void);
> > > > -#define arch_init_invariance_cppc init_freq_invariance_cppc
> > > > +#define acpi_processor_init_invariance_cppc init_freq_invariance_c=
ppc
> > > >   #endif
> > > >
> > > >   #endif /* _ASM_X86_TOPOLOGY_H */
> > > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > > index 1a40f0514eaa3..5c0cc7aae8726 100644
> > > > --- a/drivers/acpi/cppc_acpi.c
> > > > +++ b/drivers/acpi/cppc_acpi.c
> > > > @@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
> > > >    *  )
> > > >    */
> > > >
> > > > -#ifndef arch_init_invariance_cppc
> > > > -static inline void arch_init_invariance_cppc(void) { }
> > > > -#endif
> > > > -
> > > >   /**
> > > >    * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
> > > >    * @pr: Ptr to acpi_processor containing this CPU's logical ID.
> > > > @@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_proce=
ssor *pr)
> > > >                  goto out_free;
> > > >          }
> > > >
> > > > -       arch_init_invariance_cppc();
> > > > -
> > > >          kfree(output.pointer);
> > > >          return 0;
> > > >
> > > > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/process=
or_driver.c
> > > > index cb52dd000b958..3b281bc1e73c3 100644
> > > > --- a/drivers/acpi/processor_driver.c
> > > > +++ b/drivers/acpi/processor_driver.c
> > > > @@ -237,6 +237,9 @@ static struct notifier_block acpi_processor_not=
ifier_block =3D {
> > > >          .notifier_call =3D acpi_processor_notifier,
> > > >   };
> > > >
> > > > +void __weak acpi_processor_init_invariance_cppc(void)
> > > > +{ }
> > >
> > > Does this actually work if acpi_processor_init_invariance_cppc is a
> > > macro?  How does the compiler know that it needs to use
> > > init_freq_invariance_cppc() instead of this?
> > >
> > > It would work if a __weak definition of init_freq_invariance_cppc() w=
as present.
> >
> > I also wasn't sure, so I explicitly added some tracing in
> > init_freq_invariance_cppc() to make sure it got called and checked it
> > (GCC 13.2.0).
>
> Aren't C macros substituted strictly lexically, i.e. if the #define is
> present by the time the function definition is parsed, it's just
>
> void __weak acpi_processor_init_invariance_cppc(void) {}
> -> void __weak init_freq_invariance_cppc(void) {}
>
> ? So it _is_ a weak definition of init_freq_invariance_cppc().

Yes, you're right.

> >
> > But I'll admit it's a confusing behavior.  If you think it's too
> > confusing I'll swap it around to just axe the macros.
>
> ...That said, it does look kinda confusing. Seems to be norm for that
> arch/ header file though.

So let's not make it even more confusing than it already is.

