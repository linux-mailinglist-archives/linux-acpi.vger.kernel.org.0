Return-Path: <linux-acpi+bounces-8859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596EA9A45EF
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2024 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F88B22C27
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3F184520;
	Fri, 18 Oct 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmwEEsey"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754F168488
	for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276313; cv=none; b=HwhUsfN6CIgWvaOWDpLEjxkcAa7ayFfGb5ffu1INGfdORf2+XGDw3lMK0VUbKVj/zHt1kNClbeLpDtT6OQRRpdgqFwHY5LvhL0E6mXM+2xwrJFVbjhCv9WVH5q2G7abKTztsGWhs1eKwHxiiWwrhry8fjRENSd1BE+XgEEfvnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276313; c=relaxed/simple;
	bh=D2QGmg1SKKisL6UBaKfdsQXPXPpp+HQxVTi0UVzmkbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/wURDPcxUXAXNPKz0PVbcl2pJkynd7a1sP8ec53YlxhgmGurZzJlIMQwrCTC0mb2BGYdv8FGVbMXOvPICVxvHtkddrGQd5T1Cx2qjTSWGksDKCraz/TCJ+qr1ofK2l9QCv9jHsWADehHByf8Y8kVZp9QRLW0u4mZS+3kwUkRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmwEEsey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A872C4CED0;
	Fri, 18 Oct 2024 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729276312;
	bh=D2QGmg1SKKisL6UBaKfdsQXPXPpp+HQxVTi0UVzmkbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bmwEEseydj4QkV3IhunON/aqDS8RA7ZxMud2556g0LGuc3NCfu9V3tmPblWJ1MXaq
	 j1ebiASoXU/6AMoi331Bje4PGkwI2ofoRSrN82fQhJrxvoq+bj5u2QRsewme5qDzeR
	 RQOaQLBf1R985RDc6Hg7yqQnjFt/ZIJIC0KIq8GxsE/LEUqFE+0ElAr51pPhZuWNwQ
	 o403SmaMbbhsKXeMmh6VOlm7CdpQfLgpDHm1IPI2fVt2JiVBx9OLgMoNyGTwP7gAy6
	 AGbGuRb9E7tf1A7BIl+Vla+OKwoX1YAxtOIWoCJF7ksBB9oPBtivaCeXubNZRMjJel
	 wQ4ydobhoRG2g==
Message-ID: <6271aaed-fb4c-4101-82a2-e18aba05b4d4@kernel.org>
Date: Fri, 18 Oct 2024 13:31:51 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-2-superm1@kernel.org>
 <20241018182440.GDZxKn6FkYji_9Xhau@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20241018182440.GDZxKn6FkYji_9Xhau@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/2024 13:24, Borislav Petkov wrote:
> On Thu, Oct 03, 2024 at 04:37:58PM -0500, Mario Limonciello wrote:
>> From: Perry Yuan <perry.yuan@amd.com>
>>
>> CPUID leaf 0x80000026 advertises core types with different efficiency
>> rankings.
>>
>> Bit 30 indicates the heterogeneous core topology feature, if the bit
>> set, it means not all instances at the current hierarchical level have
>> the same core topology.
>>
>> This is described in the AMD64 Architecture Programmers Manual Volume
>> 2 and 3, doc ID #25493 and #25494.
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/include/asm/cpufeatures.h | 1 +
>>   arch/x86/kernel/cpu/scattered.c    | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index dd4682857c12..cea1ed82aeb4 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -473,6 +473,7 @@
>>   #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>>   #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
>> +#define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
> 
> So this is an AMD-specific feature bit and so it should have "AMD" in the
> name:
> 
> #define X86_FEATURE_AMD_HETERO_CORE_TOPOLOGY (21*32 + 6) /* Heterogeneous Core Topology */
> 
> Also, as clarified offlist, please do not take x86 patches without an Ack at
> least through some other tree.

Yes; sorry about this, the R-b was not sufficient and should have 
explicitly pinged for an A-b.

> 
>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>> index c84c30188fdf..3bba55323163 100644
>> --- a/arch/x86/kernel/cpu/scattered.c
>> +++ b/arch/x86/kernel/cpu/scattered.c
>> @@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>   	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>>   	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>>   	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
>> +	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
> 
> So my APM calls this bit: "HeterogeneousCores".
> 
> Why aren't you calling it this?
> 
> IOW: X86_FEATURE_AMD_HETEROGENEOUS_CORES
> 
> Thx.
> 

OK - I'll adjust accordingly.

There is other content in linux-pm/linux-next that uses this.

As this patch is already in linux-pm/linux-next, I see 3 options:

1) I can bring a revert through superm1/linux.git to PR to 
linux-pm/linux-next and resubmit with fixes for you to take through tip.

2) Rafael can drop this and the follow on and I'll resubmit with your 
feedback and we can bring through tip

3) I can amend with the fixes we take through linux-pm/linux-next to 
avoid the acrobatics of 1 or 2.

Please let me know your preference.

