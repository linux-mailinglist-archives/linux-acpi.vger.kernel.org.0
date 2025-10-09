Return-Path: <linux-acpi+bounces-17691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B780BCA6B4
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 19:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4F4434FEF9
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5E23C4FF;
	Thu,  9 Oct 2025 17:48:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3591F7580;
	Thu,  9 Oct 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032131; cv=none; b=pYBWwjLzL2rL4V/tA7wFry7tfqLp7nkn+h20lijqXcVD7ccBQ1MNgScqCZaz07K3T3R+n/RDQ8dZmpsBPE0vL3tUVWcgOvgKaPiDcU80AyC2rLL69/0OfoHtXQuUs/Yv5N4cPiv4/oUaW3DiQXdjRBf/LKcFp9pT3Ju7Uc2oEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032131; c=relaxed/simple;
	bh=zAQfZNYWFVffiElsOpE8p/vY2sMzBDmMGILBqdJorTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhtCfR3Mv0Wgze+K4DfoW/Puen72vNb9gFGooAyg0ps3eO7bl/9gIIvy7Enbv2Xg7NGk971g5OUMfwaTubELF7xGrd/vQPthOg7rzj07nIHY+jROlCZ1h1hzROnaO+wwEIujrsbvqie9pli3YRbubmNeYGTGqAEasssoY+1ilo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B21C91762;
	Thu,  9 Oct 2025 10:48:40 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256843F66E;
	Thu,  9 Oct 2025 10:48:43 -0700 (PDT)
Message-ID: <a3462502-5732-4eae-b0b3-04fc7f040372@arm.com>
Date: Thu, 9 Oct 2025 18:48:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/29] arm_mpam: Probe for long/lwd mbwu counters
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
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-26-james.morse@arm.com>
 <20250912142724.000026a7@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912142724.000026a7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:27, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:05 +0000
> James Morse <james.morse@arm.com> wrote:
>> From: Rohit Mathew <rohit.mathew@arm.com>
>>
>> mpam v0.1 and versions above v1.0 support optional long counter for
>> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register have fields
>> indicating support for long counters. As of now, a 44 bit counter
>> represented by HAS_LONG field (bit 30) and a 63 bit counter represented
>> by LWD (bit 29) can be optionally integrated. Probe for these counters
>> and set corresponding feature bits if any of these counters are present.

> I'd like a little more justification of the 'front facing' use for the first
> feature bit.  To me that seems confusing but I may well be missing why
> we can't have 3 exclusive features.
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index eeb62ed94520..bae9fa9441dc 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -795,7 +795,7 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>  				dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
>>  		}
>>  		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
>> -			bool hw_managed;
>> +			bool has_long, hw_managed;
>>  			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
>>  
>>  			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
>> @@ -805,6 +805,27 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>  			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
>>  				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
>>  
>> +			/*
>> +			 * Treat long counter and its extension, lwd as mutually
>> +			 * exclusive feature bits. Though these are dependent
>> +			 * fields at the implementation level, there would never
>> +			 * be a need for mpam_feat_msmon_mbwu_44counter (long
>> +			 * counter) and mpam_feat_msmon_mbwu_63counter (lwd)
>> +			 * bits to be set together.
>> +			 *
>> +			 * mpam_feat_msmon_mbwu isn't treated as an exclusive
>> +			 * bit as this feature bit would be used as the "front
>> +			 * facing feature bit" for any checks related to mbwu
>> +			 * monitors.

> Why do we need such a 'front facing' bit?  Why isn't it sufficient just to
> add a little helper or macro to find out if mbwu is turned on?

(I read Rohit's front-facing as top-level).

I think Rohit thought it would be simpler - there is one feature enum that gets passed in
from the resctrl glue code saying "I want to read a bandwidth counter", because there
is only one, and it doesn't care what size. I think Rohit didn't want to touch that code!

As that is really a separate concept, I think its worth handling explicitly:
mpam_feat_msmon_mbwu means there are counters, and mpam_feat_msmon_mbwu_{31,44,63}counter
say which ones are supported.

The helper you suggest an then pick which one is best.


Thanks,

James

