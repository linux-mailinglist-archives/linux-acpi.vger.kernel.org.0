Return-Path: <linux-acpi+bounces-19565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F0CBC293
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 01:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B6CA3007686
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758452C028C;
	Mon, 15 Dec 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="MpLIMTPy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034834C92
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765759533; cv=none; b=ljpkQQz+e+Kjp1s2gC48NNtqqFxqohh2hmvgX2djjE9ddgb2hZJIKInZTUg4WAOsRxC6aIctOpo6qUNRmLuFxH5s2Gv2NanABLZOZoEoQfTPjnhYYyLqPDe8xZuCzUQoyHDzax8HJYhj3LghP4uBTV2cReTN71W927jZaNPcBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765759533; c=relaxed/simple;
	bh=iyxPQy6Yd3a0eiTPXN/dk7y1AzhEkRTcUh5cOvtY2bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=qnEaMGVH6mIKYySbxdg1Q2vTXC7SUiLmP08eQeRHgLqx+yJZeUNGApD4FQBrVanwtNrG8c+JyT98DrS662D/QcsMJAnp0J9qWQDqUQ95r3kZG7MFrUsGiOUcXscA+JfiX9o/DawGwX5SesTe0ZYEFIjnLU90lQtk2OaNVpwzppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=MpLIMTPy; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c76f65feb5so2593368a34.0
        for <linux-acpi@vger.kernel.org>; Sun, 14 Dec 2025 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1765759530; x=1766364330; darn=vger.kernel.org;
        h=mime-version:in-reply-to:organization:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmZTFS0b/i5lSM5BT6gno5ribOwK4ydISKz/x5xn/b8=;
        b=MpLIMTPym3yMSRWcLNZktbOxeUR9X0ajRXACtpFYOuVMMaUl9DgvzaWrvfbJftLrsG
         XCj8KOCP+X87mbjaU02d7QlPUlg1viVn8XdIE6amPjc20/Yh1JHGKrQHr0WIWQCeY1ZS
         nusiGhFNpXo3sbjQZZCNUeIK8AOQCyY+01/O1RtjcXXorWpq3v5VwflwrrVQZSWHpraY
         cy+hRu2+Ax31rqCGN6JMexWIs1HojXHGW3qyzELOjDvqNmCgIHLAZ/0wC+9gHyFZDS6f
         O66clL2Aps6e+f6JVZR2I/nAW9h7cxTq9c3Fb/FGdl6mKfGwSzyR5dYaT1DIpthenYMJ
         ZzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765759530; x=1766364330;
        h=mime-version:in-reply-to:organization:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmZTFS0b/i5lSM5BT6gno5ribOwK4ydISKz/x5xn/b8=;
        b=F7zFA0phoT3MmsC8cjixoh2hB3vjnw3b6UUC1fSPj/t0JVJW3zl+Hh5FrbD6vsceGN
         IU6JwsplQNH4yZ45OSxgaOEqMC6MUtzHSj9NxPq7IhVDihvczED/nf7zlyYcMgUqhc4Y
         Nj78QbClwz8auj/pzrkrOHgguvWyC4BbvfTqvSik6nPw6Ge/mYM1xdOz9ZAra6kq6AIA
         DshBpyn42RMnI1DGz5I1YZM6d29NQsGKg8UymhaQU/dmePeIRH8cBgLaDjOymbRBeS3w
         Up8idYH82/xKQ7Ia7WdOaAelk7jDF6ECjHVhKtY8hVYmbtPNQMZrM9Q1quU0Gi7FhRnC
         yrSA==
X-Forwarded-Encrypted: i=1; AJvYcCUIBOXeBSf44XTbS8oEDnkAk6ASDHwudYN46m/HiH3M3hoRZtGnLKan3n0tOrKQQHydED0g3qpoi9Me@vger.kernel.org
X-Gm-Message-State: AOJu0YzadDLLChaSnguvhKaOtE7vmFvm4jlAcf4591dilVtNIFgY9MHq
	2mTZOwRYtNsgbGNQpWrTlUSRruWBgNDuttdotK8q7JPxOxesIoqzHcOlj5faWWKLaOs=
X-Gm-Gg: AY/fxX4F3yMt4hkxDrCLW5+LduTljqcRP7QPw1QvlnU5oOKrg2C/cxEqM2PxQ1vXxvw
	cECu1vovb3MAq9h2rWQ4xw9sP0dB3bOb+jmhx077mxX4CLvpWfiMGXC0eoJoELcfURszeG486AY
	a+/RVlZI7gHj0adAGCF8iuTPKfCDE8WbP4QA6z5uah9a5xJfDlnWv1iYKHo8fvPX1bHQE8ZI8Ry
	ckqEdiGe5zB5TR24LprVu+Xewv04aVU+hAE0IKxHNIrpe5z2PZHita4oRggjhIeJSGG8CIcwZOh
	/NJLg5q0KFMnDo1qQVeLDBzoVJAbTD+xCajeNxABpBU1+hhHrtBFtHvZO/fgyFQCBrSLNMDB9lv
	UfAXfIT8O3Swli42ikewnGlrKCfngNDAFEwh8iGcynj2AARXNKzb7YE6hBppeArnk0T5hKJ14MP
	NPXUf1y9I=
X-Google-Smtp-Source: AGHT+IGmZNawdo2RFrnNEzfDccZPy4+2roIVbTcNyhzqspkgpEUzL0qvCZJlEyXQZ5dkHLhZjOxA9w==
X-Received: by 2002:a05:6830:2701:b0:7c7:6348:5946 with SMTP id 46e09a7af769-7cae82d5406mr5569185a34.5.1765759529884;
        Sun, 14 Dec 2025 16:45:29 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf8f:aac:a5bd:66af:ecd2:362b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb3246b3sm8254060a34.21.2025.12.14.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 16:45:29 -0800 (PST)
Date: Sun, 14 Dec 2025 18:45:07 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com
Cc: arainbolt@kfocus.org, kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, mmikowski@kfocus.org,
 rjw@rjwysocki.net
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251214184507.21f95134@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <849e7394b8c7c4b74d1d55648a8d4b55b49aa91a.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/U19GPm6YGZI.dbqsi7FYSoh"

--MP_/U19GPm6YGZI.dbqsi7FYSoh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Srinivas:

We do not have the X580WNT-G available at the moment. It was included
to show the wide sample of devices showing this bug but has left the
office for now. However, we do have a bench model of the X560WNR-G
always available, so I have included results for that model instead.
The issues present are the same. I hope that's ok.

> To check, I need dump of:
> m=$(getconf _NPROCESSORS_ONLN); for ((i=0; i<m; i++)); do echo CPU$i;
> sudo rdmsr -p $i 0x771;  sudo rdmsr -p $i 0x774; done

Here are the results of running the above script on the X560WNR-G on
the mainline kernel 6.18.0-061800-generic installed from
https://kernel.ubuntu.com/mainline/v6.18. The results are EXACTLY the
same as the 6.14 kernel:

  CPU0
  11a203d
  40003d0d
  CPU1
  11a203d
  40003d0d
  CPU2
  11a203f
  40003f0e
  CPU3
  11a203f
  40003f0e
  CPU4
  11a203d
  40003d0d
  CPU5
  11a203d
  40003d0d
  CPU6
  11a203d
  40003d0d
  CPU7
  11a203d
  40003d0d
  CPU8
  10f152e
  40002e0c
  CPU9
  10f152e
  40002e0c
  CPU10
  10f152e
  40002e0c
  CPU11
  10f152e
  40002e0c
  CPU12
  10f152e
  40002e0c
  CPU13
  10f152e
  40002e0c
  CPU14
  10f152e
  40002e0c
  CPU15
  10f152e
  40002e0c
  CPU16
  10f152e
  40002e0a
  CPU17
  10f152e
  40002e0a
  CPU18
  10f152e
  40002e0c
  CPU19
  10f152e
  40002e0c
  CPU20
  10f152e
  40002e0c
  CPU21
  10f152e
  40002e0c
  CPU22
  10f152e
  40002e0c
  CPU23
  10f152e
  40002e0c

> What command you to report " M-Test  . Id"?

We wrote the attached `check-intel-cpu-freq` script to find this value.
It scans P- and E-core groups and finds the maximum current frequency
and what core provided it. That value is read from the sysfs file found
for each core like so:
`/sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq`. This script
scan each group 200 times, so there are 200 x 8 = 1600 P-core samples
and 200 x 16 = 3200 E-core samples. The script directs one to use
Geekbench5 to stress the cores while it is running. Here are the
results with the mainline 6.18 kernel. The Assesment is identical with
the results we got with the 6.14 and 6.18-rc7 kernels:

  ## Clevo | X560WNR-G | Ultra 9 275HX | kernel 6.18.0-061800-generic (Mainline)

  Type |Turbo|B-Claim . Id|B-Spec |M-Claim . Id|M-Spec |M-Test  . Id
  -----|-----|------------|-------|------------|-------|------------
  P    |off  |2000000 . 07|2700000|2000000 . 07|2700000|2700027 . 01
  P    |ON   |2000000 . 07|2700000|3900000 . 03|5400000|5400000 . 03
  E    |off  |2100000 . 17|2100000|2100000 . 17|2100000|2133426 . 11
  E    |ON   |2100000 . 17|2100000|4600000 . 17|4600000|4694736 . 15

  ## Assessment

  1. The E-cores are all expressed as expected
  2. The P-cores show base freq claimed (B-Claim) at 2000000, but specified
     (B-Spec) and measured (M-Test) are 2700000.
  3. The P-cores show max freq claimed (M-Claim) at 3900000, but specified
     (M-Spec) and measured (M-Test) are 5400000.

  ## Key

  Column  | Values | Purpose
  --------|--------|---------
  Type    | P|E    | The subset of cores this row applied to.
          |        |   For example, `P` means `all P-cores`.
  Turbo   | off|ON | The turbo setting of this core subset.
  B-Claim | int Hz | The max `base_frequency` value of this core subset.
       Id | int    | The core id that provided the Base-Claim value.
  B-Spec  | int Hz | Intel SPEC'D BASE freq for this CPU's core Type.
  M-Claim | int Hz | The max `cpuinfo_max_freq` value of this core subset.
       Id | int    | The core id that provided the Max-Claim value.
  M-Spec  | int Hz | Intel SPEC'D MAX freq for this CPU's core Type.
  M-Test  | int Hz | The max `scaling_cur_freq` value of this core subset.
          |        |   The entire core subset is sampled 200x.
       Id | int    | The core id that provided the Max-Test value.


> One addition, to show measured freq, use
> sudo turbostat --show frequency

We couldn't easily run this on the 6.18 mainline kernel because the
linux-tools package in Ubuntu is not available. However, we ran this
with the 6.14 kernel, which showed the same P-core frequency issues in
our testing. When we continued to run and pushed the cores, the Bzy_Mhz
values approached the theoretical maximums. Let me know if you require
more than this:

  X560WNR-G $ sudo turbostat --show frequency
  turbostat version 2025.02.02 - Len Brown <lenb@kernel.org>
  Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.14.0-34-kfocus root=UUID=09e835be-39d5-42fa-8b81-39f5a40f98de ro rootflags=subvol=@ quiet cryptdevice=UUID=2cd8437a-4d06-4050-bf06-247f233d7d76:luks-2cd8437a-4d06-4050-bf06-247f233d7d76 root=/dev/mapper/luks-2cd8437a-4d06-4050-bf06-247f233d7d76 splash modprobe.blacklist=nouveau nouveau.modeset=0 modprobe.blacklist=ucsi_acpi vt.handoff=7
  CPUID(0): GenuineIntel 0x23 CPUID levels
  CPUID(1): family:model:stepping 0x6:c6:2 (6:198:2) microcode 0x119
  CPUID(0x80000000): max_extended_levels: 0x80000008
  CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM HT TM
  CPUID(6): APERF, TURBO, DTS, PTM, HWP, HWPnotify, HWPwindow, HWPepp, HWPpkg, EPB
  cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
  CPUID(7): No-SGX Hybrid
  CPUID(0x15): eax_crystal: 2 ebx_tsc: 160 ecx_crystal_hz: 38400000
  TSC: 3072 MHz (38400000 Hz * 160 / 2 / 1000000)
  CPUID(0x16): base_mhz: 3100 max_mhz: 4600 bus_mhz: 100
  cpu0: MSR_PLATFORM_INFO: 0x804083cf1811f00
  8 * 100.0 = 800.0 MHz max efficiency frequency
  31 * 100.0 = 3100.0 MHz base frequency
  cpu0: MSR_TURBO_RATIO_LIMIT: 0x3434343434343636
  52 * 100.0 = 5200.0 MHz max turbo 8 active cores
  52 * 100.0 = 5200.0 MHz max turbo 7 active cores
  52 * 100.0 = 5200.0 MHz max turbo 6 active cores
  52 * 100.0 = 5200.0 MHz max turbo 5 active cores
  52 * 100.0 = 5200.0 MHz max turbo 4 active cores
  52 * 100.0 = 5200.0 MHz max turbo 3 active cores
  54 * 100.0 = 5400.0 MHz max turbo 2 active cores
  54 * 100.0 = 5400.0 MHz max turbo 1 active cores
  cpu0: MSR_SECONDARY_TURBO_RATIO_LIMIT: 0x2e2e2e2e2e2e2e2e
  46 * 100.0 = 4600.0 MHz max turbo 8 active cores
  46 * 100.0 = 4600.0 MHz max turbo 7 active cores
  46 * 100.0 = 4600.0 MHz max turbo 6 active cores
  46 * 100.0 = 4600.0 MHz max turbo 5 active cores
  46 * 100.0 = 4600.0 MHz max turbo 4 active cores
  46 * 100.0 = 4600.0 MHz max turbo 3 active cores
  46 * 100.0 = 4600.0 MHz max turbo 2 active cores
  46 * 100.0 = 4600.0 MHz max turbo 1 active cores
  cpu0: MSR_CONFIG_TDP_NOMINAL: 0x0000001b (base_ratio=27)
  cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x00110168 (PKG_MIN_PWR_LVL1=0 PKG_MAX_PWR_LVL1=0 LVL1_RATIO=17 PKG_TDP_LVL1=360)
  cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x001f0208 (PKG_MIN_PWR_LVL2=0 PKG_MAX_PWR_LVL2=0 LVL2_RATIO=31 PKG_TDP_LVL2=520)
  cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
  cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x0000001a (MAX_NON_TURBO_RATIO=26 lock=0)
  cpu0: cpufreq driver: intel_pstate
  cpu0: cpufreq governor: powersave
  cpufreq intel_pstate no_turbo: 0
  cpu0: MSR_MISC_PWR_MGMT: 0x000030c2 (ENable-EIST_Coordination ENable-EPB DISable-OOB)
  cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
  cpu0: MSR_HWP_CAPABILITIES: 0x011a203d (high 61 guar 32 eff 26 low 1)
  cpu0: MSR_HWP_REQUEST: 0x40003d0d (min 13 max 61 des 0 epp 0x40 window 0x0 pkg 0x0)
  cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff01 (min 1 max 255 des 0 epp 0x80 window 0x0)
  cpu0: MSR_HWP_INTERRUPT: 0x00000005 (EN_Guaranteed_Perf_Change, Dis_Excursion_Min)
  cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-Excursion_Min)
  cpu0: EPB: 6 (balanced)
  cpu0: MSR_IA32_POWER_CTL: 0x00e4005f (C1E auto-promotion: ENabled)
  cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x74008008 (UNdemote-C1, demote-C1, locked, pkg-cstate-limit=8 (unlimited))
  /dev/cpu_dma_latency: 2000000000 usec (default)
  current_driver: intel_idle
  current_governor: menu
  current_governor_ro: menu
  cpu0: POLL: CPUIDLE CORE POLL IDLE
  cpu0: C1ACPI: ACPI FFH MWAIT 0x0
  cpu0: C2ACPI: ACPI FFH MWAIT 0x21
  cpu0: C3ACPI: ACPI FFH MWAIT 0x60
  cpu0: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
  cpu0: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
  cpu0: MSR_PKGC8_IRTL: 0x00000000 (NOTvalid, 0 ns)
  cpu0: MSR_PKGC10_IRTL: 0x00000000 (NOTvalid, 0 ns)
  Uncore Frequency package0 die0: 800 - 3800 MHz (800 - 3800 MHz) 1800 MHz
  RAPL: 4766 sec. Joule Counter Range, at 55 Watts
  cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061 Joules, 0.000977 sec.)
  cpu0: MSR_PKG_POWER_INFO: 0x120000000001b8 (55 W TDP, RAPL 0 - 0 W, 0.017578 sec.)
  cpu0: MSR_PKG_POWER_LIMIT: 0x438500001f8640 (UNlocked)
  cpu0: PKG Limit #1: ENabled (200.000 Watts, 32.000000 sec, clamp ENabled)
  cpu0: PKG Limit #2: ENabled (160.000 Watts, 0.002441* sec, clamp ENabled)
  cpu0: MSR_VR_CURRENT_CONFIG: 0x00000850
  cpu0: PKG Limit #4: 266.000000 Watts (UNlocked)
  cpu0: MSR_DRAM_POWER_LIMIT: 0x00000000 (UNlocked)
  cpu0: DRAM Limit: DISabled (0.000 Watts, 0.000977 sec, clamp DISabled)
  cpu0: MSR_PP0_POLICY: 0
  cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
  cpu0: Cores Limit: DISabled (0.000 Watts, 0.000977 sec, clamp DISabled)
  cpu0: MSR_PP1_POLICY: 0
  cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
  cpu0: GFX Limit: DISabled (0.000 Watts, 0.000977 sec, clamp DISabled)
  cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0d690000 (92 C) (105 default - 13 offset)
  cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88320002 (55 C)
  cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x02000003 (105 C, 105 C)
  cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-pair L1-Prefetch L1-IP-Prefetch)
  Avg_MHz Busy%   Bzy_MHz TSC_MHz GFXMHz  GFXAMHz SAMMHz  SAMAMHz UncMHz
  3       0.20    1594    3071    550     550     1300    1300    1800
  2       0.11    1945    3072    550     550     1300    1300    1800
  10      0.53    1818    3072
  1       0.06    1380    3072
  2       0.15    1416    3072
  1       0.09    1315    3072
  5       0.33    1410    3072
  6       0.45    1338    3072
  2       0.12    1531    3072
  2       0.15    1471    3072
  1       0.08    1375    3072
  4       0.17    2113    3072
  3       0.16    2085    3072
  1       0.04    2058    3072
  5       0.23    2016    3072
  14      0.98    1410    3072
  1       0.04    1422    3072
  1       0.10    1435    3072
  2       0.11    1471    3072
  2       0.17    1418    3072
  6       0.33    1684    3072
  2       0.13    1465    3072
  1       0.08    1714    3072
  0       0.02    2270    3072
  3       0.13    1969    3072

To keep everything in one place, here is the acpi_cppc report you
requested earlier also for the X560WNR-G using the 6.18 mainline
kernel. This is identical again to the 6.14 kernel EXCEPT for the
`feedback_crts` field, which appears to be dynamic.

  X560WNR-G $ grep . /sys/devices/system/cpu/cpu*/acpi_cppc/*
  /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:85764085462 del:81092364612
  /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:61
  /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:30648952280 del:32319093196
  /sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:24418501228 del:26064639390
  /sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:30772876268 del:31630648127
  /sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:32208013456 del:33858924907
  /sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:34318996648 del:37357638199
  /sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:41344894184 del:40523832261
  /sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:36965175248 del:37144286195
  /sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
  /sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
  /sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:29796395364 del:30507895794
  /sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
  /sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
  /sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:30008884864 del:31394469575
  /sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:33127087692 del:36493571195
  /sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:47084742987 del:52088422560
  /sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:61
  /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:35405865204 del:37891455176
  /sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:31453151676 del:32354440344
  /sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:29395705360 del:30249765611
  /sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:34147115164 del:34129428131
  /sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:52863482561 del:63458169943
  /sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:63
  /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:53310134126 del:60839001140
  /sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:63
  /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:37661765305 del:39273578265
  /sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
  /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:37315012790 del:40229366158
  /sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
  /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:31209054793 del:33190454758
  /sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
  /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:27945691272 del:28942342249
  /sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:32
  /sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:61
  /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:26
  /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
  /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
  /sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
  /sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:30470288492 del:31360721157
  /sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
  /sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:33008945576 del:35214567794
  /sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:21
  /sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:46
  /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
  /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:15
  /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
  /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
  /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
  /sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
  /sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

Thanks again,

--
Aaron

--MP_/U19GPm6YGZI.dbqsi7FYSoh
Content-Type: application/octet-stream; name=check-intel-cpu-freq
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=check-intel-cpu-freq

IyEvYmluL2Jhc2gKCl9lY2hvTWF4Q29yZUZyZXFGbiAoKSB7CiAgIyBzaGVsbGNoZWNrIGRpc2Fi
bGU9U0MyMDM0CiAgZGVjbGFyZSBfYmVnaW5faW50IF9lbmRfaW50IF9tc2cgX2xvb3BfaWR4IF9j
b3JlX2lkeDsKICBfYmVnaW5faW50PSIkezE6LX0iOwogIF9lbmRfaW50PSIkezI6LX0iOwogIF9t
c2c9IlNhbXBsaW5nIGZyZXEgb2YgY29yZXMgfCR7X2JlZ2luX2ludH0uLiR7X2VuZF9pbnR9fCAy
MDAgdGltZXMgLi4uIjsKICAxPiYyIGVjaG8gIiR7X21zZ30iOwoKICBmb3IgKCggX2xvb3BfaWR4
ID0gMDsgX2xvb3BfaWR4IDwgMjAwOyBfbG9vcF9pZHgrKyApKTsgZG8KICAgIGZvciAoKCBfY29y
ZV9pZHggPSBfYmVnaW5faW50OyBfY29yZV9pZHggPD0gX2VuZF9pbnQ7IF9jb3JlX2lkeCsrICkp
OyBkbwogICAgICBfc3RyPSIkKGNhdCAiJHtfZnJlcURpcn0vcG9saWN5JHtfY29yZV9pZHh9L3Nj
YWxpbmdfY3VyX2ZyZXEiKSI7CiAgICAgIGVjaG8gIiR7X3N0cn0gJHtfY29yZV9pZHh9ICI7CiAg
ICBkb25lCiAgICBzbGVlcCAwLjA1OwogIGRvbmUgfHNvcnQgLXJuIHxoZWFkIC1uMQp9CgpfbWFp
bkZuICgpIHsKICBkZWNsYXJlIF9yZXBvcnRfc3RyIF9yZXBvcnRfbGlzdCBfbm90dXJib19pbnQg
X2RvX3R1cmJvIFwKICAgIF9jb3JlX3R5cGUgX2NvcmVfZGlyIF9yYW5nZV9zdHIgX2JlZ2luX2lu
dCBfZW5kX2ludCBcCiAgICBfbWF4X2NsYWltX2NvcmUgX21heF9jbGFpbV9mcmVxIF9iYXNlX2Ns
YWltX2NvcmUgXAogICAgX2Jhc2VfY2xhaW1fZnJlcSBfaWR4IF9zY3JhdGNoX2ludCBfc2NyYXRj
aF9zdHIgX2JpdF9saXN0IFwKICAgIF9tYXhfc3BlY19mcmVxIF9iYXNlX3NwZWNfZnJlcSBfbWF4
X3Rlc3RfZnJlcSBfbWF4X3Rlc3RfY29yZTsKCiAgZWNobzsgZWNobyAnPT0gQkVHSU4gPT0nOwog
IGVjaG8gJ1JlcG9ydCAoUHxFKSAodHVyYm98bm8tdHVyYm8pIChtYXh8YmFzZSkgZnJlcXVlbmNp
ZXMnCiAgcmVhZCAtcnAgJ1N0YXJ0IEdlZWtiZW5jaCA1IGluIGEgc2VwYXJhdGUgdGVybWluYWwg
YW5kIHJldHVybiBoZXJlJzsKICBfcmVwb3J0X2xpc3Q9KCk7CgogICMjIEJlZ2luIExvb3AgdGhy
b3VnaCBQIGFuZCBFIGNvcmUgdHlwZXMKICBmb3IgX2NvcmVfdHlwZSBpbiAnUCcgJ0UnOyBkbwog
ICAgIyBXZSByZWFkIHRoZSBjb3JlIHR5cGVzIHBlciB0aGlzIHNwZWM6CiAgICAjICAgaHR0cHM6
Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyLyBcCiAgICAjICAgdG9vbHMv
cGVyZi9Eb2N1bWVudGF0aW9uL2ludGVsLWh5YnJpZC50eHQKICAgIF9jb3JlX2Rpcj0nY3B1X2F0
b20nOwogICAgWyAiJHtfY29yZV90eXBlfSIgPSAnUCcgXSAmJiBfY29yZV9kaXI9J2NwdV9jb3Jl
JzsKICAgIF9yYW5nZV9zdHI9IiQoY2F0ICIke19ldmVudERpcn0vJHtfY29yZV9kaXJ9L2NwdXMi
KSI7CiAgICBfYmVnaW5faW50PSIkKGN1dCAtZjEgLWQtIDw8PCAiJHtfcmFuZ2Vfc3RyfSIpIjsK
ICAgIF9lbmRfaW50PSIkKCAgY3V0IC1mMiAtZC0gPDw8ICIke19yYW5nZV9zdHJ9IikiOwoKICAg
ICMjIEJlZ2luIExvb3AgdGhyb3VnaCB0dXJibyBzdGF0ZXMgKG9uLCBvZmYpCiAgICBmb3IgX25v
dHVyYm9faW50IGluICcxJyAnMCc7IGRvCiAgICAgIF9kb190dXJibz0neSc7CiAgICAgIFsgIiR7
X25vdHVyYm9faW50fSIgPSAxIF0gJiYgX2RvX3R1cmJvPSduJzsKICAgICAgZWNobyAiJHtfbm90
dXJib19pbnR9IiB8IDE+L2Rldi9udWxsIHN1ZG8gdGVlICIke19ub3R1cmJvRmlsZX0iIHx8IHRy
dWU7CiAgICAgIHNsZWVwIDE7CiAgICAgIGlmICEgZ3JlcCAtcSAiJHtfbm90dXJib19pbnR9IiAi
JHtfbm90dXJib0ZpbGV9IjsgdGhlbgogICAgICAgIGVjaG8gIkFCT1JUOiBUdXJibyBpcyBub3Qg
c2V0IGFzIGV4cGVjdGVkIHwke19ub3R1cmJvX2ludH18IjsKICAgICAgICByZXR1cm4gMTsKICAg
ICAgZmkKCiAgICAgICMgRGV0ZXJtaW5lIGludGVsLXNwZWNpZmllZCBmcmVxdWVuY2llcwogICAg
ICBlY2hvOwogICAgICBpZiBbICIke19jb3JlX3R5cGV9IiA9ICdQJyBdOyB0aGVuCiAgICAgICAg
X2Jhc2Vfc3BlY19mcmVxPSIke19zcGVjUENvcmVCYXNlTWF4fSI7CiAgICAgICAgaWYgWyAiJHtf
ZG9fdHVyYm99IiA9ICd5JyBdOyB0aGVuCiAgICAgICAgICBfbWF4X3NwZWNfZnJlcT0iJHtfc3Bl
Y1BDb3JlVHVyYm9NYXh9IjsgIyA1NDAwMDAwCiAgICAgICAgZWxzZQogICAgICAgICAgX21heF9z
cGVjX2ZyZXE9IiR7X3NwZWNQQ29yZUJhc2VNYXh9IjsgIyAyNzAwMDAwCiAgICAgICAgZmkKICAg
ICAgICBlY2hvICdNYWtlIHN1cmUgR2Vla0JlbmNoIFNJTkdMRSBjb3JlIGlzIHJ1bm5pbmcnOwog
ICAgICAgIHJlYWQgLXJwICcgIHRoZW4gcHJlc3MgWyBFbnRlciBdJzsKICAgICAgZWxzZQogICAg
ICAgIF9iYXNlX3NwZWNfZnJlcT0iJHtfc3BlY0VDb3JlQmFzZU1heH0iOwogICAgICAgIGlmIFsg
IiRfZG9fdHVyYm8iID0gJ3knIF07IHRoZW4KICAgICAgICAgIF9tYXhfc3BlY19mcmVxPSIke19z
cGVjRUNvcmVUdXJib01heH0iOyAjIDQ2MDAwMDAKICAgICAgICBlbHNlCiAgICAgICAgICBfbWF4
X3NwZWNfZnJlcT0iJHtfc3BlY0VDb3JlQmFzZU1heH0iOyAjIDIxMDAwMDAKICAgICAgICBmaQog
ICAgICAgIGVjaG8gJ01ha2Ugc3VyZSBHZWVrQmVuY2ggTVVMVEkgY29yZSBpcyBydW5uaW5nJzsK
ICAgICAgICByZWFkIC1ycCAnICB0aGVuIHByZXNzIFsgRW50ZXIgXSc7CiAgICAgIGZpCgogICAg
ICAjIyBCZWdpbiBMb29wIHRocm91Z2ggY29yZXMgdG8gZmluZCBjbGFpbWVkCiAgICAgICMgICBt
YXggc2NhbGluZyBhbmQgYmFzZSBmcmVxcyBhbmQgY29ycmVzcG9uZGluZyBjb3JlcwogICAgICBf
bWF4X2NsYWltX2NvcmU9MDsgX21heF9jbGFpbV9mcmVxPTA7IF9iYXNlX2NsYWltX2NvcmU9MDsg
X2Jhc2VfY2xhaW1fZnJlcT0wOwogICAgICBmb3IgKCggX2lkeCA9IF9iZWdpbl9pbnQ7IF9pZHgg
PD0gX2VuZF9pbnQ7IF9pZHgrKyApKTsgZG8KICAgICAgICBfc2NyYXRjaF9pbnQ9IiQoY2F0ICIk
e19mcmVxRGlyfS9wb2xpY3kke19pZHh9L2NwdWluZm9fbWF4X2ZyZXEiKSI7CiAgICAgICAgaWYg
KCggX3NjcmF0Y2hfaW50ID49IF9tYXhfY2xhaW1fZnJlcSApKTsgdGhlbgogICAgICAgICAgX21h
eF9jbGFpbV9mcmVxPSIke19zY3JhdGNoX2ludH0iOwogICAgICAgICAgX21heF9jbGFpbV9jb3Jl
PSIke19pZHh9IjsKICAgICAgICBmaQogICAgICAgIF9zY3JhdGNoX2ludD0iJChjYXQgIiR7X2Zy
ZXFEaXJ9L3BvbGljeSR7X2lkeH0vYmFzZV9mcmVxdWVuY3kiKSI7CiAgICAgICAgaWYgKCggX3Nj
cmF0Y2hfaW50ID49IF9iYXNlX2NsYWltX2ZyZXEgKSk7IHRoZW4KICAgICAgICAgIF9iYXNlX2Ns
YWltX2ZyZXE9IiR7X3NjcmF0Y2hfaW50fSI7CiAgICAgICAgICBfYmFzZV9jbGFpbV9jb3JlPSIk
e19pZHh9IjsKICAgICAgICBmaQogICAgICBkb25lCiAgICAgICMjIC4gRW5kIExvb3AgdGhyb3Vn
aCBjb3JlcyB0byBmaW5kCgogICAgICAjIFNldCBleHBlY3RlZCB2YWx1ZXMKICAgICAgZWNobzsg
ZWNobyAiU2FtcGxlIGZyZXE6IFR5cGUgfCR7X2NvcmVfdHlwZX18IFR1cmJvIHwke19kb190dXJi
b15efXwiOwogICAgICByZWFkIC1ycCAnICBwcmVzcyBbIEVudGVyIF0gdG8gdGFrZSBmcmVxdWVu
Y3kgc2FtcGxlcy4uLiAnOwogICAgICBfc2NyYXRjaF9zdHI9IiQoX2VjaG9NYXhDb3JlRnJlcUZu
ICIke19iZWdpbl9pbnR9IiAiJHtfZW5kX2ludH0iKSI7CiAgICAgIElGUz0nICcgcmVhZCAtcmEg
X2JpdF9saXN0IDw8PCAiJHtfc2NyYXRjaF9zdHJ9IjsKICAgICAgX21heF90ZXN0X2ZyZXE9IiR7
X2JpdF9saXN0WzBdfSI7CiAgICAgIF9tYXhfdGVzdF9jb3JlPSIke19iaXRfbGlzdFsxXX0iOwoK
ICAgICAgIyBSZXBvcnQgdmFsdWVzIGZyb20gc2VhcmNoCiAgICAgIFsgIiR7X2RvX3R1cmJvfSIg
PSAneScgXSAmJiBfc2NyYXRjaF9zdHI9J09OJyB8fCBfc2NyYXRjaF9zdHI9J29mZic7CiAgICAg
IF9yZXBvcnRfc3RyPSIkKAogICAgICAgICMgc2hlbGxjaGVjayBkaXNhYmxlPVNDMjA1OQogICAg
ICAgIHByaW50ZiAiJHtfZm9ybWF0U3RyfSIgIiR7X2NvcmVfdHlwZX0iICIke19zY3JhdGNoX3N0
cn0iIFwKICAgICAgICAgICIke19iYXNlX2NsYWltX2ZyZXF9IiAiJHtfYmFzZV9jbGFpbV9jb3Jl
fSIgIiR7X2Jhc2Vfc3BlY19mcmVxfSIgXAogICAgICAgICAgIiR7X21heF9jbGFpbV9mcmVxfSIg
IiR7X21heF9jbGFpbV9jb3JlfSIgIiR7X21heF9zcGVjX2ZyZXF9IiBcCiAgICAgICAgICAiJHtf
bWF4X3Rlc3RfZnJlcX0iICAiJHtfbWF4X3Rlc3RfY29yZX0iCiAgICAgICkiOwogICAgICBfcmVw
b3J0X2xpc3QrPSgiJHtfcmVwb3J0X3N0cn0iKTsKICAgIGRvbmUKICAgICMjIC4gRW5kIExvb3Ag
dGhyb3VnaCB0dXJibyBzdGF0ZXMgKG9uLCBvZmYpCiAgZG9uZQogICMjIC4gRW5kIExvb3AgdGhy
b3VnaCBQIGFuZCBFIGNvcmUgdHlwZXMKCiAgZWNobzsgZWNobyAnPT0gUkVQT1JUID09JzsKICBl
Y2hvICIke19oZWFkZXJTdHJ9IjsKICAoIElGUz0kJ1xuJzsgZWNobyAiJHtfcmVwb3J0X2xpc3Rb
Kl19IjsgKQoKICBlY2hvOwogIGNhdCA8PCAnRU9GJwojIyBLZXkKCkNvbHVtbiAgfCBWYWx1ZXMg
fCBQdXJwb3NlCi0tLS0tLS0tfC0tLS0tLS0tfC0tLS0tLS0tLQpUeXBlICAgIHwgUHxFICAgIHwg
VGhlIHN1YnNldCBvZiBjb3JlcyB0aGlzIHJvdyBhcHBsaWVkIHRvLgogICAgICAgIHwgICAgICAg
IHwgICBGb3IgZXhhbXBsZSwgYFBgIG1lYW5zIGBhbGwgUC1jb3Jlc2AuClR1cmJvICAgfCBvZmZ8
T04gfCBUaGUgdHVyYm8gc2V0dGluZyBvZiB0aGlzIGNvcmUgc3Vic2V0LgpCLUNsYWltIHwgaW50
IEh6IHwgVGhlIG1heCBgYmFzZV9mcmVxdWVuY3lgIHZhbHVlIG9mIHRoaXMgY29yZSBzdWJzZXQu
CiAgICAgSWQgfCBpbnQgICAgfCBUaGUgY29yZSBpZCB0aGF0IHByb3ZpZGVkIHRoZSBCYXNlLUNs
YWltIHZhbHVlLgpCLVNwZWMgIHwgaW50IEh6IHwgSW50ZWwgU1BFQydEIEJBU0UgZnJlcSBmb3Ig
dGhpcyBDUFUncyBjb3JlIFR5cGUuCk0tQ2xhaW0gfCBpbnQgSHogfCBUaGUgbWF4IGBjcHVpbmZv
X21heF9mcmVxYCB2YWx1ZSBvZiB0aGlzIGNvcmUgc3Vic2V0LgogICAgIElkIHwgaW50ICAgIHwg
VGhlIGNvcmUgaWQgdGhhdCBwcm92aWRlZCB0aGUgTWF4LUNsYWltIHZhbHVlLgpNLVNwZWMgIHwg
aW50IEh6IHwgSW50ZWwgU1BFQydEIE1BWCBmcmVxIGZvciB0aGlzIENQVSdzIGNvcmUgVHlwZS4K
TS1UZXN0ICB8IGludCBIeiB8IFRoZSBtYXggYHNjYWxpbmdfY3VyX2ZyZXFgIHZhbHVlIG9mIHRo
aXMgY29yZSBzdWJzZXQuCiAgICAgICAgfCAgICAgICAgfCAgIFRoZSBlbnRpcmUgY29yZSBzdWJz
ZXQgaXMgc2FtcGxlZCAyMDB4LgogICAgIElkIHwgaW50ICAgIHwgVGhlIGNvcmUgaWQgdGhhdCBw
cm92aWRlZCB0aGUgTWF4LVRlc3QgdmFsdWUuCgpFT0YKICBlY2hvICc9PSBFTkQgICA9PSc7IGVj
aG87Cn0KCmRlY2xhcmUgX2V2ZW50RGlyIF9jcHVEaXIgX2ZyZXFEaXIgX25vdHVyYm9GaWxlIFwK
ICBfaGVhZGVyU3RyIF9mb3JtYXRTdHIgX2NwdUlkIF9zcGVjUENvcmVUdXJib01heCBfYml0TGlz
dCBcCiAgX3NwZWNFQ29yZVR1cmJvTWF4IF9zcGVjUENvcmVCYXNlTWF4IF9zcGVjRUNvcmVCYXNl
TWF4OwpkZWNsYXJlIC1BIF9zcGVjTWF0cml4OwoKIyBHZXQgc3BlY3MgZm9yIENQVXMgZnJvbSBh
IHBhZ2UgbGlrZSB0aGlzIGZvciB0aGUgJ1VsdHJhIDkgMjc1SFgnOgojICAgaHR0cHM6Ly93d3cu
aW50ZWwuY29tL2NvbnRlbnQvd3d3L3VzL2VuL3Byb2R1Y3RzL3NrdS8yNDIyOTMvaW50ZWwtY29y
ZQojICAgLXVsdHJhLTktcHJvY2Vzc29yLTI3NWh4LTM2bS1jYWNoZS11cC10by01LTQwLWdoei9z
cGVjaWZpY2F0aW9ucy5odG1sCl9zcGVjTWF0cml4PSgKICAjIENQVSBOYW1lO1AtdHVyYm8tbWF4
O0UtdHVyYm8tbWF4O1AtYmFzZTtFLWJhc2UKICBbJ0ludGVsIENvcmUgVWx0cmEgOSAyNzVIWCdd
PSc1NDAwMDAwOzQ2MDAwMDA7MjcwMDAwMDsyMTAwMDAwJwogIFsnSW50ZWwgQ29yZSBVbHRyYSA3
IDI1NUgnXT0nNTEwMDAwMDs0NDAwMDAwOzIwMDAwMDA7MTUwMDAwMCcKICBbJ0ludGVsIENvcmUg
VWx0cmEgNSAyMjVIJ109JzQ5MDAwMDA7NDMwMDAwMDsxNzAwMDAwOzEzMDAwMDAnCiAgWydJbnRl
bCBDb3JlIGk5LTE0OTAwSFgnXT0nNTgwMDAwMDs0MTAwMDAwOzIyMDAwMDA7MTYwMDAwMCcKKTsK
X2NwdUlkPSIkKAogIGxzY3B1IFwKICAgIHwgZ3JlcCAnTW9kZWwgbmFtZTonIFwKICAgIHwgZ3Jl
cCAtdiAnQklPUyBNb2RlbCBuYW1lOicgXAogICAgfCBhd2sgLUYnOicgJ3sgcHJpbnQgJDIgfScg
XAogICAgfCBzZWQgJ3MvXiAqLy87IHMvKFwoUlx8VE1cKSkvL2cnCikiOwpfc3BlY0xpbmU9IiR7
X3NwZWNNYXRyaXhbIiR7X2NwdUlkfSJdfSI7CmlmIFsgLXogIiR7X3NwZWNMaW5lOi19IiBdOyB0
aGVuCiAgZWNobyAiQUJPUlQ6IENhbm5vdCBmaW5kIHByb2Nlc3NvciB8JHtfY3B1SWR9fCBzcGVj
cyEiOwogIGVjaG8gIiAgUGxlYXNlIGdldCB0aGUgc3BlY3MgZnJvbSBJbnRlbCBhbmQgYWRkIHRv
IHRoZSBfc3BlY01hdHJpeC4iCiAgZXhpdCAxOwpmaQpJRlM9JzsnIHJlYWQgLXJhIF9iaXRMaXN0
IDw8PCAiJHtfc3BlY0xpbmV9IjsKX3NwZWNQQ29yZVR1cmJvTWF4PSIke19iaXRMaXN0WzBdfSI7
Cl9zcGVjRUNvcmVUdXJib01heD0iJHtfYml0TGlzdFsxXX0iOwpfc3BlY1BDb3JlQmFzZU1heD0i
JHtfYml0TGlzdFsyXX0iOwpfc3BlY0VDb3JlQmFzZU1heD0iJHtfYml0TGlzdFszXX0iOwoKX2V2
ZW50RGlyPScvc3lzL2J1cy9ldmVudF9zb3VyY2UvZGV2aWNlcyc7Cl9jcHVEaXI9Jy9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1JzsKX2ZyZXFEaXI9IiR7X2NwdURpcn0vY3B1ZnJlcSI7Cl9ub3R1cmJv
RmlsZT0iJHtfY3B1RGlyfS9pbnRlbF9wc3RhdGUvbm9fdHVyYm8iOwpfaGVhZGVyU3RyPSIkKGNh
dCA8PCBFT0YKQ1BVOiAke19jcHVJZH0KVHlwZSB8IFR1cmJvIHwgQi1DbGFpbSAuIElkIHwgQi1T
cGVjICB8IE0tQ2xhaW0gLiBJZCB8IE0tU3BlYyAgfCBNLVRlc3QgIC4gSWQKLS0tLS18IC0tLS0t
IHwgLS0tLS0tLS0tLS0tIHwgLS0tLS0tLSB8IC0tLS0tLS0tLS0tLSB8LS0tLS0tLS0gfCAtLS0t
LS0tLS0tLS0KRU9GCikiOwpfZm9ybWF0U3RyPSIkKGNhdCA8PCdFT0YnCiUtNHMgfCAlLTVzIHwg
JTA2ZCAuICUwMmQgfCAlMDZkIHwgJTA2ZCAuICUwMmQgfCAlMDZkIHwgJTA2ZCAuICUwMmQKRU9G
CikiOwoKX21haW5GbjsK

--MP_/U19GPm6YGZI.dbqsi7FYSoh--

