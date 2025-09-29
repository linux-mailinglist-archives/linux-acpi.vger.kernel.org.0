Return-Path: <linux-acpi+bounces-17428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC313BAA371
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75ED175556
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9011E5711;
	Mon, 29 Sep 2025 17:45:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53E19E967;
	Mon, 29 Sep 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167909; cv=none; b=LZrigVPHvwHRaOvnY2iv/66S8ajyt+aVGdKFk2CtinRS9V9R7DK4Z0ICrK3/WlwOg6xm8NfcVCGK0+XB7xoGqDiQTg2WoTIEUoFZKtnDF0wM+GWZVRlrjMKMy/cgikxrgU4JzF97gmaPYu8lkWxLX63vF/6JdvrTKLjRxhHk08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167909; c=relaxed/simple;
	bh=VtJWkIQ/TMxmpuoyiei7EmbhBkmVMAwYhhlpRuRsoUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUNEgt3Jtpi/9BGkfTh6yKiQf1MhgkFFI38xsyzltP7G/QeFXMiCCr+AuG6uyFlcqNwUWBJp9qQYTpT7dCcuXFmz5RDd2MYIbolXFlV6/d2Z2ctAHknI4HFceuGeQertBM4Ex4Nc1P1dsPpurPcPz0lNoL8av8Zh4A07k1OaGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBC91BCB;
	Mon, 29 Sep 2025 10:44:59 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27D33F59E;
	Mon, 29 Sep 2025 10:45:02 -0700 (PDT)
Message-ID: <fea6066e-b94d-4ac1-9a33-3e42a8923de6@arm.com>
Date: Mon, 29 Sep 2025 18:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/29] arm_mpam: Probe the hardware features resctrl
 supports
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-14-james.morse@arm.com>
 <20250911162956.00005157@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911162956.00005157@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 16:29, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:53 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Expand the probing support with the control and monitor types
>> we can use with resctrl.
>>
>> CC: Dave Martin <Dave.Martin@arm.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> A few trivial things inline.
> LGTM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>> @@ -592,6 +736,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>  	mutex_lock(&msc->part_sel_lock);
>>  	idr = mpam_msc_read_idr(msc);
>>  	mutex_unlock(&msc->part_sel_lock);
>> +
> Stray change  - push it to earlier patch.

Fixed,


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 4cc44d4e21c4..5ae5d4eee8ec 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -112,6 +112,55 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>>  	raw_spin_lock_init(&msc->_mon_sel_lock);
>>  }
>>  
>> +/*
>> + * When we compact the supported features, we don't care what they are.
>> + * Storing them as a bitmap makes life easy.
>> + */
>> +typedef u16 mpam_features_t;
> 
> Maybe use a bitmap type and avoid the need to be careful on sizing etc?

That would be unsigned long at a minimum, which is four times larger than needed.
As there is a build-time check, I'm not worried about this ever being wrong...


>> +
>> +/* Bits for mpam_features_t */
>> +enum mpam_device_features {
>> +	mpam_feat_ccap_part = 0,
>> +	mpam_feat_cpor_part,
>> +	mpam_feat_mbw_part,
>> +	mpam_feat_mbw_min,
>> +	mpam_feat_mbw_max,
>> +	mpam_feat_mbw_prop,
>> +	mpam_feat_msmon,
>> +	mpam_feat_msmon_csu,
>> +	mpam_feat_msmon_csu_capture,
>> +	mpam_feat_msmon_csu_hw_nrdy,
>> +	mpam_feat_msmon_mbwu,
>> +	mpam_feat_msmon_mbwu_capture,
>> +	mpam_feat_msmon_mbwu_rwbw,
>> +	mpam_feat_msmon_mbwu_hw_nrdy,
>> +	mpam_feat_msmon_capt,
>> +	MPAM_FEATURE_LAST,
> 
> If it's always meant to be LAST, I'd drop the trailing comma.

Sure. Full-stops for enums!


Thanks,

James

