Return-Path: <linux-acpi+bounces-9280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C279BBC3A
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 18:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E801F22686
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38F1C729E;
	Mon,  4 Nov 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvIOCQQq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120E1C726D;
	Mon,  4 Nov 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742225; cv=none; b=RGUHNR10Upms02TN560tr44SsyDiw+H0a0xj7RMbjMkA1RqUI4bUIPByBmZBngX4cCxj9DBJ7nB0Jvq9iiyPSsNv+ixr1Ev+hvlPyx6jvsYZen52s554QPPpy727rDlYAQDEMXVQXj9R+VqN/tyjI79klxmIlVOw7RQfJEi6i3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742225; c=relaxed/simple;
	bh=J8LlqVYYq3R/0H8OEfL50NRkZISuqlBHbDCOynavLk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJMJFCtGBJT2ZXF5vzwVuPa+4im6pGSJbHilVTja/UoNxGpUQirxVaCVprDEN5UtjlScBpEJZlFALQGHIHeJJvusyWCHgqfApJ0xt2+1MQ42P22BANTpRTxBjy2j84ankTRTZ/1and0fuI9Km+RCSvngasicnvmtpU/2U29c/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvIOCQQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2FDC4CED0;
	Mon,  4 Nov 2024 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742225;
	bh=J8LlqVYYq3R/0H8OEfL50NRkZISuqlBHbDCOynavLk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EvIOCQQq8dsOUnR17WWrgCc0EApg4bt6I0y+pVAcEkIQRDGK1r3D2vWYfDIOu7Fms
	 XSzQ4mW4qrziE0lyiCPhjo/ND+LAmoletOlGFYw61eY9IfkaSk81CyQ6JwTgn0Mhxe
	 BetbySVAOdjfzB/gcO2uZ/hSaQWY6TC7qKDmVAsnGSy2R350SsvbunMz2gk17qmNfB
	 33VUOsnv0kZNw6MkWxeE1YH26PsFNFrz5T1wetzv49mdzfclD1GwZngV+MHZJTJNZ+
	 WmjedcnIpEW7W8ZpBvXVX4RBJMXkT6IRbQT5kUivBgDGkcYaPwSPKcPpBX+qabmd08
	 JQ2VwNqr0wpIQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288642376bcso2186126fac.1;
        Mon, 04 Nov 2024 09:43:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcrUHxbmxnEOxIqxUXccO9ARTTI9GggBbymCTsw1OqpeYh+VoJw4CQQ6MzkbRtb3+grXX7GF2GI9gUACg8@vger.kernel.org, AJvYcCWkQI7XjjnGQ9sJvinEw1Mp/Nfntm1OWh0racLXKrZict+36XpvqepWthXKDmn4l5NdMHkm/n44ym2k@vger.kernel.org
X-Gm-Message-State: AOJu0YxcyD/jb7EcK96ItT+B1fnkU1yF4ZfBCFnhMisvtYuKPDIiISr2
	W0h2f38qgO8dC1qTAVNZt5Hbayo/qDcU6Cu00AddgvWyL4d8hbeA43Yy8V0uzrguW+1wZsyt5+4
	7xwDcldlbIxkqrA5rqrPCpcPORj8=
X-Google-Smtp-Source: AGHT+IGh8Gegx/EAbmD63BSOr11g7bdPJDQ4H+ukcOlE3A/PXQmDmQ7t8bPAISa/ImetuzUTC9h2NYwClNVPgZoZKI8=
X-Received: by 2002:a05:6870:8a0a:b0:270:172c:32ae with SMTP id
 586e51a60fabf-2949f01b7bemr10761047fac.32.1730742224408; Mon, 04 Nov 2024
 09:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102032353.2372544-1-superm1@kernel.org> <CAJZ5v0hVbJctHHMS4=c74Y1+qOw2VRfevkPi9W99nHHPejNw0w@mail.gmail.com>
 <c72e23ee-4a53-4f3b-8387-bd9b77c0a3fe@kernel.org>
In-Reply-To: <c72e23ee-4a53-4f3b-8387-bd9b77c0a3fe@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 18:43:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4eg0LkwYrXp7gS2Lu4=i5WQ-HHonR5hL2nmZ4EMT8ew@mail.gmail.com>
Message-ID: <CAJZ5v0h4eg0LkwYrXp7gS2Lu4=i5WQ-HHonR5hL2nmZ4EMT8ew@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: Move arch_init_invariance_cppc() call later
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

On Mon, Nov 4, 2024 at 6:17=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 11/4/2024 10:55, Rafael J. Wysocki wrote:
> > On Sat, Nov 2, 2024 at 4:24=E2=80=AFAM Mario Limonciello <superm1@kerne=
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
> >> To fix this problem, push the call to the arch_init_invariance_cppc()
> >> macro to the end of acpi_processor_driver_init().
> >>
> >> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost=
_ratio_numerator()")
> >> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> >> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v1->v2:
> >>   * Fix LKP robot issue when CONFIG_ACPI_CPPC_LIB not defined
> >> ---
> >>   arch/x86/include/asm/topology.h | 2 ++
> >>   drivers/acpi/cppc_acpi.c        | 6 ------
> >>   drivers/acpi/processor_driver.c | 1 +
> >>   3 files changed, 3 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/to=
pology.h
> >> index abe3a8f22cbd..b04c5db7e945 100644
> >> --- a/arch/x86/include/asm/topology.h
> >> +++ b/arch/x86/include/asm/topology.h
> >> @@ -295,6 +295,8 @@ extern void arch_scale_freq_tick(void);
> >>   #ifdef CONFIG_ACPI_CPPC_LIB
> >>   void init_freq_invariance_cppc(void);
> >>   #define arch_init_invariance_cppc init_freq_invariance_cppc
> >> +#else
> >> +static inline void arch_init_invariance_cppc(void) { }
> >>   #endif
> >>
> >>   #endif /* _ASM_X86_TOPOLOGY_H */
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index ed91dfd4fdca..9d48cd706659 100644
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
> >> index cb52dd000b95..59620e7bc664 100644
> >> --- a/drivers/acpi/processor_driver.c
> >> +++ b/drivers/acpi/processor_driver.c
> >> @@ -270,6 +270,7 @@ static int __init acpi_processor_driver_init(void)
> >>                                    NULL, acpi_soft_cpu_dead);
> >>
> >>          acpi_processor_throttling_init();
> >> +       arch_init_invariance_cppc();
> >>          return 0;
> >>   err:
> >>          driver_unregister(&acpi_processor_driver);
> >> --
> >
> > Applied as a fix for 6.12-rc7.
> >
> > However, it would be good to add a comment explaining why
> > acpi_processor_driver_init() calls arch_init_invariance_cppc() at the
> > end.  The ACPI processor driver and CPPC are not otherwise related I
> > think?
>
> Sure, I'm thinking a comment like this.
>
> /*
>   * Frequency invariance calculations on AMD platforms can't be run until
>   * _CPC has been evaluated on all processors which will only happen
>   * after probing is complete.
>   */

It would be more precise to say "after acpi_cppc_processor_probe() has
been called for all online CPUs".

Which among other things means that the ordering of this call with
respect to acpi_processor_throttling_init() does not matter.

> If that sounds good do you want to squash it in?  Or if you would prefer
> another commit tacked on that's no problem I'll do that.

IMV a separate patch for 6.13 will be fine.

