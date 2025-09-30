Return-Path: <linux-acpi+bounces-17458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E4BAE21B
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 19:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671A932276D
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901B30AD1F;
	Tue, 30 Sep 2025 17:06:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE4630AD05;
	Tue, 30 Sep 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251999; cv=none; b=G7ztwNsmN+bIrDSF/yHJ1AF/0LcYpU/45JAGqMwDc6dhFarKVIHX3S4Y3a6siPn7zv1lvSmkTmiLGLrrAgDU0rCYdbDeUeL8sdP7BTe1mnNGZ52Ygnl25LhcM+17oAKfV+C8+mUGDcw1BvybMzKOG5PKGFf4iIz6JU8GSKRnJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251999; c=relaxed/simple;
	bh=rsdmX6SyFZkENXtJNI7zZ5FCm7c9XX7EaXpvg0nvR0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLgxlj8aI1OkQU9O0wVh9xdomAdm9DkorH5P44MhK5V/a/oF/RjGCQm1AsUbXEJKnFor0hwL+FnejfjsAco7rq71Hb4AiRf5QcT2xzAvn2e9v+eFPpBfSuRqSSwV+wA6bJUFZ5DtlwOPhDgRE3qpa4mV7knd4oUK350pgMGe2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FADD2008;
	Tue, 30 Sep 2025 10:06:29 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24FC73F59E;
	Tue, 30 Sep 2025 10:06:27 -0700 (PDT)
Message-ID: <fc3807ea-25ba-4581-8b63-843bc3f015a4@arm.com>
Date: Tue, 30 Sep 2025 18:06:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/29] arm_mpam: Reset MSC controls from cpu hp
 callbacks
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-16-james.morse@arm.com>
 <abb9b4bb-18d8-4de7-a216-3c18769f61cb@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <abb9b4bb-18d8-4de7-a216-3c18769f61cb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 12/09/2025 12:25, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
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
>> index cd8e95fa5fd6..0353313cf284 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -777,8 +778,110 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)

>> +static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>> +{
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
>> +		mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
>> +
>> +	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
>> +		mpam_write_partsel_reg(msc, MBW_PROP, 0);


> If mpam_feat_ccap_part is already in enum mpam_device_features then the
> reset would belong here but I expect it is better just to introduce
> mpam_feat_ccap_part later (patch 21). I also commented on this feature
> introduction split on patch 13.

Yup, this is some knock on cleanup from that change.
(I didn't understand what you meant the first time round!)


>> +	mutex_unlock(&msc->part_sel_lock);
>> +}

>> +static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>> +{
>> +	struct mpam_msc_ris *ris;
>> +
>> +	mpam_assert_srcu_read_lock_held();

> Unneeded? Checked in list_for_each_entry_srcu().> +

So it is! I'll rip those out. They were mostly for documentation anyway.
There will likely be a few others of these in the series...


>> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
>> +		mpam_reset_ris(ris);
>> +
>> +		/*
>> +		 * Set in_reset_state when coming online. The reset state
>> +		 * for non-zero partid may be lost while the CPUs are offline.
>> +		 */
>> +		ris->in_reset_state = online;
>> +	}
>> +}
>> +


Thanks,

James

