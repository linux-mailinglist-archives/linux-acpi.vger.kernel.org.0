Return-Path: <linux-acpi+bounces-16608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C27B520FE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914FE58455E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885B255F31;
	Wed, 10 Sep 2025 19:30:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25B1A9FAB;
	Wed, 10 Sep 2025 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532640; cv=none; b=Y3ABK7RyiIo+c3mqBse0LNvuOFyyh8Nx0dInXt+4J9I8KBzBl4lK6cTAV7Dj6BSrKIaR+YKl/X4iUNl0QEmT0YkOdFWxiDIF/kW99v8Udpt0XKZcRs+69l7ptkS+X5nWqpXvaF/0SxbOwfr5unLM3COKRlRZ0NOyHbmgW9y43Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532640; c=relaxed/simple;
	bh=CFkFFhuK4a4sgSNf/dIg9P4rxUjRSaINRvr5UWYmgy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+iR4Go4uaZB6Dw4ys2UuxLi8aKgemsG/Z4gZWZlyGVvDxUm9Hyo13lLRXgAgp+r5Xtjjv/s7NsKnKSj/I3lqQCtGHYiNXMwHLJy2mAsqSonzwDXF48ncleuLZhu4C5Ynivsn8QtKL/zNqx53xg465vtEtpJppqboHie3inJ0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97A016F8;
	Wed, 10 Sep 2025 12:30:28 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093773F694;
	Wed, 10 Sep 2025 12:30:30 -0700 (PDT)
Message-ID: <761245fb-a045-4809-9fd9-5efc56794b37@arm.com>
Date: Wed, 10 Sep 2025 20:30:29 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] arm_mpam: Add mpam_msmon_read() to read monitor
 value
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
 <20250822153048.2287-28-james.morse@arm.com>
 <f71d944e-7f9d-489e-a278-2d09900f5d53@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <f71d944e-7f9d-489e-a278-2d09900f5d53@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 16:55, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> Reading a monitor involves configuring what you want to monitor, and
>> reading the value. Components made up of multiple MSC may need values
>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>> not ready, then wait the full timeout value before trying again.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index e7e00c632512..9ce771aaf671 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -973,6 +973,228 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)

>> +static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>> +				   u32 *flt_val)
>> +{
>> +	struct mon_cfg *ctx = m->ctx;
>> +
>> +	switch (m->type) {
>> +	case mpam_feat_msmon_csu:
>> +		*ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
>> +		break;
>> +	case mpam_feat_msmon_mbwu:
>> +		*ctl_val = MSMON_CFG_MBWU_CTL_TYPE_MBWU;
>> +		break;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * For CSU counters its implementation-defined what happens when not
>> +	 * filtering by partid.
>> +	 */
>> +	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
>> +
>> +	*flt_val = FIELD_PREP(MSMON_CFG_MBWU_FLT_PARTID, ctx->partid);
>> +	if (m->ctx->match_pmg) {
>> +		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>> +		*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_PMG, ctx->pmg);
>> +	}

> As we are using MSMON_CFG_MBWU_FLT_{PMG,PARTID} for both CSU and MBWU
> how about changing to MSMON_CFG_x_FLT_{PMG,PARTID}?

Sure,


>> +
>> +	if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
>> +		*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);

> This needs to be conditional on the type of the monitor being
> configured. There is an XCL bit here for CSU monitors.

Fixed ... that wasn't there last time I looked!
I may as well wire that up too...


Thanks,

James

