Return-Path: <linux-acpi+bounces-18302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF785C18173
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 03:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D781C612A6
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 02:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E542D29CE;
	Wed, 29 Oct 2025 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="RKXstXVv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1B2D4807;
	Wed, 29 Oct 2025 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706161; cv=none; b=YmrXp1KjyoTBAoiargQl4OMb8FbtCybqYMTYRyet5A5GB+dTNDaV40eqdDn7hdpRRIR2fBZ+EgD6oYbqW9F4iz/dD8WdagRom/m6x0s1UkR73LSZuejIKuVGPc4XGgzuzIyQ6ke2lM+SIgRaSPusRs8Ge26evz4C4oW2DeHDXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706161; c=relaxed/simple;
	bh=QnTKJpeyRIjyDa47W0h7PXyC/NZxzAQ9sNXIFO+5Xr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AsTzkNmqxspKaPsrwlTfnVITflkP6NV/LWRTLUoh5Yka7Oh7Qg25bH4XsA4ryvLViUXAz9XFcFIEV4rhNwdCvvzS3ZFr0mTj7l7GTaw952O7cg5Cxd/R/uIIz+UtWKo0c8FEOT7ip5PDPgDlvvDam0VdH4xpKoijii+oegZ+pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=RKXstXVv; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8mI8RJyZEWdQPWipyhU5oi8LYU908r35UXOl0PDE2pw=;
	b=RKXstXVvw/LZpzS0fSWou1gFKYhepNujxLVzFYfqP/hVNROwao9fAijMpqJ7aS2SgivbxlhfV
	QMGUxARIOAMjVw6Sr30RakvQ7BOQ/KPwPrHSYOQbxXZARvw/4pSVDE9j/AGg6tTvLv6MKiioztN
	wi2bSSDa1/ZveTTJQE0yqoQ=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cxBWw6rCfzLlSH;
	Wed, 29 Oct 2025 10:48:44 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F10E180043;
	Wed, 29 Oct 2025 10:49:13 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 10:49:11 +0800
Message-ID: <d2aa99f8-dbdc-dc13-1ba3-0e273913221f@huawei.com>
Date: Wed, 29 Oct 2025 10:49:10 +0800
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
 <1c037f72-485a-567b-bf8f-489255330de8@huawei.com>
 <56f7f2df-fd94-48c8-aaa0-97a71b3108cf@arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <56f7f2df-fd94-48c8-aaa0-97a71b3108cf@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Ben,

On 2025/10/29 0:01, Ben Horgan wrote:
> Hi Zeng,
> 
> On 10/25/25 10:01, Zeng Heng wrote:
>> Hi Ben,
>>
>> On 2025/10/23 0:17, Ben Horgan wrote:
>>
>>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>>> ---
>>>>    drivers/resctrl/mpam_devices.c | 8 +++++---
>>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>>>> mpam_devices.c
>>>> index 0dd048279e02..06f3ec9887d2 100644
>>>> --- a/drivers/resctrl/mpam_devices.c
>>>> +++ b/drivers/resctrl/mpam_devices.c
>>>> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>>>>        clean_msmon_ctl_val(&cur_ctl);
>>>>        gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>>>        config_mismatch = cur_flt != flt_val ||
>>>> -              cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>>>> +             (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
>>>> +             (ctl_val | MSMON_CFG_x_CTL_EN);
>>>
>>> This only considers 31 bit counters. I would expect any change here to
>>> consider all lengths of counter.
>>
>> Sorry, regardless of whether the counter is 32-bit or 64-bit, the
>> config_mismatch logic should be handled the same way here. Am I
>> wrong?
> 
> Yes, they should be handled the same way. However, the overflow status
> bit for long counters is MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L.
> 
> I now see that the existing code in the series has this covered.
> Both the overflow bits are masked out in clean_msmon_ctl_val(). No need
> for any additional masking.
> 

Yes, I’ve seen the usage, except that clearing the overflow bit in the
register is missing.


Best Regards,
Zeng Heng

