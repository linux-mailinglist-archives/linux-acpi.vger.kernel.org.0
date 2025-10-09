Return-Path: <linux-acpi+bounces-17694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCAABCA6C9
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E5004F6E41
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71154248880;
	Thu,  9 Oct 2025 17:49:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7E24BD0C;
	Thu,  9 Oct 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032152; cv=none; b=BfNF8poaKd21Cl8rQeR9PjWAyedBpY1SSPpcmNVCriWe+rFMpGFJqszFLxhCRMRC/eicoJlFV31jiWr1ONbY6sTMxs3eThtBc+bcdADHCokF8hHAfN2/hdNDEuWd3xYWGCI6BN57FfBgF4sTs6/I2v7Kd7ZMajKge8SqwTrdwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032152; c=relaxed/simple;
	bh=rCCyUL1n8C/LxLIxlKKLczvB0F82tywLO6Pt9q7I8sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8XNP42ZsBSTVfhxYfP1jXOr1HBCc5UCSsun1RXf+WabE/0V3OHum/nOVqEj7WOvbAEPps/lXr0EkufVbukwqgXz5Ka9dk+OP5xX1mtHgVK0rMHEyuHDxk/j8PAjZJF1f6LFOSiI4L0r+CDvS8zsq/n35HA2BHJqlO9eUay10HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A1342641;
	Thu,  9 Oct 2025 10:49:02 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EF543F66E;
	Thu,  9 Oct 2025 10:49:05 -0700 (PDT)
Message-ID: <d009edc0-651e-4815-89de-19c419ba0183@arm.com>
Date: Thu, 9 Oct 2025 18:48:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/29] arm_mpam: Track bandwidth counter state for
 overflow and power management
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
 <20250910204309.20751-25-james.morse@arm.com>
 <20250912142419.00006c6d@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912142419.00006c6d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:24, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:04 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Bandwidth counters need to run continuously to correctly reflect the
>> bandwidth.
>>
>> The value read may be lower than the previous value read in the case
>> of overflow and when the hardware is reset due to CPU hotplug.
>>
>> Add struct mbwu_state to track the bandwidth counter to allow overflow
>> and power management to be handled.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>

> Trivial comment inline.  I haven't spent enough time thinking about this
> to give a proper review so no tags yet.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 1543c33c5d6a..eeb62ed94520 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -918,6 +918,7 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>  	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
>>  
>>  	*flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
>> +

> Unrelated change.  If it makes sense figure out where to push it back to.

Done. This is may favourite mistake to make with a merge conflict!


Thanks,

James


>>  	if (m->ctx->match_pmg) {
>>  		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>>  		*flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);
> 

