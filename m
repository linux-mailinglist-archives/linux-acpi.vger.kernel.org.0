Return-Path: <linux-acpi+bounces-16426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF07B462ED
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ED2BA13B0
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C7279912;
	Fri,  5 Sep 2025 18:49:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041CC25A343;
	Fri,  5 Sep 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098159; cv=none; b=ej6zG9sSP8Q0ILE8bXVMIwzl/DYDcjX2fvmp9xo+mg2HCxY4NLYPUeciMG7rHmtjxQqKWF26aIbKfYpIi0QE/i6q3I/ogPbtSxBSPCUi+BQw3IDI17Q06e+P1PILgBsqgNd+oc0tnrON9ToTbkltKPMammdtEr3K6J1+MHXbIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098159; c=relaxed/simple;
	bh=uVVjYy4LXPDttbkCjYxdRX08KrZ8tDWcmNAWFIUOCSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3nCPGPcYr3CcYkuteOB+0Zzpdq/X1VVwjreby3qgTGOzGyWEx0tFpNAgfMLLotNw7mN0iZIEvmBN6Q1ZtRASisulArrtASGo38qAQJuZCbOfdP81D83aSqfPvj2ZEiKUBWvxMDAY833KJed/kt/X/m8dHcP5fVGeO46f4IoTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94FF152B;
	Fri,  5 Sep 2025 11:49:08 -0700 (PDT)
Received: from [10.1.197.69] (unknown [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9A23F63F;
	Fri,  5 Sep 2025 11:49:10 -0700 (PDT)
Message-ID: <6a050b35-1b4d-4ea1-aa40-974aafa89b52@arm.com>
Date: Fri, 5 Sep 2025 19:49:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
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
 <20250822153048.2287-11-james.morse@arm.com>
 <e5b2fa8d-c77e-49ac-a328-1363e472cc42@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <e5b2fa8d-c77e-49ac-a328-1363e472cc42@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 01/09/2025 10:11, Ben Horgan wrote:
> On 8/22/25 16:29, James Morse wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> new file mode 100644
>> index 000000000000..07e0f240eaca
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -0,0 +1,62 @@

>> +struct mpam_msc {
>> +	/* member of mpam_all_msc */
>> +	struct list_head        glbl_list;
>> +
>> +	int			id;
>> +	struct platform_device *pdev;
>> +
>> +	/* Not modified after mpam_is_enabled() becomes true */
>> +	enum mpam_msc_iface	iface;
>> +	u32			pcc_subspace_id;
>> +	struct mbox_client	pcc_cl;
>> +	struct pcc_mbox_chan	*pcc_chan;
>> +	u32			nrdy_usec;
>> +	cpumask_t		accessibility;
>> +
>> +	/*
>> +	 * probe_lock is only take during discovery. After discovery these
>> +	 * properties become read-only and the lists are protected by SRCU.
>> +	 */
>> +	struct mutex		probe_lock;
>> +	unsigned long		ris_idxs[128 / BITS_PER_LONG];

> Why is this sized this way? RIS_MAX is 4 bits and so there are at most
> 16 RIS per msc.

Hmmm, lost in time - I agree with the 16 reasoning. Fixed.
(It's likely due to RES0 space above the field - but that has been filled in with other
 stuff since then. RIS was added as a 'backward compatible feature' - I was wary of them
 extending it)


>> +	u32			ris_max;
>> +
>> +	/* mpam_msc_ris of this component */
>> +	struct list_head	ris;
>> +
>> +	/*
>> +	 * part_sel_lock protects access to the MSC hardware registers that are
>> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
>> +	 * by RIS).
>> +	 * If needed, take msc->lock first.
>> +	 */
>> +	struct mutex		part_sel_lock;
>> +
>> +	/*
>> +	 * mon_sel_lock protects access to the MSC hardware registers that are
>> +	 * affeted by MPAMCFG_MON_SEL.
>> +	 * If needed, take msc->lock first.
>> +	 */
>> +	struct mutex		outer_mon_sel_lock;
>> +	raw_spinlock_t		inner_mon_sel_lock;
>> +	unsigned long		inner_mon_sel_flags;
>> +
>> +	void __iomem		*mapped_hwpage;
>> +	size_t			mapped_hwpage_sz;
>> +};
>> +
>> +#endif /* MPAM_INTERNAL_H */

Thanks,

James

