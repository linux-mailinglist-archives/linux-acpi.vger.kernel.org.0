Return-Path: <linux-acpi+bounces-16741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78979B552AD
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB8A087ED
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5722172E;
	Fri, 12 Sep 2025 15:09:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0428373;
	Fri, 12 Sep 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689745; cv=none; b=KoG2FGPh9n4TZ0oK3/gkl4BxI/evb3O28y2Mqu5HzUaxrxFVbs7piA5Vwg1+tYqkMNLo0hL0mdK/Z5E+In9zo3Tx2rEC4XYSAvukhyOAtMbJ5vXLrcGzG6Ht5UbXsNkdmFXHvBNaR6dfCVteOOtfNS48niqR7cfXhXKwsADL3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689745; c=relaxed/simple;
	bh=Sf3Dy8uUFZpug9JpadlwWUw65olplxRVsQughTo54IQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IvzJp0R0N7W02M4sl7ghWni91ZKGwSg/iV7/flNiY0GfiDPPgufXZVrqOBJEuxzjOq4ya+V326PsHKiMN2kiYPS4WTq8/HZEYWEE7lb+W6FHR51wmfiKKiByTadnq3c9DW4Cl8/CbjtTsIiCb0yrf+AfRPPE3ktUqHwPdOR1MEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8FD12FC;
	Fri, 12 Sep 2025 08:08:55 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3143F694;
	Fri, 12 Sep 2025 08:08:58 -0700 (PDT)
Message-ID: <842edca0-11c7-43ac-ba4b-ab40678034e2@arm.com>
Date: Fri, 12 Sep 2025 16:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
From: Ben Horgan <ben.horgan@arm.com>
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
 <20250910204309.20751-24-james.morse@arm.com>
 <1344b395-66aa-4714-b1fc-9c970c0fd0bf@arm.com>
Content-Language: en-US
In-Reply-To: <1344b395-66aa-4714-b1fc-9c970c0fd0bf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/11/25 16:46, Ben Horgan wrote:
> Hi James,
> 
> On 9/10/25 21:43, James Morse wrote:
>> Reading a monitor involves configuring what you want to monitor, and
>> reading the value. Components made up of multiple MSC may need values
>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>> not ready, then wait the full timeout value before trying again.
>>
>> CC: Shanker Donthineni <sdonthineni@nvidia.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>> Changes since v1:
>>  * Added XCL support.
>>  * Merged FLT/CTL constants.
>>  * a spelling mistake in a comment.
>>  * moved structrues around.
>> ---
>>  drivers/resctrl/mpam_devices.c  | 226 ++++++++++++++++++++++++++++++++
>>  drivers/resctrl/mpam_internal.h |  19 +++
>>  2 files changed, 245 insertions(+)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index cf190f896de1..1543c33c5d6a 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> +
>> +static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>> +				   u32 *flt_val)
>> +{
>> +	struct mon_cfg *ctx = m->ctx;
>> +
>> +	/*
>> +	 * For CSU counters its implementation-defined what happens when not
>> +	 * filtering by partid.
>> +	 */
>> +	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
>> +
>> +	*flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
>> +	if (m->ctx->match_pmg) {
>> +		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>> +		*flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);
>> +	}
>> +
>> +	switch (m->type) {
>> +	case mpam_feat_msmon_csu:
>> +		*ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
>> +
>> +		if (mpam_has_feature(mpam_feat_msmon_csu_xcl, &m->ris->props))
>> +			*flt_val |= FIELD_PREP(MSMON_CFG_CSU_FLT_XCL,
>> +					       ctx->csu_exclude_clean);
>> +
>> +		break;
>> +	case mpam_feat_msmon_mbwu:
>> +		*ctl_val = MSMON_CFG_MBWU_CTL_TYPE_MBWU;

As you mentioned offline, this zeroes the other bits in *ctl_val.


Thanks,

Ben


