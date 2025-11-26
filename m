Return-Path: <linux-acpi+bounces-19295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F675C8B21E
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A695B350061
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451483314BC;
	Wed, 26 Nov 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS6CWvWH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200953090FB
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176891; cv=none; b=t+FcRq5HanTVNs7kXqVHjSSIE5jM891YzfwNNIr+qrsom+5s32hefzlQzvO3udEsWTAdU8hF1pAdYvPqhzuBthxyfL+Ivr1fM6kmbR6KHD5j2nfX5kaWqMPXVyhwKYWLoVqFqKTCSl81xNEe7hFGkdgaE/xEBdXKVMjrfieSkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176891; c=relaxed/simple;
	bh=8bsa4JA4B4kxkmfuQAGFbWsajcRvIS8NRu0aknLflFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgtNkinONpHJ+kYEkhioNQfQkKabmonb66TWylH5LyueS2+mJRgUai6cq80IAYZHKLFvPH3+K9brWIzHmT/fQmHebW9uRYXqqSK5ackaDTD+gwnZP34vVcWkYD3aRetZNRwwSJ/HmqadtrmGNuIfpRRaC7H/E/aFy95hmPiH2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS6CWvWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB5FC4AF0B
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764176889;
	bh=8bsa4JA4B4kxkmfuQAGFbWsajcRvIS8NRu0aknLflFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cS6CWvWH5jUbmYH/6jqDY5AyXivIbuWIORcUffqRaztRZPgNq5YwUTeKVdr9OdxAG
	 1++NM+i54/IBBQVEfHs6Y8z69dCEGMbaWUt5Ro38mN8cwhRSfxE6QB6pWvfsxvr0AK
	 8TpblDcKbcBzmLZaxWg+QQt7AFnLcJR8tZ5U61ibWdBECZgyl6Pjos9AgN/V88TO4O
	 gujRgu/GxX9UUQzxwQmKisgkwRaJhXt9oesqZGrA4gibEgmjvd3d2fl0MwMOw9VvYG
	 oAsHHycJFbpT1AxOFfC1iNAANt+h/7DeD7SWQ2Bp26OGxcWduIeulJ0pidL/yanvCm
	 jVfYsDxwBDsQg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-450154aa53fso2779499b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 09:08:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHau9aUOXMnrXzv/XNLX/B5rW3voLIBVD6JtCMd/QKt+xjwhtY4BiB3vfZdtrpqINtchSiIi9+S23x@vger.kernel.org
X-Gm-Message-State: AOJu0Yyumql+4ZIMfvesPrfYXONLdYU3PDpmmIFYGjYmz1kuewWOm+/l
	qbiI4S5YOpJIiy/J7fNZQl4OsN9lnXY6Qv+vwnKxzMmo58zP67IFGqTG9iuyNUF5ZNCn1PjXJXt
	BD68bkDsLBRCZGJm+lcQce+RGybfPTPU=
X-Google-Smtp-Source: AGHT+IFp1HCwTys87dx2fwtwt0LOoG03zMsW3/TBbu8x/a3Vm7XQqka9Jse+yZ9pZtZJoCx0CAAaXUqloIyFos4tbiQ=
X-Received: by 2002:a05:6808:3007:b0:43d:498c:2157 with SMTP id
 5614622812f47-4514e6899a5mr3004025b6e.29.1764176888770; Wed, 26 Nov 2025
 09:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126.165513.1373131139292726554.rene@exactco.de>
In-Reply-To: <20251126.165513.1373131139292726554.rene@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 18:07:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ixYbQt9CiZA=Se5k8pt_2eWkGZzQedDdgvkbz7jzo_GQ@mail.gmail.com>
X-Gm-Features: AWmQ_bltwtzg7SjwotrLCi9LxbGjuR00gtqXRW2PqnSTdNlKNiqOsoiBY1AmfF8
Message-ID: <CAJZ5v0ixYbQt9CiZA=Se5k8pt_2eWkGZzQedDdgvkbz7jzo_GQ@mail.gmail.com>
Subject: Re: [PATCH V2] ACPI: processor_core: fix map_x2apic_id for amd-pstate
 on am4
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, superm1@kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:55=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wr=
ote:
>
> On all AMD AM4 systems I have seen, e.g ASUS X470-i, Pro WS X570 Ace
> and equivalent Gigabyte, amd-pstate does not initialize when the
> x2apic is enabled in the BIOS. Kernel debug messages include:
>
> [    0.315438] acpi LNXCPU:00: Failed to get CPU physical ID.
> [    0.354756] ACPI CPPC: No CPC descriptor for CPU:0
> [    0.714951] amd_pstate: the _CPC object is not present in SBIOS or ACP=
I disabled
>
> I tracked this down to map_x2apic_id() checking device_declaration
> passed in via the type argument of acpi_get_phys_id() via
> map_madt_entry() while map_lapic_id() does not.
>
> It appears these BIOS' use Processor statements for declaring the CPUs
> in the ACPI namespace instead of processor device objects (which
> should have been used). CPU declarations via Processor statements were
> deprecated in ACPI 6.0 that was released 10 years ago. They should not
> be used any more in any contemporary platform firmware.
>
> I tried to contact Asus support multiple times, but never received a
> reply nor did any BIOS update ever change this.
>
> Fix amd-pstate w/ x2apic on am4 by allowing this processor statements
> for IDs less than 255.
>
> Fixes: 7237d3de78ff ("x86, ACPI: add support for x2apic ACPI extensions")
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
> ---
> v2: allow for IDs < 255 only and add ACPI conformance note
> ---
> Tested in production in all x86 T2/Linux builds since 2021-09-26.
> [    0.000000] DMI: ASUS System Product Name/Pro WS X570-ACE, BIOS 4702 1=
0/20/2023
> [    0.000655] x2apic: enabled by BIOS, switching to x2apic ops
> [    0.003328] APIC: Switched APIC routing to: cluster x2apic
> [    0.059460] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI=
 0-23
> [    0.059465] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI=
 24-55
>
> rene@5950x:~# grep . /sys/devices/system/cpu/cpufreq/policy0/*
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf:166
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore:enabled
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq:=
1748178
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq:5276318
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking:206
> /sys/devices/system/cpu/cpufreq/policy0/boost:1
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1748178
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:5276318
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:572131
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_pref=
erences:default performance balance_performance balance_power power
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference:bal=
ance_performance
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:perfo=
rmance powersave
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1748178
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:amd-pstate-epp
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:powersave
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:5276318
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:1748178
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> ---
>  drivers/acpi/processor_core.c | 2 +-
>  1 file changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.=
c
> index 9b6b71a2ffb5..a7fbaca91c6f 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -54,7 +54,7 @@ static int map_x2apic_id(struct acpi_subtable_header *e=
ntry,
>         if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
>                 return -ENODEV;
>
> -       if (device_declaration && (apic->uid =3D=3D acpi_id)) {
> +       if (apic->uid =3D=3D acpi_id && (device_declaration || acpi_id < =
255)) {
>                 *apic_id =3D apic->local_apic_id;
>                 return 0;
>         }
>
> --

Applied as 6.19 material, thanks!

