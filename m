Return-Path: <linux-acpi+bounces-18214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF9C08DFE
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23DD1C27E4C
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58272101AE;
	Sat, 25 Oct 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="lNsJIeyY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C072612;
	Sat, 25 Oct 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761381942; cv=none; b=EvJ0vpwcoleako71OnIMhqHiSowT4IwPwHIJYgRJ1EpZ03S/ozedS38WaVfm+cnqfvemiK2zZe9obC/CQ5Ck511pw77gz4U9G5t5/NTsTFZx26573A1A1a4/UI/ShgHOSTCv3vT7cMSXLIxxrK1oq4677isZrrzCoyUENTubwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761381942; c=relaxed/simple;
	bh=cYQj9uCtErpSegmwQWTmqRdJg3P1rce2LhSWvbhvCqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MyCkT50WOdB9Pj98Dm3jW9kLZGqCeykjqNXfYVYkxQSE29UafcHP178VCjpQzsdAfi3CePkdkpwS2IZjZiG03rAH3We0q4NlwjmffePYAUXQQO+fNNAf7nEM9Q5ZPJQ/ssJ9ehquwJOxdhc0qWGzaMiIxrQMsKjQgGn09JzSUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=lNsJIeyY; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WXyAFA5Wbi47ZBAxqv5Bu/yKif771bwawPjOvd+jr7w=;
	b=lNsJIeyYZiwTBahxj1BEFLlccwGR1V9DsvyWON/GCcWZ0vZkcYf9mxKmA25qQgxCoo8FWZHr9
	TdUvkijvAfvZLy3SxFzpspBtHZMaEq3uxfIdWVSVZ6fShrIwswyZQXJ54yughkIXwSfMwxIbi4p
	C+HOhZTTeGQO9FtdhQasgZ4=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cttcm03srz12LFQ;
	Sat, 25 Oct 2025 16:44:56 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 78B6B180B71;
	Sat, 25 Oct 2025 16:45:35 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 16:45:33 +0800
Message-ID: <a3e95937-b0c7-020e-d52d-7189d2540f8f@huawei.com>
Date: Sat, 25 Oct 2025 16:45:32 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1] arm64/mpam: Fix MBWU monitor
 overflow handling
Content-Language: en-US
To: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<guohanjun@huawei.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251022133913.629859-1-zengheng4@huawei.com>
 <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Ben,

On 2025/10/23 0:17, Ben Horgan wrote:
>>
>> Also fix the handling of overflow amount calculation. There's no need to
>> subtract mbwu_state->prev_val when calculating overflow_val.
> 
> Why not? Isn't this the pre-overflow part that we are missing from the
> running count?
> 

The MSMON_MBWU register accumulates counts monotonically forward and
would not automatically cleared to zero on overflow.

The overflow portion is exactly what mpam_msmon_overflow_val() computes,
there is no need to additionally subtract mbwu_state->prev_val.

>>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 0dd048279e02..06f3ec9887d2 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>>   	clean_msmon_ctl_val(&cur_ctl);
>>   	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>   	config_mismatch = cur_flt != flt_val ||
>> -			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>> +			 (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
>> +			 (ctl_val | MSMON_CFG_x_CTL_EN);
> 
> This only considers 31 bit counters. I would expect any change here to
> consider all lengths of counter. Also, as the overflow bit is no longer
> reset due to the config mismatch it needs to be reset somewhere else.

Yes, overflow bit needs to be cleared somewhere. I try to point out in
the next patch mail.

Best Regards,
Zeng Heng

