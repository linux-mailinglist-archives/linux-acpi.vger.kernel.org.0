Return-Path: <linux-acpi+bounces-19587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D4CBE496
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B7D8305E36D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A90331A62;
	Mon, 15 Dec 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGmVU8jO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE962F49EC;
	Mon, 15 Dec 2025 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808181; cv=none; b=Sczo2VP0NcUJp6MMGE+q57CpRWvz50VbxatieH/BkQwRAIp2WG5QWS7SzbQlmLG0xpeyxniNjKNSzCERpjLFph4d61DSHgJ9vr7hi+iMGw0I6vTOmptWrPbH3S4SGU7F3GFRTR1PF8F8heaAJj93wl0uTw3E3yJb2VB4VQ5iQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808181; c=relaxed/simple;
	bh=OodUxN+Yk8btrJPdYoD2k8ZrrlNfl+AemcY7c0QM0pA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUkUikPe4yvrdDW/kMxtH9Xlqx6aQIPnFozMPSW9inMJH2SFP5E+vV+qUE1nS4gE2RsCel6r2FTF3+gWTHhQi2aSAnznhhLBR3nl8l2CadhF8ck/+3xdWE5I77nu9XQNHa6JQBq04UoyvJE7PR3TOSI0I5MMcsdmvlnn9qRDEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGmVU8jO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808175; x=1797344175;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OodUxN+Yk8btrJPdYoD2k8ZrrlNfl+AemcY7c0QM0pA=;
  b=FGmVU8jO7GbfED2oPErYGg6+ui+xu8sH4fHkGA7fMdgQEFyhGRUsg1oR
   k/06q5hezxdv2CRN/0mZUdGD9enxiKp2YqmwFLDnB5mMQVV/PoSWax1V2
   LosIYGOFYKEF38T3cIE4Qb1K/Qax7bRzOiq96jFt8PvtFNGnjmM7VPYa7
   RJhnSn5e0RVjAmTbowVqIz+kjJieQ8zqen2nG9cqDkRRaZfiee8MaOI+L
   aa3ct9iYZeJNRxTZ+exbMJtFDRdPhkJxNVSFJBVyGhDk2SHk9MebyoOoS
   ll3yTzRtKL5fDAU9cwDsOf9hgejOR8N/HIuX7FoK2JGDA2tLT+Y0QcXkb
   A==;
X-CSE-ConnectionGUID: ikek67peT6GZc9rTs3H72Q==
X-CSE-MsgGUID: Ldfy/0KQR8Wo/so62XnaHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71339739"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="71339739"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:16:12 -0800
X-CSE-ConnectionGUID: t7LqtcmqRF2ZOyZRZcPCqQ==
X-CSE-MsgGUID: BeRFfKRlSsyV2DAv9EUcVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="221111526"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.222.238]) ([10.124.222.238])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:16:11 -0800
Message-ID: <33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org,
 mmikowski@kfocus.org, rjw@rjwysocki.net
Date: Mon, 15 Dec 2025 06:16:10 -0800
In-Reply-To: <20251214184507.21f95134@kf-m2g5>
References: <20251214184507.21f95134@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aaron,

On Sun, 2025-12-14 at 18:45 -0600, Aaron Rainbolt wrote:
> Hi Srinivas:
>=20
> We do not have the X580WNT-G available at the moment. It was included
> to show the wide sample of devices showing this bug but has left the
> office for now. However, we do have a bench model of the X560WNR-G
> always available, so I have included results for that model instead.
> The issues present are the same. I hope that's ok.
>=20
> > To check, I need dump of:
> > m=3D$(getconf _NPROCESSORS_ONLN); for ((i=3D0; i<m; i++)); do echo
> > CPU$i;
> > sudo rdmsr -p $i 0x771;=C2=A0 sudo rdmsr -p $i 0x774; done
>=20
> Here are the results of running the above script on the X560WNR-G on
> the mainline kernel 6.18.0-061800-generic installed from
> https://kernel.ubuntu.com/mainline/v6.18. The results are EXACTLY the
> same as the 6.14 kernel:
>=20
> =C2=A0 CPU0
> =C2=A0 11a203d
> =C2=A0 40003d0d

This data is not consistent with the reported frequencies M-TEST
frequencies.
I need to get hold of such internal system with the same processor and
check what is reported.

Thanks,
Srinivas



> =C2=A0 CPU1
> =C2=A0 11a203d
> =C2=A0 40003d0d
> =C2=A0 CPU2
> =C2=A0 11a203f
> =C2=A0 40003f0e
> =C2=A0 CPU3
> =C2=A0 11a203f
> =C2=A0 40003f0e
> =C2=A0 CPU4
> =C2=A0 11a203d
> =C2=A0 40003d0d
> =C2=A0 CPU5
> =C2=A0 11a203d
> =C2=A0 40003d0d
> =C2=A0 CPU6
> =C2=A0 11a203d
> =C2=A0 40003d0d
> =C2=A0 CPU7
> =C2=A0 11a203d
> =C2=A0 40003d0d
> =C2=A0 CPU8
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU9
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU10
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU11
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU12
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU13
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU14
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU15
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU16
> =C2=A0 10f152e
> =C2=A0 40002e0a
> =C2=A0 CPU17
> =C2=A0 10f152e
> =C2=A0 40002e0a
> =C2=A0 CPU18
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU19
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU20
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU21
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU22
> =C2=A0 10f152e
> =C2=A0 40002e0c
> =C2=A0 CPU23
> =C2=A0 10f152e
> =C2=A0 40002e0c
>=20
> > What command you to report " M-Test=C2=A0 . Id"?
>=20
> We wrote the attached `check-intel-cpu-freq` script to find this
> value.
> It scans P- and E-core groups and finds the maximum current frequency
> and what core provided it. That value is read from the sysfs file
> found
> for each core like so:
> `/sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq`. This
> script
> scan each group 200 times, so there are 200 x 8 =3D 1600 P-core samples
> and 200 x 16 =3D 3200 E-core samples. The script directs one to use
> Geekbench5 to stress the cores while it is running. Here are the
> results with the mainline 6.18 kernel. The Assesment is identical
> with
> the results we got with the 6.14 and 6.18-rc7 kernels:
>=20
> =C2=A0 ## Clevo | X560WNR-G | Ultra 9 275HX | kernel 6.18.0-061800-generi=
c
> (Mainline)
>=20
> =C2=A0 Type |Turbo|B-Claim . Id|B-Spec |M-Claim . Id|M-Spec |M-Test=C2=A0=
 . Id
> =C2=A0 -----|-----|------------|-------|------------|-------|------------
> =C2=A0 P=C2=A0=C2=A0=C2=A0 |off=C2=A0 |2000000 . 07|2700000|2000000 . 07|=
2700000|2700027 . 01
> =C2=A0 P=C2=A0=C2=A0=C2=A0 |ON=C2=A0=C2=A0 |2000000 . 07|2700000|3900000 =
. 03|5400000|5400000 . 03
> =C2=A0 E=C2=A0=C2=A0=C2=A0 |off=C2=A0 |2100000 . 17|2100000|2100000 . 17|=
2100000|2133426 . 11
> =C2=A0 E=C2=A0=C2=A0=C2=A0 |ON=C2=A0=C2=A0 |2100000 . 17|2100000|4600000 =
. 17|4600000|4694736 . 15
>=20
> =C2=A0 ## Assessment
>=20
> =C2=A0 1. The E-cores are all expressed as expected
> =C2=A0 2. The P-cores show base freq claimed (B-Claim) at 2000000, but
> specified
> =C2=A0=C2=A0=C2=A0=C2=A0 (B-Spec) and measured (M-Test) are 2700000.
> =C2=A0 3. The P-cores show max freq claimed (M-Claim) at 3900000, but
> specified
> =C2=A0=C2=A0=C2=A0=C2=A0 (M-Spec) and measured (M-Test) are 5400000.
>=20
> =C2=A0 ## Key
>=20
> =C2=A0 Column=C2=A0 | Values | Purpose
> =C2=A0 --------|--------|---------
> =C2=A0 Type=C2=A0=C2=A0=C2=A0 | P|E=C2=A0=C2=A0=C2=A0 | The subset of cor=
es this row applied to.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 For example, `P` means `all P-cor=
es`.
> =C2=A0 Turbo=C2=A0=C2=A0 | off|ON | The turbo setting of this core subset=
.
> =C2=A0 B-Claim | int Hz | The max `base_frequency` value of this core
> subset.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Id | int=C2=A0=C2=A0=C2=A0 | The cor=
e id that provided the Base-Claim value.
> =C2=A0 B-Spec=C2=A0 | int Hz | Intel SPEC'D BASE freq for this CPU's core=
 Type.
> =C2=A0 M-Claim | int Hz | The max `cpuinfo_max_freq` value of this core
> subset.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Id | int=C2=A0=C2=A0=C2=A0 | The cor=
e id that provided the Max-Claim value.
> =C2=A0 M-Spec=C2=A0 | int Hz | Intel SPEC'D MAX freq for this CPU's core =
Type.
> =C2=A0 M-Test=C2=A0 | int Hz | The max `scaling_cur_freq` value of this c=
ore
> subset.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 The entire core subset is sampled=
 200x.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Id | int=C2=A0=C2=A0=C2=A0 | The cor=
e id that provided the Max-Test value.
>=20
>=20
> > One addition, to show measured freq, use
> > sudo turbostat --show frequency
>=20
> We couldn't easily run this on the 6.18 mainline kernel because the
> linux-tools package in Ubuntu is not available. However, we ran this
> with the 6.14 kernel, which showed the same P-core frequency issues
> in
> our testing. When we continued to run and pushed the cores, the
> Bzy_Mhz
> values approached the theoretical maximums. Let me know if you
> require
> more than this:
>=20
> =C2=A0 X560WNR-G $ sudo turbostat --show frequency
> =C2=A0 turbostat version 2025.02.02 - Len Brown <lenb@kernel.org>
> =C2=A0 Kernel command line: BOOT_IMAGE=3D/@boot/vmlinuz-6.14.0-34-kfocus
> root=3DUUID=3D09e835be-39d5-42fa-8b81-39f5a40f98de ro rootflags=3Dsubvol=
=3D@
> quiet cryptdevice=3DUUID=3D2cd8437a-4d06-4050-bf06-247f233d7d76:luks-
> 2cd8437a-4d06-4050-bf06-247f233d7d76 root=3D/dev/mapper/luks-2cd8437a-
> 4d06-4050-bf06-247f233d7d76 splash modprobe.blacklist=3Dnouveau
> nouveau.modeset=3D0 modprobe.blacklist=3Ducsi_acpi vt.handoff=3D7
> =C2=A0 CPUID(0): GenuineIntel 0x23 CPUID levels
> =C2=A0 CPUID(1): family:model:stepping 0x6:c6:2 (6:198:2) microcode 0x119
> =C2=A0 CPUID(0x80000000): max_extended_levels: 0x80000008
> =C2=A0 CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM HT TM
> =C2=A0 CPUID(6): APERF, TURBO, DTS, PTM, HWP, HWPnotify, HWPwindow,
> HWPepp, HWPpkg, EPB
> =C2=A0 cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH
> TURBO)
> =C2=A0 CPUID(7): No-SGX Hybrid
> =C2=A0 CPUID(0x15): eax_crystal: 2 ebx_tsc: 160 ecx_crystal_hz: 38400000
> =C2=A0 TSC: 3072 MHz (38400000 Hz * 160 / 2 / 1000000)
> =C2=A0 CPUID(0x16): base_mhz: 3100 max_mhz: 4600 bus_mhz: 100
> =C2=A0 cpu0: MSR_PLATFORM_INFO: 0x804083cf1811f00
> =C2=A0 8 * 100.0 =3D 800.0 MHz max efficiency frequency
> =C2=A0 31 * 100.0 =3D 3100.0 MHz base frequency
> =C2=A0 cpu0: MSR_TURBO_RATIO_LIMIT: 0x3434343434343636
> =C2=A0 52 * 100.0 =3D 5200.0 MHz max turbo 8 active cores
> =C2=A0 52 * 100.0 =3D 5200.0 MHz max turbo 7 active cores
> =C2=A0 52 * 100.0 =3D 5200.0 MHz max turbo 6 active cores
> =C2=A0 52 * 100.0 =3D 5200.0 MHz max turbo 5 active cores
> =C2=A0 52 * 100.0 =3D 5200.0 MHz max turbo 4 active cores
> =C2=A0 52 * 100.0 =3D 5200.0 MHz max turbo 3 active cores
> =C2=A0 54 * 100.0 =3D 5400.0 MHz max turbo 2 active cores
> =C2=A0 54 * 100.0 =3D 5400.0 MHz max turbo 1 active cores
> =C2=A0 cpu0: MSR_SECONDARY_TURBO_RATIO_LIMIT: 0x2e2e2e2e2e2e2e2e
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 8 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 7 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 6 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 5 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 4 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 3 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 2 active cores
> =C2=A0 46 * 100.0 =3D 4600.0 MHz max turbo 1 active cores
> =C2=A0 cpu0: MSR_CONFIG_TDP_NOMINAL: 0x0000001b (base_ratio=3D27)
> =C2=A0 cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x00110168 (PKG_MIN_PWR_LVL1=3D0
> PKG_MAX_PWR_LVL1=3D0 LVL1_RATIO=3D17 PKG_TDP_LVL1=3D360)
> =C2=A0 cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x001f0208 (PKG_MIN_PWR_LVL2=3D0
> PKG_MAX_PWR_LVL2=3D0 LVL2_RATIO=3D31 PKG_TDP_LVL2=3D520)
> =C2=A0 cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=3D0)
> =C2=A0 cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x0000001a
> (MAX_NON_TURBO_RATIO=3D26 lock=3D0)
> =C2=A0 cpu0: cpufreq driver: intel_pstate
> =C2=A0 cpu0: cpufreq governor: powersave
> =C2=A0 cpufreq intel_pstate no_turbo: 0
> =C2=A0 cpu0: MSR_MISC_PWR_MGMT: 0x000030c2 (ENable-EIST_Coordination
> ENable-EPB DISable-OOB)
> =C2=A0 cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> =C2=A0 cpu0: MSR_HWP_CAPABILITIES: 0x011a203d (high 61 guar 32 eff 26 low
> 1)
> =C2=A0 cpu0: MSR_HWP_REQUEST: 0x40003d0d (min 13 max 61 des 0 epp 0x40
> window 0x0 pkg 0x0)
> =C2=A0 cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff01 (min 1 max 255 des 0 epp 0x8=
0
> window 0x0)
> =C2=A0 cpu0: MSR_HWP_INTERRUPT: 0x00000005 (EN_Guaranteed_Perf_Change,
> Dis_Excursion_Min)
> =C2=A0 cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-
> Excursion_Min)
> =C2=A0 cpu0: EPB: 6 (balanced)
> =C2=A0 cpu0: MSR_IA32_POWER_CTL: 0x00e4005f (C1E auto-promotion: ENabled)
> =C2=A0 cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x74008008 (UNdemote-C1, demote-
> C1, locked, pkg-cstate-limit=3D8 (unlimited))
> =C2=A0 /dev/cpu_dma_latency: 2000000000 usec (default)
> =C2=A0 current_driver: intel_idle
> =C2=A0 current_governor: menu
> =C2=A0 current_governor_ro: menu
> =C2=A0 cpu0: POLL: CPUIDLE CORE POLL IDLE
> =C2=A0 cpu0: C1ACPI: ACPI FFH MWAIT 0x0
> =C2=A0 cpu0: C2ACPI: ACPI FFH MWAIT 0x21
> =C2=A0 cpu0: C3ACPI: ACPI FFH MWAIT 0x60
> =C2=A0 cpu0: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
> =C2=A0 cpu0: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
> =C2=A0 cpu0: MSR_PKGC8_IRTL: 0x00000000 (NOTvalid, 0 ns)
> =C2=A0 cpu0: MSR_PKGC10_IRTL: 0x00000000 (NOTvalid, 0 ns)
> =C2=A0 Uncore Frequency package0 die0: 800 - 3800 MHz (800 - 3800 MHz)
> 1800 MHz
> =C2=A0 RAPL: 4766 sec. Joule Counter Range, at 55 Watts
> =C2=A0 cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061
> Joules, 0.000977 sec.)
> =C2=A0 cpu0: MSR_PKG_POWER_INFO: 0x120000000001b8 (55 W TDP, RAPL 0 - 0 W=
,
> 0.017578 sec.)
> =C2=A0 cpu0: MSR_PKG_POWER_LIMIT: 0x438500001f8640 (UNlocked)
> =C2=A0 cpu0: PKG Limit #1: ENabled (200.000 Watts, 32.000000 sec, clamp
> ENabled)
> =C2=A0 cpu0: PKG Limit #2: ENabled (160.000 Watts, 0.002441* sec, clamp
> ENabled)
> =C2=A0 cpu0: MSR_VR_CURRENT_CONFIG: 0x00000850
> =C2=A0 cpu0: PKG Limit #4: 266.000000 Watts (UNlocked)
> =C2=A0 cpu0: MSR_DRAM_POWER_LIMIT: 0x00000000 (UNlocked)
> =C2=A0 cpu0: DRAM Limit: DISabled (0.000 Watts, 0.000977 sec, clamp
> DISabled)
> =C2=A0 cpu0: MSR_PP0_POLICY: 0
> =C2=A0 cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
> =C2=A0 cpu0: Cores Limit: DISabled (0.000 Watts, 0.000977 sec, clamp
> DISabled)
> =C2=A0 cpu0: MSR_PP1_POLICY: 0
> =C2=A0 cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
> =C2=A0 cpu0: GFX Limit: DISabled (0.000 Watts, 0.000977 sec, clamp
> DISabled)
> =C2=A0 cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0d690000 (92 C) (105 default =
-
> 13 offset)
> =C2=A0 cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88320002 (55 C)
> =C2=A0 cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x02000003 (105 C, 105 C)
> =C2=A0 cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-
> Prefetch-pair L1-Prefetch L1-IP-Prefetch)
> =C2=A0 Avg_MHz Busy%=C2=A0=C2=A0 Bzy_MHz TSC_MHz GFXMHz=C2=A0 GFXAMHz SAM=
MHz=C2=A0 SAMAMHz
> UncMHz
> =C2=A0 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.20=C2=A0=C2=A0=C2=A0 1594=
=C2=A0=C2=A0=C2=A0 3071=C2=A0=C2=A0=C2=A0 550=C2=A0=C2=A0=C2=A0=C2=A0 550=
=C2=A0=C2=A0=C2=A0=C2=A0 1300=C2=A0=C2=A0=C2=A0 1300=C2=A0=C2=A0=C2=A0
> 1800
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.11=C2=A0=C2=A0=C2=A0 1945=
=C2=A0=C2=A0=C2=A0 3072=C2=A0=C2=A0=C2=A0 550=C2=A0=C2=A0=C2=A0=C2=A0 550=
=C2=A0=C2=A0=C2=A0=C2=A0 1300=C2=A0=C2=A0=C2=A0 1300=C2=A0=C2=A0=C2=A0
> 1800
> =C2=A0 10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.53=C2=A0=C2=A0=C2=A0 1818=C2=A0=
=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.06=C2=A0=C2=A0=C2=A0 1380=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.15=C2=A0=C2=A0=C2=A0 1416=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.09=C2=A0=C2=A0=C2=A0 1315=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.33=C2=A0=C2=A0=C2=A0 1410=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.45=C2=A0=C2=A0=C2=A0 1338=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.12=C2=A0=C2=A0=C2=A0 1531=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.15=C2=A0=C2=A0=C2=A0 1471=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.08=C2=A0=C2=A0=C2=A0 1375=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.17=C2=A0=C2=A0=C2=A0 2113=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.16=C2=A0=C2=A0=C2=A0 2085=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.04=C2=A0=C2=A0=C2=A0 2058=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.23=C2=A0=C2=A0=C2=A0 2016=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 14=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.98=C2=A0=C2=A0=C2=A0 1410=C2=A0=
=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.04=C2=A0=C2=A0=C2=A0 1422=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.10=C2=A0=C2=A0=C2=A0 1435=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.11=C2=A0=C2=A0=C2=A0 1471=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.17=C2=A0=C2=A0=C2=A0 1418=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.33=C2=A0=C2=A0=C2=A0 1684=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.13=C2=A0=C2=A0=C2=A0 1465=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.08=C2=A0=C2=A0=C2=A0 1714=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.02=C2=A0=C2=A0=C2=A0 2270=
=C2=A0=C2=A0=C2=A0 3072
> =C2=A0 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.13=C2=A0=C2=A0=C2=A0 1969=
=C2=A0=C2=A0=C2=A0 3072
>=20
> To keep everything in one place, here is the acpi_cppc report you
> requested earlier also for the X560WNR-G using the 6.18 mainline
> kernel. This is identical again to the 6.14 kernel EXCEPT for the
> `feedback_crts` field, which appears to be dynamic.
>=20
> =C2=A0 X560WNR-G $ grep . /sys/devices/system/cpu/cpu*/acpi_cppc/*
> =C2=A0
> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:85764085462
> del:81092364612
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:61
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:30648952280
> del:32319093196
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:24418501228
> del:26064639390
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:30772876268
> del:31630648127
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:32208013456
> del:33858924907
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:34318996648
> del:37357638199
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:41344894184
> del:40523832261
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:36965175248
> del:37144286195
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
> =C2=A0
> /sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:29796395364
> del:30507895794
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
> =C2=A0
> /sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:30008884864
> del:31394469575
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:33127087692
> del:36493571195
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:47084742987
> del:52088422560
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:61
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:35405865204
> del:37891455176
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:31453151676
> del:32354440344
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:29395705360
> del:30249765611
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:34147115164
> del:34129428131
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:1844674407370
> 9551615
> =C2=A0
> /sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:52863482561
> del:63458169943
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:63
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:53310134126
> del:60839001140
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:63
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:37661765305
> del:39273578265
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:37315012790
> del:40229366158
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:31209054793
> del:33190454758
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:27945691272
> del:28942342249
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:32
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:61
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:26
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
> =C2=A0 /sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
> =C2=A0
> /sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:30470288492
> del:31360721157
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709
> 551615
> =C2=A0
> /sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:33008945576
> del:35214567794
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:21
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:46
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:15
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
> =C2=A0 /sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
> =C2=A0
> /sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709
> 551615
>=20
> Thanks again,
>=20
> --
> Aaron

