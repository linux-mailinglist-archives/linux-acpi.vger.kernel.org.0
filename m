Return-Path: <linux-acpi+bounces-17719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF4BCDFE3
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E154816A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BEF2FC037;
	Fri, 10 Oct 2025 16:53:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362E2FBE12;
	Fri, 10 Oct 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115222; cv=none; b=lvwJWyRLwi/4ebQSxZNwlGH/SNdW9iIHP105O7WUiYPsgRD6AVRabsTrUfLxDsmwC4jBDD5sKbMGGfiuk0fh+a4r+5ev63901y1Jgdc28DrqG7ptbswIEaBmHV8bVc53FX8uM6ziM5/z1OtQFKu80j4gODq6hs4E6KL3FIOMR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115222; c=relaxed/simple;
	bh=WYmRoI4S9GFrm7QXAvKGxioni4+4DNuDA6TyvB1V6tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t77LXaWvLt7hz4LJOQX7TwIY0YQUx+jJjw/diDBLDr+UY5yMoOjI6wbefhZ7H/FFn5G7aoyDl1EFHz4Wdjbt/hqiRWf2t8R1ZszCcY+nDjyHKCjYv7fSgmrrqj8JathEtyqo18yYdkpC80c0vxsdMXJ5027+9tKAIwMDCwzwvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F9D175D;
	Fri, 10 Oct 2025 09:53:31 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57A743F66E;
	Fri, 10 Oct 2025 09:53:33 -0700 (PDT)
Message-ID: <aa0fd6dd-3332-46a2-a894-cf0416d3e461@arm.com>
Date: Fri, 10 Oct 2025 17:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-28-james.morse@arm.com>
 <af6b6827-9bab-4328-ace0-710d7845c2ac@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <af6b6827-9bab-4328-ace0-710d7845c2ac@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 26/09/2025 05:11, Fenghua Yu wrote:
> On 9/10/25 13:43, James Morse wrote:
>> resctrl expects to reset the bandwidth counters when the filesystem
>> is mounted.
>>
>> To allow this, add a helper that clears the saved mbwu state. Instead
>> of cross calling to each CPU that can access the component MSC to
>> write to the counter, set a flag that causes it to be zero'd on the
>> the next read. This is easily done by forcing a configuration update.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Other than the following minor change,
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>

Thanks!


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 3080a81f0845..8254d6190ca2 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>>   @@ -1245,6 +1257,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg
>> *ctx,
>>       return err;
>>   }
>>   +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
>> +{
>> +    int idx;
>> +    struct mpam_msc *msc;
>> +    struct mpam_vmsc *vmsc;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    if (!mpam_is_enabled())
>> +        return;
>> +
>> +    idx = srcu_read_lock(&mpam_srcu);

> guard(srcu)(&mpam_srcu);

Yeah, Jonathan had already suggested it.


>> +    list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
>> +        if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
>> +            continue;
>> +
>> +        msc = vmsc->msc;
>> +        list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
>> +            if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
>> +                continue;
>> +
>> +            if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
>> +                continue;
>> +
>> +            ris->mbwu_state[ctx->mon].correction = 0;
>> +            ris->mbwu_state[ctx->mon].reset_on_next_read = true;
>> +            mpam_mon_sel_unlock(msc);
>> +        }
>> +    }
>> +    srcu_read_unlock(&mpam_srcu, idx);
>> +}


Thanks,

James

