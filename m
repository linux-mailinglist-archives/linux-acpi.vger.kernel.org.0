Return-Path: <linux-acpi+bounces-10813-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D41A1B7BD
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 15:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39949188FAB4
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCF1292CE;
	Fri, 24 Jan 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HURcme60"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3784317E;
	Fri, 24 Jan 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728312; cv=none; b=q9xCGUt0tu1CKFGGS1aMhzSYAsRawH8R8FhSOqkP4QPFJKL4oXlZCQKv9vitCl6YpE93sdGUNAwiJxQCPRWyNqsq7oM0Ivy+KsxH0ZxcHCDk4PhIaUnxEx9rP/UUfpeY7AoEey8l+Rt6LFx4RamK1I4gMSn9kL4GSY/N/d9+HQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728312; c=relaxed/simple;
	bh=M/VPdcE0C/7q3pYsaP0muz7Dbg7CDuXeXmvJvHrsiQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDYjIkls/abpLRyaHA0Mdg+mkBJzjb/nHscEY5vXVyg8Q1EYvThvk7L8rPxClhja30MW7QpqaHfOOvu0curJlsgm4WbD/XbmKPNI8U0WPNwYRvKPX45kX/PEVmYM+fhKcjzmCPBn1hhpFy/MmKE3uVsDHRqPJ+k/9CvsQ6cQw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HURcme60; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737728311; x=1769264311;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=M/VPdcE0C/7q3pYsaP0muz7Dbg7CDuXeXmvJvHrsiQQ=;
  b=HURcme60a5C1ifHWsQ/chlBO6ii7PPjuLexUZ4+A0wjTcrPN0Ryqoldl
   RCTfUfbBcQqCRXHSua9VHH4gs0zBZ11uswAsm0jsXDwUQIw/8z0SMctWV
   2XUanhSOfL62lSOBebn/a2kHjcTfusd/c72oGVBCvg2JzheX5FSbzLmfS
   BJBX+WR0DmLs1nEljQkYWm3H3w6mpMloqIkOWH9lW37TvGg4nE5l7IlgV
   WLeRj1MkdFBPZCpM+66LbwyPQrYvz8sfV+AXRWRv2DxVsXHfnnJtMsgbt
   BM+xZWxuI2g2YGrrieATf9DJGYwF8mK7oFHvNR6iNc8Ug1HM9grT8hXZ7
   A==;
X-CSE-ConnectionGUID: IOq+alAnTZCYs6vvRzGDhw==
X-CSE-MsgGUID: DnY7EdzYSbW27Ch54RQOTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="37961297"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="37961297"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 06:18:30 -0800
X-CSE-ConnectionGUID: +jz/2B9xReyZes9X90f8qQ==
X-CSE-MsgGUID: iVUFuWKoQdKLMqfaDPqGoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131078574"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 06:18:28 -0800
Message-ID: <bf3d232eef124080eb0482ff1b43c17739a1c50b.camel@linux.intel.com>
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection
 in cppc_cpufreq
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, Mario Limonciello	
 <mario.limonciello@amd.com>, Pierre Gondois <pierre.gondois@arm.com>, 
 Russell Haley <yumpusamongus@gmail.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, 	viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxarm@huawei.com, 	jonathan.cameron@huawei.com, gautham.shenoy@amd.com,
 ray.huang@amd.com, 	zhanjie9@hisilicon.com, lihuisong@huawei.com,
 hepeng68@huawei.com, 	fanghao11@huawei.com
Date: Fri, 24 Jan 2025 06:18:28 -0800
In-Reply-To: <0c511da2-6a4a-4fa2-9d82-da45d1afe346@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
	 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
	 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
	 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
	 <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
	 <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
	 <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
	 <32d084f3-f114-420e-affa-2f7ba107de0d@amd.com>
	 <eadd291e-c797-4d7d-b1f9-f8778fa58b23@huawei.com>
	 <6267261b-4e4a-475f-b17d-5473d72b2c2a@linux.intel.com>
	 <9f5f8181-7d0e-415d-b473-0e3c6601ccc3@amd.com>
	 <0c511da2-6a4a-4fa2-9d82-da45d1afe346@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 11:53 +0800, zhenglifeng (A) wrote:
> On 2025/1/24 1:05, Mario Limonciello wrote:
>=20
> > On 1/23/2025 10:46, Srinivas Pandruvada wrote:
> > >=20
> > > On 1/20/25 18:42, zhenglifeng (A) wrote:
> > > > On 2025/1/21 1:44, Mario Limonciello wrote:
> > > >=20
> > > > > On 1/20/2025 08:49, Pierre Gondois wrote:
> > > > > >=20
> > > > > > On 1/20/25 04:15, zhenglifeng (A) wrote:
> > > > > > > On 2025/1/17 22:30, Mario Limonciello wrote:
> > > > > > >=20
> > > > > > > > On 1/16/2025 21:11, zhenglifeng (A) wrote:
> > > > > > > > > On 2025/1/16 19:39, Russell Haley wrote:
> > > > > > > > >=20
> > > > > > > > > > Hello,
> > > > > > > > > >=20
> > > > > > > > > > I noticed something here just as a user casually
> > > > > > > > > > browsing the mailing list.
> > > > > > > > > >=20
> > > > > > > > > > On 1/13/25 6:21 AM, Lifeng Zheng wrote:
> > > > > > > > > > > Add sysfs interfaces for CPPC autonomous
> > > > > > > > > > > selection in the cppc_cpufreq
> > > > > > > > > > > driver.
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Lifeng Zheng
> > > > > > > > > > > <zhenglifeng1@huawei.com>
> > > > > > > > > > > ---
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0 .../ABI/testing/sysfs-devices-syst=
em-cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > |=C2=A0 54 +++++++++
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0 drivers/cpufreq/cppc_cpufreq.c=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > > > > > > > > > > | 109 +++++++ ++++ +++++++
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0 2 files changed, 163 insertions(+)
> > > > > > > > > > >=20
> > > > > > > > > > > diff --git a/Documentation/ABI/testing/sysfs-
> > > > > > > > > > > devices-system-cpu b/
> > > > > > > > > > > Documentation/ABI/testing/sysfs-devices-system-
> > > > > > > > > > > cpu
> > > > > > > > > > > index 206079d3bd5b..3d87c3bb3fe2 100644
> > > > > > > > > > > --- a/Documentation/ABI/testing/sysfs-devices-
> > > > > > > > > > > system-cpu
> > > > > > > > > > > +++ b/Documentation/ABI/testing/sysfs-devices-
> > > > > > > > > > > system-cpu
> > > > > > > > > > > @@ -268,6 +268,60 @@ Description:=C2=A0=C2=A0=C2=A0 D=
iscover
> > > > > > > > > > > CPUs in the same CPU frequency coordination
> > > > > > > > > > > domain
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 This file is only present if the
> > > > > > > > > > > acpi-cpufreq or the cppc-cpufreq
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 drivers are in use.
> > > > > > > > > > [...snip...]
> > > > > > > > > >=20
> > > > > > > > > > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
> > > > > > > > > > > +Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Octo=
ber 2024
> > > > > > > > > > > +Contact:=C2=A0=C2=A0=C2=A0 linux-pm@vger.kernel.org
> > > > > > > > > > > +Description:=C2=A0=C2=A0=C2=A0 Energy performance pr=
eference
> > > > > > > > > > > +
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Read/writ=
e an 8-bit integer from/to this
> > > > > > > > > > > file. This file
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 represent=
s a range of values from 0
> > > > > > > > > > > (performance preference) to
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xFF (ene=
rgy efficiency preference) that
> > > > > > > > > > > influences the rate of
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 performan=
ce increase/decrease and the
> > > > > > > > > > > result of the hardware's
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 energy ef=
ficiency and performance
> > > > > > > > > > > optimization policies.
> > > > > > > > > > > +
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Writing t=
o this file only has meaning
> > > > > > > > > > > when Autonomous Selection is
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled.
> > > > > > > > > > > +
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file=
 only presents if the cppc-
> > > > > > > > > > > cpufreq driver is in use.
> > > > > > > > > > In intel_pstate driver, there is file with near-
> > > > > > > > > > identical semantics:
> > > > > > > > > >=20
> > > > > > > > > > /sys/devices/system/cpu/cpuX/cpufreq/energy_perform
> > > > > > > > > > ance_preference
> > > > > > > > > >=20
> > > > > > > > > > It also accepts a few string arguments and converts
> > > > > > > > > > them to integers.
> > > > > > > > > >=20
> > > > > > > > > > Perhaps the same name should be used, and the
> > > > > > > > > > semantics made exactly
> > > > > > > > > > identical, and then it could be documented as
> > > > > > > > > > present for either
> > > > > > > > > > cppc_cpufreq OR intel_pstate?
> > > > > > > > > >=20
> > > > > > > > > > I think would be more elegant if userspace tooling
> > > > > > > > > > could Just Work with
> > > > > > > > > > either driver.
> > > > > > > > > >=20
> > > > > > > > > > One might object that the frequency selection
> > > > > > > > > > behavior that results from
> > > > > > > > > > any particular value of the register itself might
> > > > > > > > > > be different, but they
> > > > > > > > > > are *already* different between Intel's P and E-
> > > > > > > > > > cores in the same CPU
> > > > > > > > > > package. (Ugh.)
> > > > > > > > > Yes, I should use the same name. Thanks.
> > > > > > > > >=20
> > > > > > > > > As for accepting string arguments and converting them
> > > > > > > > > to integers, I don't
> > > > > > > > > think it is necessary. It'll be a litte confused if
> > > > > > > > > someone writes a raw
> > > > > > > > > value and reads a string I think. I prefer to let
> > > > > > > > > users freely set this
> > > > > > > > > value.
> > > > > > > > >=20
> > > > > > > > > In addition, there are many differences between the
> > > > > > > > > implementations of
> > > > > > > > > energy_performance_preference in intel_pstate and
> > > > > > > > > cppc_cpufreq (and
> > > > > > > > > amd-pstate...). It is really difficult to explain all
> > > > > > > > > this differences in
> > > > > > > > > this document. So I'll leave it to be documented as
> > > > > > > > > present for
> > > > > > > > > cppc_cpufreq only.
> > > > > > > > At least the interface to userspace I think we should
> > > > > > > > do the best we can to be the same between all the
> > > > > > > > drivers if possible.
> > > > > > > >=20
> > > > > > > > For example; I've got a patch that I may bring up in a
> > > > > > > > future kernel cycle that adds raw integer writes to
> > > > > > > > amd-pstates energy_performance_profile to behave the
> > > > > > > > same way intel-pstate does.
> > > > > > > I agree that it's better to keep this interface
> > > > > > > consistent across different
> > > > > > > drivers. But in my opinion, the implementation of
> > > > > > > intel_pstate
> > > > > > > energy_performance_preference is not really nice. Someone
> > > > > > > may write a raw
> > > > > > > value but read a string, or read strings for some values
> > > > > > > and read raw
> > > > > > > values for some other values. It is inconsistent. It may
> > > > > > > be better to use
> > > > > > > some other implementation, such as seperating the
> > > > > > > operations of r/w strings
> > > > > > > and raw values into two files.
> > > > > > I agree it would be better to be sure of the type to expect
> > > > > > when reading the
> > > > > > energy_performance_preference file. The epp values in the
> > > > > > range 0-255 with 0
> > > > > > being the performance value for all interfaces.
> > > > > >=20
> > > > > > In the current epp strings, it seems there is a big gap
> > > > > > between the PERFORMANCE
> > > > > > and the BALANCE_PERFORMANCE strings. Maybe it would be good
> > > > > > to complete it:
> > > > > > EPP_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00
> > > > > > EPP_BALANCE_PERFORMANCE=C2=A0=C2=A0=C2=A0 0x40=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 // state value changed
> > > > > > EPP_BALANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // new state
> > > > > > EPP_BALANCE_POWERSAVE=C2=A0=C2=A0=C2=A0 0xC0
> > > > > > EPP_POWERSAVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xFF
> > > > > >=20
> > > > > > NIT: The mapping seems to be slightly different for
> > > > > > intel_pstate and amd-pstate
> > > > > > currently:
> > > > > > drivers/cpufreq/amd-pstate.c
> > > > > > #define AMD_CPPC_EPP_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x00
> > > > > > #define AMD_CPPC_EPP_BALANCE_PERFORMANCE=C2=A0=C2=A0=C2=A0 0x80
> > > > > > #define AMD_CPPC_EPP_BALANCE_POWERSAVE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0xBF
> > > > > > #define AMD_CPPC_EPP_POWERSAVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xFF
> > > > > >=20
> > > > > > arch/x86/include/asm/msr-index.h
> > > > > > #define HWP_EPP_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x00
> > > > > > #define HWP_EPP_BALANCE_PERFORMANCE=C2=A0=C2=A0=C2=A0 0x80
> > > > > > #define HWP_EPP_BALANCE_POWERSAVE=C2=A0=C2=A0=C2=A0 0xC0=C2=A0=
=C2=A0 <------
> > > > > > Different from AMD_CPPC_EPP_BALANCE_POWERSAVE
> > > > > > #define HWP_EPP_POWERSAVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0xFF
> > > > > >=20
> > > > > > > I think it's better to consult Rafael and Viresh about
> > > > > > > how this should
> > > > > > > evolve.
> > > > > > Yes indeed
> > > > > Maybe it's best to discuss what the goal of raw EPP number
> > > > > writes is to decide what to do with it.
> > > > >=20
> > > > > IE in intel-pstate is it for userspace to be able to actually
> > > > > utilize something besides the strings all the time?=C2=A0 Or is i=
t
> > > > > just for debugging to find better values for strings in the
> > > > > future?
> > > > >=20
> > > > > If the former maybe we're better off splitting to
> > > > > 'energy_performance_preference' and
> > > > > 'energy_performance_preference_int'.
> > > > >=20
> > > > > If the latter maybe we're better off putting the integer
> > > > > writes and reads into debugfs instead and making
> > > > > 'energy_performance_preference' return -EINVAL while a non-
> > > > > predefined value is in use.
> > >=20
> > > In Intel case EPP values can be different based on processor. In
> > > some case they they end up sharing the same CPU model. So strings
> > > are not suitable for all cases. Also there is different
> > > preference of EPP between Chrome systems and non chrome distro.
> > > For example Chrome has some resource manager which can change and
> > > same on Intel distros with LPMD.
> > >=20
> >=20
> > Thanks for confirming it is intentional and changing it would break
> > existing userspace.
> >=20
> > And FWIW even in Windows there are more than 4 situational values
> > used like we have in Linux today.
> >=20
> > As the status quo is there I personally feel that we should do the
> > exact same for other implementation of
> > energy_performance_preference.
>=20
> I still don't think this implementation is nice, for the following
> reasons:
>=20
> 1. Users may write raw value but read string. It's odd.
>=20
> 2. Sometimes a raw value is read and sometimes a character string is
> read.
> The userspace tool needs to adapt this.
>=20
> 3. Reading and writing EPP strings is not really general in driver.
> It is
> more reasonable to use the userspace tool to implement it.
>=20
> In order not to break existing userspace, I'll rename the file to
> 'energy_performance_preference_int' or
> 'energy_performance_preference_val'
> in cppc_cpufreq and only support reading and writing raw value. As
> for
> accepting string arguments, it's not necessary for cppc_cpufreq for
> now.
> It's easy to add this feature but hard to remove, so I'll leave it to
> the
> future if it is really needed.
>=20
> As for amd-pstate and intel_pstate, you can decide how
> energy_performance_preference should evolve. But I strongly recommend
> splitting it.

No. User space can deal with this already. Atleast this has one
interface. If you split you need to keep them consistent. You can write
a raw value  to new attribute and then can read a string from the other
attribute, which means different.

This is not the only place where strings and raw values can be written
in sysfs. Also true for energy_perf_bias.


Thanks,
Srinivas



>=20
> Regards,
>=20
> Lifeng
>=20
> >=20
> > >=20
> > > Thanks,
> > >=20
> > > Srinivas
> > >=20
> > >=20
> > > > I think it's the former.
> > > >=20
> > > > I added the author of the patch that allows raw energy
> > > > performance
> > > > preference value in intel_pstate to ask about what the goal is
> > > > and if this
> > > > would be ok to do the modification mentioned above.
> > > >=20
> > > > To see the patch from
> > > > https://lore.kernel.org/=C2=A0all/20200626183401.1495090-3-srinivas=
.pandruvada@linux.intel.c
> > > > om/
> > > >=20
> > > > Anyway, the purpose of this patch is to allow users write and
> > > > read raw EPP
> > > > number. So maybe I can just rename the file to
> > > > 'energy_performance_preference_int'?
> > > >=20
> >=20
>=20


