Return-Path: <linux-acpi+bounces-7235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5DA945D98
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE6E1C21C62
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA141DE867;
	Fri,  2 Aug 2024 12:01:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBFB14B09F;
	Fri,  2 Aug 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600112; cv=none; b=Ulfy8T39Yo1U/YsuAePLMO22IApuCCi1rE99WUrmE9/W7fYBLYYCz3mCIjKsDuvi5iso5ptPAJbd1NWZGvZZkWEsLPF+k9Gk4Mt5jA+bstrsNEXky3MI661wY7fITx+6/HIOkTR7eSqFOc8XKq5f1sp3mod4c1hZvSUbYpYMRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600112; c=relaxed/simple;
	bh=raWuv0skPOWoOjKvJaMx51HTs9/zlRz6O1m2f1EMPZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uou+6ZRIPJY+6lSGRQ4USmxUr4uAsfWjMuWoUh7Yt4PCSAG79fbRlc+1fuYeMP2MbAn9ZygJticbv+xDS7Lby2e5eAyJg3QN6Ivt45gbJYlN1JPsLZfwqj9Hjtu2EwaAskBDZWkQs2AH+Jdqrm90YTYZ9bB2psFdY/4QFk044fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50BC1007;
	Fri,  2 Aug 2024 05:02:15 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642163F64C;
	Fri,  2 Aug 2024 05:01:46 -0700 (PDT)
Message-ID: <f43e0424-c58a-4895-a2e7-2ec403ea3519@arm.com>
Date: Fri, 2 Aug 2024 13:01:44 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/10] iommu/arm-smmu-v3: Maintain a SID->device
 structure
To: niliqiang <ni_liqiang@126.com>, jean-philippe@linaro.org
Cc: Jonathan.Cameron@huawei.com, baolu.lu@linux.intel.com,
 devicetree@vger.kernel.org, eric.auger@redhat.com, guohanjun@huawei.com,
 iommu@lists.linux-foundation.org, jacob.jun.pan@linux.intel.com,
 joro@8bytes.org, kevin.tian@intel.com, lenb@kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, shameerali.kolothum.thodi@huawei.com,
 sudeep.holla@arm.com, vivek.gautam@arm.com, wangzhou1@hisilicon.com,
 will@kernel.org, zhangfei.gao@linaro.org, zhukeqian1@huawei.com,
 ni.liqiang@zte.com.cn, li.zhichao@zte.com.cn
References: <20210401154718.307519-8-jean-philippe@linaro.org>
 <20240801152922.5605-1-ni_liqiang@126.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240801152922.5605-1-ni_liqiang@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 4:29 pm, niliqiang wrote:
>> +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>> +				  struct arm_smmu_master *master)
>> +{
>> +	int i;
>> +	int ret = 0;
>> +	struct arm_smmu_stream *new_stream, *cur_stream;
>> +	struct rb_node **new_node, *parent_node = NULL;
>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>> +
>> +	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
>> +				  GFP_KERNEL);
>> +	if (!master->streams)
>> +		return -ENOMEM;
>> +	master->num_streams = fwspec->num_ids;
>> +
>> +	mutex_lock(&smmu->streams_mutex);
>> +	for (i = 0; i < fwspec->num_ids; i++) {
> 
> Hi all experts,
> 
> Recently, I have been debugging the smmuv3 code in the Linux kernel,
> and I have some questions regarding the `mutex_lock(&smmu->streams_mutex)`
> statement in the `arm_smmu_insert_master` function.
> I would like to understand why streams_mutex is being locked here.

Because the "streams" rbtree is being modified, so it would be pretty 
bad if another thread tried to walk or modify it concurrently. I'd hope 
that was obvious from the code everywhere "streams" and "streams_mutex" 
are referenced.

> Is it to handle different types of PF under a single EP, each with its own device ID?

It is expected that a single SMMU instance is highly likely to have more 
than one device behind it, and therefore more than one StreamID to keep 
track of.

Thanks,
Robin.

