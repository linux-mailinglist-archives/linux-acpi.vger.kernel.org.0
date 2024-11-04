Return-Path: <linux-acpi+bounces-9286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564C09BC02E
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 22:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D8B1F22785
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862251E5725;
	Mon,  4 Nov 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkXOin3e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2B70816;
	Mon,  4 Nov 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756246; cv=none; b=XKvrru5Vz2hDL/qx1kGmfcnDZH7LGQlkPt4jSXcW1aJTdp6ycHmF6F4TYRn7kDyM97UfHu3EkvXM8Rk70qTTikRXaj587dTykyTlJlOHCu3HsPMWQsjH529kg0zFxkhYFKBe/uAmgaY7UX5TYJlApqV2Xc3jFCtIdcPvnjG9a2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756246; c=relaxed/simple;
	bh=sE4FbiIUhyhzwgB2znaex+Airlfm0HvtGl+pHgItpbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEI2xyo/Lrhgr8OTTkk+6Sl8xRBGDzGgMhGmS1T6yT4wrrIUU7FuARMu4EavFa+vB/dWRZ3VdQWCs/UTuq6l4VjMU7j+nSZ92NjAHpviNWhFYmSbtyFsyVIPhmOzUu82Pf+hrEFufg0pdgL3HhrObi69zTJqK/wzDTjXMVtpLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkXOin3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA680C4CED9;
	Mon,  4 Nov 2024 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730756245;
	bh=sE4FbiIUhyhzwgB2znaex+Airlfm0HvtGl+pHgItpbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SkXOin3elmbnU2GcAdVrakJZ7sUalR0kYi0ToKZshDdcuWx4SQ8/nbCXfmc03YXGy
	 sO85wb3ahYSL5c0YP2/TXESWtzd2HBzPvmhUiW7m0hcdNhvToWZBmJiDQH3g0J8Zi7
	 cPI7Q4DOzNoqY7gS0pnalal5cRX1fV68mRei/nODvaspbj5Bmz4erglgGaMYyw65ae
	 fkG5X0r20yQaJqayBdgfOkJ1kMIjIQtAlTYbo6bJ7Tiy85LO3jBtcnr592qhnABeCE
	 FPTeQwjlbwQilVPbjeR+OjgLPSF2fUAs8/plaZOM99pxm43BB8qpuaLwXBx0uNZVEA
	 2qV1okcVvabQw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc0dbc65dso2704743eaf.1;
        Mon, 04 Nov 2024 13:37:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3H7RiUTaaSx9gVa7TydAYaXWqAbjA3OlQ0/mzeKgN5EzRwYVlFRHoMv1ROrR4QKYqsYHaGuU/Nwv4@vger.kernel.org, AJvYcCWpxZ7GYxun6sFGzBwIgN7FDPlRynI/F23LbEQzKYRNflv+HmJFh1ilKwGyFoT6q1gdRmIDUpiML1ImLj8r@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS6vA6yAdELMkCwF9N7DUaWxxhCrK3vfnB11hzLmQKNkV+akY
	7H0w7fgNOU+1cIqHulf9TxaU3UxX7H68cDUOrtw9Q17pVX/zswYmdqikTY3PucvNwGJO2C6SAzI
	Fawf68NQdvPy9oBidMizZqJuo0Z8=
X-Google-Smtp-Source: AGHT+IHw6N6oxx7+JdN3NxJHW0dBEPHADkEijAQNnW7uGiscmEKavjgipJwIFSt5wMUsESYxWNEbL7CySMqzYKCguMs=
X-Received: by 2002:a05:6870:200c:b0:277:e6bc:330c with SMTP id
 586e51a60fabf-29051d3cb86mr28744118fac.29.1730756245052; Mon, 04 Nov 2024
 13:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104205446.3874509-1-superm1@kernel.org> <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
 <814adf82-99ec-44f8-83d0-6540f2cccbcb@kernel.org>
In-Reply-To: <814adf82-99ec-44f8-83d0-6540f2cccbcb@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 22:37:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gCcZ81MtiGVM6PVUFyYVPWcfQ81AOmsrAh+svbLZVCtg@mail.gmail.com>
Message-ID: <CAJZ5v0gCcZ81MtiGVM6PVUFyYVPWcfQ81AOmsrAh+svbLZVCtg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: processor: Move arch_init_invariance_cppc() call later
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, 
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

On Mon, Nov 4, 2024 at 10:14=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 11/4/2024 15:10, Rafael J. Wysocki wrote:
> > On Mon, Nov 4, 2024 at 9:54=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> arch_init_invariance_cppc() is called at the end of
> >> acpi_cppc_processor_probe() in order to configure frequency invariance
> >> based upon the values from _CPC.
> >>
> >> This however doesn't work on AMD CPPC shared memory designs that have
> >> AMD preferred cores enabled because _CPC needs to be analyzed from all
> >> cores to judge if preferred cores are enabled.
> >>
> >> This issue manifests to users as a warning since commit 21fb59ab4b97
> >> ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to war=
n"):
> >> ```
> >> Could not retrieve highest performance (-19)
> >> ```
> >>
> >> However the warning isn't the cause of this, it was actually
> >> commit 279f838a61f9 ("x86/amd: Detect preferred cores in
> >> amd_get_boost_ratio_numerator()") which exposed the issue.
> >>
> >> To fix this problem, change arch_init_invariance_cppc() into a new wea=
k
> >> symbol that is called at the end of acpi_processor_driver_init().
> >> Each architecture that supports it can declare the symbol to override
> >> the weak one.
> >>
> >> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost=
_ratio_numerator()")
> >> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> >> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v3:
> >>   * Weak symbol instead of macro to help riscv build failure
> >>   * Update commit message
> >>   * Add comment
> >> ---
> >>   arch/arm64/include/asm/topology.h | 2 +-
> >>   arch/x86/include/asm/topology.h   | 2 +-
> >>   drivers/acpi/cppc_acpi.c          | 6 ------
> >>   drivers/acpi/processor_driver.c   | 9 +++++++++
> >>   include/acpi/processor.h          | 2 ++
> >>   5 files changed, 13 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/as=
m/topology.h
> >> index 5fc3af9f8f29b..8a1860877967e 100644
> >> --- a/arch/arm64/include/asm/topology.h
> >> +++ b/arch/arm64/include/asm/topology.h
> >> @@ -27,7 +27,7 @@ void update_freq_counters_refs(void);
> >>   #define arch_scale_freq_ref topology_get_freq_ref
> >>
> >>   #ifdef CONFIG_ACPI_CPPC_LIB
> >> -#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> >> +#define acpi_processor_init_invariance_cppc topology_init_cpu_capacit=
y_cppc
> >>   #endif
> >>
> >>   /* Replace task scheduler's default cpu-invariant accounting */
> >> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/to=
pology.h
> >> index aef70336d6247..0fb705524aeaa 100644
> >> --- a/arch/x86/include/asm/topology.h
> >> +++ b/arch/x86/include/asm/topology.h
> >> @@ -307,7 +307,7 @@ extern void arch_scale_freq_tick(void);
> >>
> >>   #ifdef CONFIG_ACPI_CPPC_LIB
> >>   void init_freq_invariance_cppc(void);
> >> -#define arch_init_invariance_cppc init_freq_invariance_cppc
> >> +#define acpi_processor_init_invariance_cppc init_freq_invariance_cppc
> >>   #endif
> >>
> >>   #endif /* _ASM_X86_TOPOLOGY_H */
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index 1a40f0514eaa3..5c0cc7aae8726 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
> >>    *  )
> >>    */
> >>
> >> -#ifndef arch_init_invariance_cppc
> >> -static inline void arch_init_invariance_cppc(void) { }
> >> -#endif
> >> -
> >>   /**
> >>    * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
> >>    * @pr: Ptr to acpi_processor containing this CPU's logical ID.
> >> @@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_processo=
r *pr)
> >>                  goto out_free;
> >>          }
> >>
> >> -       arch_init_invariance_cppc();
> >> -
> >>          kfree(output.pointer);
> >>          return 0;
> >>
> >> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_=
driver.c
> >> index cb52dd000b958..3b281bc1e73c3 100644
> >> --- a/drivers/acpi/processor_driver.c
> >> +++ b/drivers/acpi/processor_driver.c
> >> @@ -237,6 +237,9 @@ static struct notifier_block acpi_processor_notifi=
er_block =3D {
> >>          .notifier_call =3D acpi_processor_notifier,
> >>   };
> >>
> >> +void __weak acpi_processor_init_invariance_cppc(void)
> >> +{ }
> >
> > Does this actually work if acpi_processor_init_invariance_cppc is a
> > macro?  How does the compiler know that it needs to use
> > init_freq_invariance_cppc() instead of this?
> >
> > It would work if a __weak definition of init_freq_invariance_cppc() was=
 present.
>
> I also wasn't sure, so I explicitly added some tracing in
> init_freq_invariance_cppc() to make sure it got called and checked it
> (GCC 13.2.0).
>
> But I'll admit it's a confusing behavior.  If you think it's too
> confusing I'll swap it around to just axe the macros.

Yes, please.

I'm kind of worried that different compilers may do different things
here (say clang vs gcc) and it really is confusing.

