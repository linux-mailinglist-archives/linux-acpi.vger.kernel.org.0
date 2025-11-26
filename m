Return-Path: <linux-acpi+bounces-19276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8EC89B92
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 13:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B65C347F45
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375E6324B3C;
	Wed, 26 Nov 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBYb0wlx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B0026ED5F
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159583; cv=none; b=oeWOU+OzI/+tPaHZXAh6zfPmXUnKtelpOmj1L5oJ3IkZ8RQ9Eu3/t4RdQRaxQMiITFy3HlkN0GQZtjp7eJz8BXRXlBeAs7fCq9C6E2s3zuw22S+fijm/pY3T6rgP9X1ssL9ob/5pHFYZvSEcpuIqwYfvkNsCeDBXnJc/CfmHNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159583; c=relaxed/simple;
	bh=LxaZxXJIMLSCEB/2mAeWAP2dHnLEK1acBCgR9Yz/IbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/Xad79etNE1GZ1JpewbvS3aCFLrh7ms5kD3idieoYLJ8fz6/Su5oM64zB71cp/1piLoVMqScKfL2jIV0G9rC9ABKNGdu9Uwow4Lcwc73bI3aQb5V5RngIufzrIQzvKO9EDmlI1QceyUfgE27lrzTMEbwXOvt4i976n22zOIq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBYb0wlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA37C116C6
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764159582;
	bh=LxaZxXJIMLSCEB/2mAeWAP2dHnLEK1acBCgR9Yz/IbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BBYb0wlxscmzpWeMmBtgj6Ucobf8jxB1LqfnF/JEPrFX1pTD/8MNijcw2goKDyuaG
	 BAhpwV5dW2SYl7JvodmKsOL1KsxCpnxeVFfn05TYvQmVpQYo30+yMTayNyWeTWm9c3
	 aYGNaABULTqoequ4Eynot8PfjmSRFnLX+2L4JBbIEws+zMePt7RmRkWRW6gcBI9ymJ
	 WGfk98NcTX/68fW0/O+m/Bf9ocpoKw3m2UOa1nL3QvgNa7bTRz9yw2Y8lQwv/cveiE
	 KGA4HcQBE33cM2Htyjsz3j8cRIZ6bwq3h3VIq5oMNS4tkrca/pfDvmmmcoePudhO+s
	 OeNMbV7BUP5/Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e89d226c3aso3853379fac.2
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 04:19:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yx1SDbBfjzylX7cKYPyPJ1rqfyJXGsun0QJe8hak5c8SqJsAHdk
	iBhrvFFVZwlIb1ezrFAwATbMHmI7MewwncQeqwW6VucAiPKJuLSKP3BmiMGjWP7HZHTR4HsTKei
	qQtKOD+m2ePqLGBwkJ8BQkowhDCt+F2Y=
X-Google-Smtp-Source: AGHT+IHJ9J+thwyTh5akV7pdtkwbIij5dOUHSoYt+ehwDwFQGihW7qfA+UcGcB98HsLNJRO95MfFb+STlrL/gdt2Wfg=
X-Received: by 2002:a05:6808:1917:b0:451:4da2:47d0 with SMTP id
 5614622812f47-4514e7fffadmr2532294b6e.48.1764159581882; Wed, 26 Nov 2025
 04:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125.182654.1292605389516841541.rene@exactco.de>
In-Reply-To: <20251125.182654.1292605389516841541.rene@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 13:19:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jiZCxHJCXMXjBtQuPZzDzJyjYwBXTkq5Girj05CwxoNA@mail.gmail.com>
X-Gm-Features: AWmQ_bmjPa4fFvThfhzMoY4TXamEcf4rRXCgONO8HaHX0cyLt04g18R4bWXyHTM
Message-ID: <CAJZ5v0jiZCxHJCXMXjBtQuPZzDzJyjYwBXTkq5Girj05CwxoNA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor_core: fix map_x2apic_id for amd-pstate
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-acpi@vger.kernel.org, Huang Rui <ray.huang@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "the arch/x86 maintainers" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000034c24f06447e6977"

--00000000000034c24f06447e6977
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the first place, this is an x86 patch, so it would be good to CC
the x86 list (CCed now).

On Tue, Nov 25, 2025 at 6:26=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wr=
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

For map_lapic_id() it does not matter what object type is used for
representing a CPU.

> Fix amd-pstate w/ x2apic on am4 by removing the device_declaration
> check in map_x2apic_id(), likewise.

It looks like on your system Processor statements have been used for
declaring the CPUs in the ACPI namespace instead of processor device
objects (which should have been used).  CPU declarations via Processor
statements were deprecated in ACPI 6.0 that was released 10 years ago.
They should not be used any more in any contemporary platform
firmware.

> Fixes: 7237d3de78ff ("x86, ACPI: add support for x2apic ACPI extensions")
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
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
>  drivers/acpi/processor_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.=
c
> index 9b6b71a2ffb5..a7fbaca91c6f 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -46,7 +46,7 @@ static int map_lapic_id(struct acpi_subtable_header *en=
try,
>  }
>
>  static int map_x2apic_id(struct acpi_subtable_header *entry,
> -               int device_declaration, u32 acpi_id, phys_cpuid_t *apic_i=
d)
> +               u32 acpi_id, phys_cpuid_t *apic_id)
>  {
>         struct acpi_madt_local_x2apic *apic =3D
>                 container_of(entry, struct acpi_madt_local_x2apic, header=
);
> @@ -54,7 +54,7 @@ static int map_x2apic_id(struct acpi_subtable_header *e=
ntry,
>         if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
>                 return -ENODEV;
>
> -       if (device_declaration && (apic->uid =3D=3D acpi_id)) {
> +       if (apic->uid =3D=3D acpi_id) {

This change goes a bit too far because some acpi_id values are only
valid when the CPU is declared as a processor device.

Does the attached patch also fix the issue?

>                 *apic_id =3D apic->local_apic_id;
>                 return 0;
>         }
> @@ -179,7 +179,7 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_=
madt *madt,
>                         if (!map_lapic_id(header, acpi_id, &phys_id))
>                                 break;
>                 } else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_X2API=
C) {
> -                       if (!map_x2apic_id(header, type, acpi_id, &phys_i=
d))
> +                       if (!map_x2apic_id(header, acpi_id, &phys_id))
>                                 break;
>                 } else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_SAPIC=
) {
>                         if (!map_lsapic_id(header, type, acpi_id, &phys_i=
d))
> @@ -256,7 +256,7 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle,=
 int type, u32 acpi_id)
>         else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_SAPIC)
>                 map_lsapic_id(header, type, acpi_id, &phys_id);
>         else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_X2APIC)
> -               map_x2apic_id(header, type, acpi_id, &phys_id);
> +               map_x2apic_id(header, acpi_id, &phys_id);
>         else if (header->type =3D=3D ACPI_MADT_TYPE_GENERIC_INTERRUPT)
>                 map_gicc_mpidr(header, type, acpi_id, &phys_id);
>         else if (header->type =3D=3D ACPI_MADT_TYPE_CORE_PIC)
> --

--00000000000034c24f06447e6977
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-processor-x2apic-check.patch"
Content-Disposition: attachment; 
	filename="acpi-processor-x2apic-check.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mifyyouz0>
X-Attachment-Id: f_mifyyouz0

LS0tCiBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl9jb3JlLmMKKysrIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9jb3JlLmMKQEAgLTU0
LDcgKzU0LDcgQEAgc3RhdGljIGludCBtYXBfeDJhcGljX2lkKHN0cnVjdCBhY3BpX3N1YgogCWlm
ICghKGFwaWMtPmxhcGljX2ZsYWdzICYgQUNQSV9NQURUX0VOQUJMRUQpKQogCQlyZXR1cm4gLUVO
T0RFVjsKIAotCWlmIChkZXZpY2VfZGVjbGFyYXRpb24gJiYgKGFwaWMtPnVpZCA9PSBhY3BpX2lk
KSkgeworCWlmIChhcGljLT51aWQgPT0gYWNwaV9pZCAmJiAoZGV2aWNlX2RlY2xhcmF0aW9uIHx8
IGFjcGlfaWQgPCAyNTUpKSB7CiAJCSphcGljX2lkID0gYXBpYy0+bG9jYWxfYXBpY19pZDsKIAkJ
cmV0dXJuIDA7CiAJfQo=
--00000000000034c24f06447e6977--

