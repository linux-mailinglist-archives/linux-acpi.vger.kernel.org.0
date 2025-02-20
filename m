Return-Path: <linux-acpi+bounces-11353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA70A3E4F1
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 20:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713AA19C1184
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B1624BD10;
	Thu, 20 Feb 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpPscSdC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76221421E;
	Thu, 20 Feb 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079218; cv=none; b=cfF7thq5lqPS0KHJOxoVEJVI64HzWFb3s0lBH2UWmsMldHLrNLH02R7PV5TSvbHc1I4q3OlZVAZV7WzMHxMaOzK7tcfp4snAtNwUYfvlvx8kcIVqJ5BuCijtPk6ZyDhx15UqcmX9AZOjH5eT9oJoWMuXI3emnY+5c8G6Tgw88o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079218; c=relaxed/simple;
	bh=eW/6EzbcporBkyLlJcaeoXZrQxrk9siNiuKHy0ERrCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqK1Vbfc4Olyue3gPvtF7DLFNZrwUDsOE97jPdHugbf/v5IfBApgmwCxcIxtFuO9x2Tp0+Lf8HHx+THYYVDWZG6ShU6GUhNYS71WDPO6GaEsk8M+1IZhi1lBJtKdAeXZThEyDpsvSFLPSktce8qciD44pD0Iy1KKMb0jMcqxwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpPscSdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2129FC4CEED;
	Thu, 20 Feb 2025 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740079218;
	bh=eW/6EzbcporBkyLlJcaeoXZrQxrk9siNiuKHy0ERrCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KpPscSdC77PJcDds3Sb3QPQ3KSEuyTfqCa5UE6SVRgFvdhVuiBF1TxAul/Pe1qapV
	 NExxM6LcQ9OIePFJnlxb+naHiko5X4cUjSqG1P605tGjaK9n81l++GXYwHNJJvrFla
	 mM1Bbz1m1YAEbb7xp1FCKW4XFyB+kJvIEbgXgQofbRecMUj7pHZ1s0KsKL/8vGbw88
	 yCjZs54GPLcKpojvC/t8fNZBf4m6AQuzHeNWJOIj2/xfVnTAuRKD+ll++bWo/SvBAX
	 HqBG5aFISe3kgZ4oHsoh6Cs0gnD6yLblYfvdWxcK6L/8Yv9Ni4rX8gW0YFPSxKEGYt
	 ltSt/y9/4TlcA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7272cc739f7so1295386a34.1;
        Thu, 20 Feb 2025 11:20:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG23FVA0yvh2oC7Dc/N2A6a4pRalUIkBt3bEuD/KRg6ca8OGZa78KrQ8YhnKtOjS3lnbK3N6AaGYIjcS30/QkNfA==@vger.kernel.org, AJvYcCW4jxQAPWWc+qgWv/TQr/cRjqGrWAjLaIqLF3On0UzIb1YAMkla/AuKn4ZNAPNDmgKP8ocSuUhSyPQO@vger.kernel.org, AJvYcCWN9nLb1cjkBOM73Wgl6MMuZ1b3yIF/nNs+8wNHGZiFmexcdmlDMc5QpDIBwl2UiL9ppGsw4IUyP31VcI0K@vger.kernel.org, AJvYcCWryDD2vSVyf6jWT0Z3vfl2fzM4Fnjf5rWGGbLx27Svvv6UXd091Atf3+afytKH3OdxuGgbLcYU1Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQh0FqmzZ3oa68wZ+Mo5PnzdWtkg+dwee8I4V+zC6Z3ThIKBz1
	FrSibQif2kmJwI6k577FJjFCmUkqWHwDLjb43ga8/RLwux/RBx4IsjPu0XleUn5Pnk9y0tlLdcr
	hEd7zL/X4vsTexFu6OU3GxWUTN9M=
X-Google-Smtp-Source: AGHT+IFtnS7H25wVx2/d7TV4BBEAl89/Nsh8UjACXA0fSLmiZXsB9lLv52jTs/zoA8/wVyPENkWf8sIOSW/K78QcbJU=
X-Received: by 2002:a05:6808:f0c:b0:3f4:7c4:ca27 with SMTP id
 5614622812f47-3f419f14e7amr3783387b6e.9.1740079217083; Thu, 20 Feb 2025
 11:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219184133.816753-1-sohil.mehta@intel.com> <20250219184133.816753-9-sohil.mehta@intel.com>
In-Reply-To: <20250219184133.816753-9-sohil.mehta@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:20:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iRxdpr9Lc9XJDbN5KbO6Ch=TEG39PC53gQJOTW_L9hnw@mail.gmail.com>
X-Gm-Features: AWEUYZkHa_18F7_XRL1v6sTvE25boM9CeaseQIQ_yIgYuXVNMo5-nm0iD0EOlkk
Message-ID: <CAJZ5v0iRxdpr9Lc9XJDbN5KbO6Ch=TEG39PC53gQJOTW_L9hnw@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] x86/acpi/cstate: Improve Intel Family model checks
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:29=E2=80=AFPM Sohil Mehta <sohil.mehta@intel.com>=
 wrote:
>
> Update the Intel Family checks to consistently use Family 15 instead of
> Family 0xF. Also, get rid of one of last usages of x86_model by using
> the new VFM checks.
>
> Update the incorrect comment since the check has changed[1][2] since the
> initial commit ee1ca48fae7e ("ACPI: Disable ARB_DISABLE on platforms
> where it is not needed").
>
> [1]: commit 3e2ada5867b7 ("ACPI: fix Compaq Evo N800c (Pentium 4m) boot
> hang regression") removed the P4 - Family 15.
>
> [2]: commit 03a05ed11529 ("ACPI: Use the ARB_DISABLE for the CPU which
> model id is less than 0x0f.") got rid of CORE_YONAH - Family 6, model E.
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that this series will go in via x86.

Thanks!

> ---
> v3: Pick up Dave's Ack.
> v2: Improve commit message.
> ---
>  arch/x86/include/asm/intel-family.h | 3 +++
>  arch/x86/kernel/acpi/cstate.c       | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/i=
ntel-family.h
> index 9e6a13f03f0e..deb17c9c21e5 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -187,6 +187,9 @@
>  #define INTEL_XEON_PHI_KNL             IFM(6, 0x57) /* Knights Landing *=
/
>  #define INTEL_XEON_PHI_KNM             IFM(6, 0x85) /* Knights Mill */
>
> +/* Notational marker denoting the last Family 6 model */
> +#define INTEL_FAM6_LAST                        IFM(6, 0xFF)
> +
>  /* Family 15 - NetBurst */
>  #define INTEL_P4_WILLAMETTE            IFM(15, 0x01) /* Also Xeon Foster=
 */
>  #define INTEL_P4_PRESCOTT              IFM(15, 0x03)
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index 5854f0b8f0f1..444602a0a3dd 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>
>  #include <acpi/processor.h>
> +#include <asm/cpu_device_id.h>
>  #include <asm/cpuid.h>
>  #include <asm/mwait.h>
>  #include <asm/special_insns.h>
> @@ -47,12 +48,11 @@ void acpi_processor_power_init_bm_check(struct acpi_p=
rocessor_flags *flags,
>         /*
>          * On all recent Intel platforms, ARB_DISABLE is a nop.
>          * So, set bm_control to zero to indicate that ARB_DISABLE
> -        * is not required while entering C3 type state on
> -        * P4, Core and beyond CPUs
> +        * is not required while entering C3 type state.
>          */
>         if (c->x86_vendor =3D=3D X86_VENDOR_INTEL &&
> -           (c->x86 > 0xf || (c->x86 =3D=3D 6 && c->x86_model >=3D 0x0f))=
)
> -                       flags->bm_control =3D 0;
> +           (c->x86 > 15 || (c->x86_vfm >=3D INTEL_CORE2_MEROM && c->x86_=
vfm <=3D INTEL_FAM6_LAST)))
> +               flags->bm_control =3D 0;
>
>         if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
>                 if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model =3D=3D=
 0x0f &&
> --
> 2.43.0
>

