Return-Path: <linux-acpi+bounces-19450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00423CA90D5
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 20:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB94930BAFEF
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9AD36215C;
	Fri,  5 Dec 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNReunAs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D235A93A;
	Fri,  5 Dec 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961824; cv=none; b=Bx6hQeEH7Jx2AaSICysDF4aBqgHQ+bNuXVwjeBzGJ3Qru+t9CXxBLJz/i0KnfHcuQP3QUrEiixpj8xrxXdoUIi4sGYv8najmqKcwdiTHtG21Pvu86WLyRKC3JHDcwEk+jopVUCtMfL0I2O0GzY3t0l3njxU5wiA/u0DlowNjPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961824; c=relaxed/simple;
	bh=ll+hJgmzZB2EpEeMkcmm7XEunoxk18NoFuMTdfh7p8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=olHywZ3zhiUFjAgSFKuYmkCM4tgOF2MbLojsJEYUgt309F5PupHaqqR8u+RmqdWC2o9naXNXFFMb6zIAhHTi1O/ATgdPSI727LQLsMGNq0hBcclvLqOzj60VyWLTSdCUKBKM4qINKqh6ViTAekV8vbre6pFbtnlnznxbj8Z6vSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNReunAs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764961823; x=1796497823;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ll+hJgmzZB2EpEeMkcmm7XEunoxk18NoFuMTdfh7p8M=;
  b=ZNReunAsRDeY+hS9UGxmzrNZfQZcw5jwD3Wzy0BA+WFD7xHHdQ7HFUPO
   pTeRtR/vhz5fOBBX1rkfykLcM5I5eWoyKfqx1IIriJXDbr8ezUGlg8oLe
   CFb2oI4JlN6KfwUMwGRWiP/CYIHSGYnFfy9xzZcLOy5Icv1r+j5qPsNZW
   fzs+9oWHfzbUSolvde395tKiFEx/KvVbHf9i0GVag4OxTfuP+e7kTEM4G
   50gx7WtdJChuHmQAWZFpbm2lw3Yqe7OyI6gtx3Kyz9NIgrC7VrYmcE/fK
   RszCBxCoSOQHf8l7rmknXGpqKh5d5A5rUymt7f9myngSPbucuNlnFmlnv
   w==;
X-CSE-ConnectionGUID: hNgzs5qMTZyxj0mlLpx5rQ==
X-CSE-MsgGUID: XqvO+QWSSIa3pjPNicKdhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="70849441"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="70849441"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:10:22 -0800
X-CSE-ConnectionGUID: KMaDP97+RLi6fhnd2cy3nQ==
X-CSE-MsgGUID: 6Ypq3fG3TiyckWv149RSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195385066"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:10:22 -0800
Message-ID: <849e7394b8c7c4b74d1d55648a8d4b55b49aa91a.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 mmikowski@kfocus.org
Date: Fri, 05 Dec 2025 11:10:21 -0800
In-Reply-To: <20251203113851.52bf872b@kf-m2g5>
References: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
		<20251126170031.145b6a56@kf-m2g5> <20251203113851.52bf872b@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aaron,

On Wed, 2025-12-03 at 11:38 -0600, Aaron Rainbolt wrote:
> On Wed, 26 Nov 2025 17:00:31 -0600
> Aaron Rainbolt <arainbolt@kfocus.org> wrote:
>=20
>=20
>=20
...



There are too many platforms here, don't have time to get to all. So
let's focus on one first.

## Clevo | X580WNT-G  | Ultra 9 275HX | 6.18.0-061800rc7-generic=20

Summary:
There is no scaling factor related issue as reported before on ASROCK
platform before. The achieved maximum frequencies are correct.

The base_freq display is wrong (see below because of BIOS config).
The cpuinfo_max_freq wrong display is not related to scaling factor but
something else


To check, I need dump of:
m=3D$(getconf _NPROCESSORS_ONLN); for ((i=3D0; i<m; i++)); do echo CPU$i;
sudo rdmsr -p $i 0x771;  sudo rdmsr -p $i 0x774; done

But I expect them to match the acpi_cppc/highest_perf, which is showing
3.9GHz.

What command you to report " M-Test  . Id"?

I think some busy 100% workload running on a single CPU.



Analsis:

Intel=C2=AE Core=E2=84=A2 Ultra 9 Processor 275HX
8+16 no HT
Performance-core Base Frequency : 2.7 GHz
Efficient-core Base Frequency : 2.1 GHz


P-cores: 0-7
Nominal freq: 2700
Nominal perf: 43
Scaling : ~1.6 (correct)

E-cores:
8-
Nominal freq: 2100
Nominal perf: 29
Scaling : ~1.38 (close to 1.4 so there will be some rounding issue)

So,  this is not related to scaling factor as before like on ASROCK


The P-cores under report `base_frequency` and `cpuinfo_max_freq`.

- FAIL: With Turbo ON or off, the claimed `base_freqency` (B-Claim) of
2000000 does
  NOT match the Intel spec (B-Spec) of 2700000.

From CPPC:

/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
The base freq reported by cpufreq: 3200/1.6 =3D 2000




- FAIL: With Turbo off, the claimed `cpuinfo_max_freq` (M-Claim) of
2000000 does
  NOT match the Intel spec (M-Spec) of 2700000.

We don=E2=80=99t depend on ACPI CPPC to achieve the measured value. When yo=
u
are busy you are getting 2700, so the behavior is correct as the per
the CPU spec.



- FAIL: With Turbo ON, the claimed `cpuinfo_max_freq` (M-Claim) of
3900000 does
  NOT match the Intel spec (M-Spec) of 5400000.

ACPI CPPC also tells 3.9 GHz as max. But we don=E2=80=99t depend on it.=20

- pass: With Turbo ON or off, the measured `scaling_cur_freq` (M-Test)
values are
  in-line with Intel specs (M-Spec).

Good. As we expect.

Thanks,
Srinivas




> * The manufacturer and model codes for each machine we tested are in
> the
> =C2=A0 "2025-11-26_cpu_freq_report.md" file.
> * We're seeing the misreporting problems on at least five models of
> =C2=A0 machines from three different manufacturers (ASUS, Clevo, and
> =C2=A0 TongFang). Every Arrow Lake system we've checked is affected. This
> =C2=A0 doesn't rule out BIOS issues I guess, but it seems somewhat
> unlikely
> =C2=A0 that three manufacturers would mess up their BIOS in the same way.
> =C2=A0 The reports are for three models of Clevo machines and one ASUS
> NUC,
> =C2=A0 we haven't gotten final test results for the TongFang machine in
> =C2=A0 question.
> * On all affected systems we've seen, *either* P-core frequency is
> =C2=A0 mis-reported, *or* E-core frequency is mis-reported, but never
> both.
> =C2=A0 One core type always has its frequencies reported correctly, the
> =C2=A0 other core type's frequencies are reported incorrectly.
> * All systems tested were using the latest BIOS from the
> manufacturer,
> =C2=A0 to our awareness.
>=20
> Thanks again, and let me know if there's any other info we can
> provide.

