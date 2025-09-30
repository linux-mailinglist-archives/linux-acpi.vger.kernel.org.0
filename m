Return-Path: <linux-acpi+bounces-17443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0EBAD115
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063B33A7689
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E462302755;
	Tue, 30 Sep 2025 13:32:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4072FA0C7;
	Tue, 30 Sep 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239145; cv=none; b=n7Fn9uotqm9fvowK6pP4lfSNnt5v8hYqafRN/saie9azrAOqh4nZ6mTNDMLMsJZgabvj5pPVTKki/F0kTJX6qEuHy7hAlgJzKt3HxdrnkZL03F0ttyE2xElU9svwufH8OAuiK8H4kLUjpo3vB44M5AdLlgWzM0YcQLdT54fclG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239145; c=relaxed/simple;
	bh=Xk6RZuGztEL9unK1SjNmM+dQ7i44rNs7t52p338eIAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhCs13V1Qog9FuR+HquqsnLISvWHaspwxEIFxGmdkEm7w+tzgSg8aUkT6cyQmZY9hmWNgyHNn9ASdePwNEf+ZKWQtd1gm8MYsvOThpAnJBEVvrqQnw1yQpLW3MbWylPyn50NN3vUoMnIh/RufURtOpHrVmlteiqwQcOKJy1jWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D4B4113E;
	Tue, 30 Sep 2025 06:32:09 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9973F59E;
	Tue, 30 Sep 2025 06:32:12 -0700 (PDT)
Message-ID: <7b13b1b5-295e-499b-9f8f-da168099377d@arm.com>
Date: Tue, 30 Sep 2025 14:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/29] arm_mpam: Probe the hardware features resctrl
 supports
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
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
 <20250910204309.20751-14-james.morse@arm.com>
 <8ed9fbe9-1075-4abb-91d0-20203906a4dc@arm.com>
 <32bc0e4a-d0bb-4aaa-8706-95a6edd470a9@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <32bc0e4a-d0bb-4aaa-8706-95a6edd470a9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/29/25 18:45, James Morse wrote:
> Hi Ben,
> 
> On 11/09/2025 16:37, Ben Horgan wrote:
>> On 9/10/25 21:42, James Morse wrote:
>>> Expand the probing support with the control and monitor types
>>> we can use with resctrl.
> 
>>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>>> index 4cc44d4e21c4..5ae5d4eee8ec 100644
>>> --- a/drivers/resctrl/mpam_internal.h
>>> +++ b/drivers/resctrl/mpam_internal.h
>>> @@ -112,6 +112,55 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>>>  	raw_spin_lock_init(&msc->_mon_sel_lock);
>>>  }
>>>  
>>> +/*
>>> + * When we compact the supported features, we don't care what they are.
>>> + * Storing them as a bitmap makes life easy.
>>> + */
>>> +typedef u16 mpam_features_t;
>>> +
>>> +/* Bits for mpam_features_t */
>>> +enum mpam_device_features {
>>> +	mpam_feat_ccap_part = 0,
>>> +	mpam_feat_cpor_part,
>>> +	mpam_feat_mbw_part,
>>> +	mpam_feat_mbw_min,
>>> +	mpam_feat_mbw_max,
>>> +	mpam_feat_mbw_prop,
>>> +	mpam_feat_msmon,
>>> +	mpam_feat_msmon_csu,
>>> +	mpam_feat_msmon_csu_capture,
>>> +	mpam_feat_msmon_csu_hw_nrdy,
>>> +	mpam_feat_msmon_mbwu,
>>> +	mpam_feat_msmon_mbwu_capture,
>>> +	mpam_feat_msmon_mbwu_rwbw,
>>> +	mpam_feat_msmon_mbwu_hw_nrdy,
>>> +	mpam_feat_msmon_capt,
>>> +	MPAM_FEATURE_LAST,
>>> +};
> 
>> I added a garbled comment about this for v1. What I was trying to say is
>> that I don't think this quite matches what resctrl supports. For
>> instance, I don't think mpam_feat_ccap_part matches a resctrl feature.
> 
> Ah - right. I thought you meant something was removed later.
> Looks like I thought something could be emulated with CCAP, but that turns out not to be
> true because it doesn't have an implicit isolation property, which the
> resctrl:bitmap-from-userspace requires.
> (I think rwbw was a later addition to the architecture and I added it to the wrong patch).
> 
> I'll move that, _prop and _rwbw to the later patch. The split is fairly arbitrary - it was

I think ccap gets split into finer grained features later on which seems
fine.

> just somewhere to split an otherwise large patch, and does help determine if a bug is
> going to be visible to user-space or not.

Ok, sensible, I hadn't appreciated the user-space visibility aspect.

> 
> _capt can go completely. Last I heard no-one was interested in firmware descriptions of
> how the capture hardware can be triggered. I suspect no-one has done anything with it.

So, if I've understood correctly this leaves you with the following in
this patch.

mpam_feat_cpor_part,
mpam_feat_mbw_part,
mpam_feat_mbw_min,
mpam_feat_mbw_max,
mpam_feat_mbw_prop,
mpam_feat_msmon,
mpam_feat_msmon_csu,
mpam_feat_msmon_csu_hw_nrdy,
mpam_feat_msmon_mbwu,
mpam_feat_msmon_mbwu_hw_nrdy,

Looks like the correct, resctrl based, split.

> 
> 
> Thanks,
> 
> James

Thanks,

Ben


