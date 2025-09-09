Return-Path: <linux-acpi+bounces-16548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E99B503B5
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDFF1C67917
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0D3629B3;
	Tue,  9 Sep 2025 16:57:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA4334717;
	Tue,  9 Sep 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437076; cv=none; b=KJti0Ud/SaBpbJOUhXu2GHz4m22tNAEeJZFcv2ao8i7svjLpiCRcAoBY9V03hqIfSWw0582quVTOIpOZO8IEKTC90TQGEbFKsT6SIW0E+i0xFN4QmzYLM3dhEcq3ql6160PsRl7owwkopfqTCe2OL7oSdHE1MgxxjPZp2CiYKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437076; c=relaxed/simple;
	bh=XtpKUL7dVJ7Md2unjp6HHAK1hOa95mxETgDpcYTK2l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqo6RCKf+WJCXCYN49Ajy9ynUTpCwMbaaDV26ryJ/M7b4ClMD4PnjvZSBZs739dV7KKYsyqums68i4SRgo7mK43RQNrvRZ05eYaHgjZUDsyYN+06xFV3HCNHxHszBfWGvnROvLBs1YiAqGy+hidDzTelAHO6P6bDO4yO+9DMgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E1C2008;
	Tue,  9 Sep 2025 09:57:45 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2EC3F694;
	Tue,  9 Sep 2025 09:57:47 -0700 (PDT)
Message-ID: <3a3520f7-654b-420f-a8e8-ca57f92e21fe@arm.com>
Date: Tue, 9 Sep 2025 17:57:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] arm_mpam: Reset MSC controls from cpu hp callbacks
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-20-james.morse@arm.com>
 <1c20a5b2-2afe-4084-9494-a994e1a275b7@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <1c20a5b2-2afe-4084-9494-a994e1a275b7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 27/08/2025 17:19, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> When a CPU comes online, it may bring a newly accessible MSC with
>> it. Only the default partid has its value reset by hardware, and
>> even then the MSC might not have been reset since its config was
>> previously dirtyied. e.g. Kexec.
>>
>> Any in-use partid must have its configuration restored, or reset.
>> In-use partids may be held in caches and evicted later.
>>
>> MSC are also reset when CPUs are taken offline to cover cases where
>> firmware doesn't reset the MSC over reboot using UEFI, or kexec
>> where there is no firmware involvement.
>>
>> If the configuration for a RIS has not been touched since it was
>> brought online, it does not need resetting again.
>>
>> To reset, write the maximum values for all discovered controls.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index bb62de6d3847..c1f01dd748ad 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> @@ -849,8 +850,115 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)

>> +static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>> +{
>> +	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
>> +	struct mpam_msc *msc = ris->vmsc->msc;
>> +	struct mpam_props *rprops = &ris->props;
>> +
>> +	mpam_assert_srcu_read_lock_held();
>> +
>> +	mutex_lock(&msc->part_sel_lock);
>> +	__mpam_part_sel(ris->ris_idx, partid, msc);
>> +
>> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
>> +		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
>> +
>> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
>> +		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
>> +
>> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
>> +		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>> +
>> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
>> +		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);

> MPAMCFG_MBW_MAX_MAX can be used directly instead of bwa_fract.

Without the second user, yes.


>> +
>> +	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
>> +		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);

> Shouldn't this reset to 0? STRIDEM1 is a cost.

Heh, this is just a copy and paste of the last value, because it clears the 'enable' bit,
and the spec says "there is no setting of the STRIDEM1 control field that disables the
effects of proportional-stride".

Yes - zero would be better.


Thanks,

James

