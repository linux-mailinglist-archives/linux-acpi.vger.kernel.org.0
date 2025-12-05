Return-Path: <linux-acpi+bounces-19455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C52CA925E
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 20:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE9F3035D18
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584D352959;
	Fri,  5 Dec 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keVaQHEY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6863522CF;
	Fri,  5 Dec 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964233; cv=none; b=louKQs392QaLXmvGd3dTP1CQKpzoDmK5MN3ehgD9U5ekcNobDxcRdc5eryQfjH2p0XdrGVoL2US683c1fRXH9wUgqXEbcN77mIvT1Jm17agEIkTWFg1wOnWmY1hpLKaO2cvcuS13MdHKp3g+huvwBCKKf30SDIh07LquLWQZIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964233; c=relaxed/simple;
	bh=lI6NRNfMRbsVVLIQwOqyY7Me4RzC27guyU1yl3O/jbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rAgNDT+2PUBcNb/7LTV2SZE4PP5SAhscDKMmTSXRfgt0DaSablreQzAzoeL1Yhdm5ZDGDStCS5PrWQt8pYVt+s68C9hsHyHPS+zn4WcnlSDwpQkjH5sGIqZJKvQn1RtamPoxdkdElRridNp/Qnm56VGp5VIXNux3/hSxLPbh2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keVaQHEY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764964229; x=1796500229;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lI6NRNfMRbsVVLIQwOqyY7Me4RzC27guyU1yl3O/jbk=;
  b=keVaQHEYCUgxCqjFeDMNhJkmhH6XshahrA+97hgjpBpqpIhwXbP2fKEC
   msWCa8o9NLMLROWibHrrkQ926PZM4D0P7KpG20EewDhw37WXkjtIy2UTb
   4Usw7YQF72IRyXeQRC/fQ1fuktJLvGVauTyTaIyCO3TM7oZM+2hP3co0H
   M18bCPdMYj9vKOlgIrgzBrVcgHIJ/tEXRDFRIfCmlRfegBczUXxr9cdz5
   3Hbs0MLTJNzC2lXu4pynUNjZ4rj7zglt1erWGGw8e1Z0v2gEfoKlpUswx
   cZviD0E8xcghFo/+APu9j0/wuFt3A0FMUI2OovCCA61066fwSr2vjYN2g
   g==;
X-CSE-ConnectionGUID: HfwcarLdTPu33ae8bwxQ0A==
X-CSE-MsgGUID: Ao+Ja744QSKlYZ3hXARzcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="67042441"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="67042441"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:50:26 -0800
X-CSE-ConnectionGUID: LR01TraKRh+wC0izfz6cgA==
X-CSE-MsgGUID: VWtreVLeQmmx8rmonbzngA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195817750"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:50:10 -0800
Message-ID: <c7bdb6cb02437d1ab41495d526c3d2ee3f1f7c60.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Aaron Rainbolt <arainbolt@kfocus.org>, kernel-team@lists.ubuntu.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	rjw@rjwysocki.net, mmikowski@kfocus.org
Date: Fri, 05 Dec 2025 11:50:07 -0800
In-Reply-To: <CAJZ5v0hUc3oz=Z8UUv3n4rY3on1vZpCtSdKjgOFp+OWYC5D9tw@mail.gmail.com>
References: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
	 <20251126170031.145b6a56@kf-m2g5> <20251203113851.52bf872b@kf-m2g5>
	 <849e7394b8c7c4b74d1d55648a8d4b55b49aa91a.camel@linux.intel.com>
	 <CAJZ5v0hUc3oz=Z8UUv3n4rY3on1vZpCtSdKjgOFp+OWYC5D9tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 20:28 +0100, Rafael J. Wysocki wrote:
> On Fri, Dec 5, 2025 at 8:11=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Hi Aaron,
> >=20
> > On Wed, 2025-12-03 at 11:38 -0600, Aaron Rainbolt wrote:
> > > On Wed, 26 Nov 2025 17:00:31 -0600
> > > Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> > >=20
> > >=20
> > >=20
> > ...
> >=20
> >=20
> >=20
> > There are too many platforms here, don't have time to get to all.
> > So
> > let's focus on one first.
> >=20
> > ## Clevo | X580WNT-G=C2=A0 | Ultra 9 275HX | 6.18.0-061800rc7-generic
> >=20
> > Summary:
> > There is no scaling factor related issue as reported before on
> > ASROCK
> > platform before. The achieved maximum frequencies are correct.
> >=20
> > The base_freq display is wrong (see below because of BIOS config).
> > The cpuinfo_max_freq wrong display is not related to scaling factor
> > but
> > something else
> >=20
> >=20
> > To check, I need dump of:
> > m=3D$(getconf _NPROCESSORS_ONLN); for ((i=3D0; i<m; i++)); do echo
> > CPU$i;
> > sudo rdmsr -p $i 0x771;=C2=A0 sudo rdmsr -p $i 0x774; done
> >=20
> > But I expect them to match the acpi_cppc/highest_perf, which is
> > showing
> > 3.9GHz.
> >=20
> > What command you to report " M-Test=C2=A0 . Id"?
> >=20
> > I think some busy 100% workload running on a single CPU.
> >=20
> >=20
> >=20
> > Analsis:
> >=20
> > Intel=C2=AE Core=E2=84=A2 Ultra 9 Processor 275HX
> > 8+16 no HT
> > Performance-core Base Frequency : 2.7 GHz
> > Efficient-core Base Frequency : 2.1 GHz
> >=20
> >=20
> > P-cores: 0-7
> > Nominal freq: 2700
> > Nominal perf: 43
> > Scaling : ~1.6 (correct)
> >=20
> > E-cores:
> > 8-
> > Nominal freq: 2100
> > Nominal perf: 29
> > Scaling : ~1.38 (close to 1.4 so there will be some rounding issue)
> >=20
> > So,=C2=A0 this is not related to scaling factor as before like on ASROC=
K
> >=20
> >=20
> > The P-cores under report `base_frequency` and `cpuinfo_max_freq`.
> >=20
> > - FAIL: With Turbo ON or off, the claimed `base_freqency` (B-Claim)
> > of
> > 2000000 does
> > =C2=A0 NOT match the Intel spec (B-Spec) of 2700000.
> >=20
> > From CPPC:
> >=20
> > /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
> > The base freq reported by cpufreq: 3200/1.6 =3D 2000
> >=20
> >=20
> >=20
> >=20
> > - FAIL: With Turbo off, the claimed `cpuinfo_max_freq` (M-Claim) of
> > 2000000 does
> > =C2=A0 NOT match the Intel spec (M-Spec) of 2700000.
> >=20
> > We don=E2=80=99t depend on ACPI CPPC to achieve the measured value. Whe=
n
> > you
> > are busy you are getting 2700, so the behavior is correct as the
> > per
> > the CPU spec.
> >=20
> >=20
> >=20
> > - FAIL: With Turbo ON, the claimed `cpuinfo_max_freq` (M-Claim) of
> > 3900000 does
> > =C2=A0 NOT match the Intel spec (M-Spec) of 5400000.
> >=20
> > ACPI CPPC also tells 3.9 GHz as max. But we don=E2=80=99t depend on it.
>=20
> But we depend on HWP_CAP.highest_perf =3D=3D CPPC.highest_perf (because
> the CPPC value comes from HWP).

That's why asked for dump of MSRs above. This should match CPPC value.
But seems setting HWP_REQ.max_perf=3D61 or 62 on P-core still results in
5.4 Ghz.

Thanks,
Srinivas



