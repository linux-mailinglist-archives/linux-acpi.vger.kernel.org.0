Return-Path: <linux-acpi+bounces-16610-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDDB52105
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6DE1C8624E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D9B2D7381;
	Wed, 10 Sep 2025 19:30:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0D2D593C;
	Wed, 10 Sep 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532654; cv=none; b=FY977aQeqen8DbxhPRmorhmidWMcVLP9tQErmWJgQhc3oRe9hqMdVOATqohac5gdmR3xj+ZRBqKeqKWf3Eq3wAX31+zJ+R7l8guvPil7pnTNwjCKtWhlSLOTf/kJLCS/zb9jem+EbNhu+gR30a/6A9IvWxs8IqxRWdsgRAEccPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532654; c=relaxed/simple;
	bh=pObe5aWVYV6eGcu3pJTvxDbgSxA/QkHIfWc8ZZHMS+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRcJVI5beWSlcz42GtltPL3FADAy988/pForlYCc0Nv0ZaROE7apmhEfHUrt8uUSsh/fUTChHfAGVuUf/aQYjNpiJGt0x0RcHPPBdVkJiGvgpPyvgmYuRwpt0uIICOm5Qyo3ZhGTUGNkCex0O8He+wT1LDuG9yIshnaHQ1dN9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA46A16F2;
	Wed, 10 Sep 2025 12:30:43 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31ACF3F694;
	Wed, 10 Sep 2025 12:30:45 -0700 (PDT)
Message-ID: <7760c082-2702-42bb-ad0d-cc7db40b0d4d@arm.com>
Date: Wed, 10 Sep 2025 20:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] arm_mpam: Use long MBWU counters if supported
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
 <20250822153048.2287-31-james.morse@arm.com>
 <a3d26a1d-6887-47a4-8679-4567e417f65e@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <a3d26a1d-6887-47a4-8679-4567e417f65e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 17:39, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> From: Rohit Mathew <rohit.mathew@arm.com>
>>
>> If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
>> the RIS, use long/LWD counter instead of the regular 31 bit mbwu
>> counter.
>>
>> Only 32bit accesses to the MSC are required to be supported by the
>> spec, but these registers are 64bits. The lower half may overflow
>> into the higher half between two 32bit reads. To avoid this, use
>> a helper that reads the top half multiple times to check for overflow.


> Looks good to me.
> 
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks!


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 2ab7f127baaa..8fbcf6eb946a 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> @@ -1058,6 +1100,7 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>  static void clean_msmon_ctl_val(u32 *cur_ctl)
>>  {
>>  	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
>> +	*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;

> I observe that this bit is res0, in the CSU case, and so the clearing is ok.

As they've started allocating bits that collide, it probably shouldn't rely on that.
The bug would be when that bit gets set for CSU in the future, its always masked out and
the monitor gets reprogrammed every time. (possibly incurring the timeout each time)

Changed as:
|	if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) == MSMON_CFG_MBWU_CTL_TYPE_MBWU)
|		*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;


Thanks,

James

