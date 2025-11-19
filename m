Return-Path: <linux-acpi+bounces-19073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DEBC6DEA4
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 11:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52859353FD3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9ED3491F6;
	Wed, 19 Nov 2025 10:12:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E79348865;
	Wed, 19 Nov 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547155; cv=none; b=caL8T3pVrmzwBOZ1lc9IhEwgrwNsZB2LGhPrdRTJrzg+pUbMRb7ufj1lWi73/m4B9lsO/e63NWmxMxXwoJol6SBR32geCdqZY+q+VosL2P56IGuOi9tF+Ih5vyF+WnS1I3tBZH4y9C3XwRtdyUyIcl549S0RUemgasAczo16gHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547155; c=relaxed/simple;
	bh=5R4x4bB+FeNSynI9wYt88bpcE7w6VM13UPcU2yuLTUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlC+V0sRxtYcNfackm8UVZyReChLc0obbwtL5SI+7s6QbVPlnkl68dPOOtuuwxU8yL7EGqFIJr8ZWUnrwLTp0edfJcweTo9PSXxkDyp/9BM1VN5cNkw01kEoBRm4makyVuKtUaEv3U2/jMudB2N9pUQ8IVhCVAXBMDFsUuT5y4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F5EFEC;
	Wed, 19 Nov 2025 02:12:24 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AF733F740;
	Wed, 19 Nov 2025 02:12:27 -0800 (PST)
Message-ID: <d13bb673-a033-4020-a984-19b4ab560be9@arm.com>
Date: Wed, 19 Nov 2025 10:12:25 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/34] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
To: Fenghua Yu <fenghuay@nvidia.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-16-ben.horgan@arm.com>
 <bb238bdc-1870-4888-874e-b3fa466d264b@nvidia.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <bb238bdc-1870-4888-874e-b3fa466d264b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 11/19/25 04:13, Fenghua Yu wrote:
> Hi, Ben,
> 
> On 11/17/25 08:59, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> The MSC MON_SEL register needs to be accessed from hardirq for the
>> overflow
>> interrupt, and when taking an IPI to access these registers on platforms
>> where MSC are not accessible from every CPU. This makes an irqsave
>> spinlock the obvious lock to protect these registers. On systems with
>> SCMI
>> or PCC mailboxes it must be able to sleep, meaning a mutex must be used.
>> The SCMI or PCC platforms can't support an overflow interrupt, and
>> can't access the registers from hardirq context.
>>
>> Clearly these two can't exist for one MSC at the same time.
>>
>> Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and
>> only support 'real' MMIO platforms.
>>
>> In the future this lock will be split in two allowing SCMI/PCC platforms
>> to take a mutex. Because there are contexts where the SCMI/PCC platforms
>> can't make an access, mpam_mon_sel_lock() needs to be able to fail. Do
>> this now, so that all the error handling on these paths is present. This
>> allows the relevant paths to fail if they are needed on a platform where
>> this isn't possible, instead of having to make explicit checks of the
>> interface type.
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Tested-by: Carl Worth <carl@os.amperecomputing.com>
>> Tested-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Zeng Heng <zengheng4@huawei.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com
> 
> [SNIP]
> 
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/
>> mpam_internal.h
>> index 768a58a3ab27..b62ee55e1ed5 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
> 
> [SNIP]
> 
>> +/* Returning false here means accesses to mon_sel must fail and
>> report an error. */
>> +static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
>> +{
>> +    WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO);
>> +
>> +    raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
>> +    return true;
>> +}
> 
> This helper always returns true, never false. And this may cause issue
> later.
> 
> On the bottom line, this causes confusion in the comment and when later
> its return value is always checked by callers.
> 
> It's better to improve this helper?
> 
> Option 1: warn and return false when ris->iface is not MMIO. No changes
> in other patches which call the helper. Seems this is a better fix.

Ok. The return value checking is intentional so that the locking for the
firmware backed interface can be easily re-instated to the driver later.
I'll return false when ris->iface is not MMIO but we won't get there as
the probe will have already failed.

> Option 2: warn on non MMIO iface but no return value. Other patches need
> to be changed when calling the helper.
> 
> Thanks.
> 
> -Fenghua

-- 
Thanks,

Ben


