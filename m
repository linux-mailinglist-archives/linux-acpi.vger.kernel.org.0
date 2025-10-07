Return-Path: <linux-acpi+bounces-17643-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DADBC1195
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3F53B6A2A
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125D2417D9;
	Tue,  7 Oct 2025 11:11:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35062E55A;
	Tue,  7 Oct 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835479; cv=none; b=ACPt2qX2ZPeHvlIQRhy9CrS69ezojezlMehg/yP3AIpd4KB03Kmac2iRiFqzTrZxq/KRJ0qBWc3BHela0+j//BvqGTdOdWWL27ItXnppt/DzlONtGkDfjOw4k94hFnNgNFZtWG4SosX3sU7IfUHRwF4YlrvdYzusJJ4T+ccxin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835479; c=relaxed/simple;
	bh=FyeLOczwa+ez0s04nxcBWL8/xQ4WoRYMAetA2d74RfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohh5uf8bcaG/ROWsP+Ae8BwOS+N5dZc6oKvBSNlO7Z37M8FNkiOyxMOX/5SSjRAPnBfF/BeD4VH/+NrLKPLG3I6GbAY04Ps0QPxbZ95WMudepxXKSxb2yYh3904ilZRQyvW+fMQLfRTuAW+IXtnPMQKH1pu/c3D9EEX/j+94wOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265031424;
	Tue,  7 Oct 2025 04:11:08 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BB73F66E;
	Tue,  7 Oct 2025 04:11:10 -0700 (PDT)
Message-ID: <4aec304d-4a89-4957-ac72-148db39f6117@arm.com>
Date: Tue, 7 Oct 2025 12:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
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
 <20250910204309.20751-21-james.morse@arm.com>
 <20250912132229.000044c7@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912132229.000044c7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 13:22, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:00 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> When CPUs come online the MSC's original configuration should be restored.
>>
>> Add struct mpam_config to hold the configuration. This has a bitmap of
>> features that were modified. Once the maximum partid is known, allocate
>> a configuration array for each component, and reprogram each RIS
>> configuration from this.

> Trivial comments
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
>> +{
>> +	memset(reset_cfg, 0, sizeof(*reset_cfg));
> 
> Might as well do the following and skip the memset.
> 
> 	*reset_cfg = (struct mpam_config) {
> 		.features = ~0,
> 		.cpbm = ~0,
> 		.mbw_pbm = ~0,
> 		.mbw_max = MPAM...
> 		.reset_cpbm = true,
> 		.reset_mbw_pbm = true,
> 	};

Sure,


>> +	reset_cfg->features = ~0;
>> +	reset_cfg->cpbm = ~0;
>> +	reset_cfg->mbw_pbm = ~0;
>> +	reset_cfg->mbw_max = MPAMCFG_MBW_MAX_MAX;
>> +
>> +	reset_cfg->reset_cpbm = true;
>> +	reset_cfg->reset_mbw_pbm = true;
>> +}
> 
>> +static int mpam_allocate_config(void)
>> +{
>> +	int err = 0;
> 
> Always set before use. Maybe push down so it is in tighter scope and
> can declare and initialize to final value in one line.

Sure,


>> +	struct mpam_class *class;
>> +	struct mpam_component *comp;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	list_for_each_entry(class, &mpam_classes, classes_list) {
>> +		list_for_each_entry(comp, &class->components, class_list) {
>> +			err = __allocate_component_cfg(comp);
>> +			if (err)
>> +				return err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> 
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index b69fa9199cb4..17570d9aae9b 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -169,11 +169,7 @@ struct mpam_props {
>>  	u16			num_mbwu_mon;
>>  };
>>  
>> -static inline bool mpam_has_feature(enum mpam_device_features feat,
>> -				    struct mpam_props *props)
>> -{
>> -	return (1 << feat) & props->features;
>> -}
>> +#define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)
> 
> If this is worth doing push it back to original introduction.
> I'm not sure it is necessary.

It's the change in this patch that makes it necessary, maybe_update_config() goes calling
mpam_has_feature() on a configuration instead of a class/msc/ris props structure. I could
have made that a separate helper to get the type right - but making it a macro was simpler.

I'll push it back earlier.


Thanks,

James

