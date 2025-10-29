Return-Path: <linux-acpi+bounces-18305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3082C18372
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 04:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0263B398E
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 03:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4A2F0C6F;
	Wed, 29 Oct 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="eCUKUI6/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89052EBBB0;
	Wed, 29 Oct 2025 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710359; cv=none; b=BshCTiP5E2zPLRNjcjWNWOrpDmymeFACbmtSrRY9RE6u40HrOIAISOhFXvnM3Cwj7b9Qg8aPO51CDJFZ6MEepJVFZTL7FCV2dEvfICAW0L4+PmFwDt6iV5kgvbOsA773NobPHrWPhfMyc1U0D4A6ChJ/yl5kratp6GkaA5QVNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710359; c=relaxed/simple;
	bh=L9YPOc5/22eujfuGoDgpu42AiuHjAc0Bz/qDHhn1kHo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=dnWSBwUEDfDJnZk3jFzdJwmILopISdfx6aGO5hq4mF1430ASYueWb+rUI1zaZZPocVqEpeGyz/lLiJjaWqrPW36x+g+eXoodS2Ol1L0jWcm8nbHYp94qIzi7Iq5wOZ70woj2HGd+urQjgpqDxJBvW2tGUqCl0Wy984WC560avFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=eCUKUI6/; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YZ+v2V2HXO6fEBeqBbs+msJfMB5CADuyB6hkvZ2bvZY=;
	b=eCUKUI6/NwtRM/E7RQR1yQobi7ENuTPHsrj3A3FPHcQn8L15fPvRu5QG5s02vQFZIrhbnP8NK
	GHj8jBBRlpNGJCJ9BEfD26rbz7PUiQME3JulKOlKSWuCjzYDEPQlTGeE5kyz7IwYG4A8fOs0msq
	vQd8oEKetNi+ne/lVOlKb7E=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cxD3d2KzbzpStg;
	Wed, 29 Oct 2025 11:57:49 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 840941402CD;
	Wed, 29 Oct 2025 11:59:07 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 11:59:05 +0800
Message-ID: <8134b0ec-1c0a-1a3a-b3df-3c620490fa9b@huawei.com>
Date: Wed, 29 Oct 2025 11:59:04 +0800
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
From: Zeng Heng <zengheng4@huawei.com>
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
 <d2aa99f8-dbdc-dc13-1ba3-0e273913221f@huawei.com>
In-Reply-To: <d2aa99f8-dbdc-dc13-1ba3-0e273913221f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Ben,

On 2025/10/29 10:49, Zeng Heng wrote:
> Hi Ben,
> 
> On 2025/10/29 0:01, Ben Horgan wrote:
>> Hi Zeng,
>>
>> On 10/25/25 10:01, Zeng Heng wrote:
>>> Hi Ben,
>>>
>>> On 2025/10/23 0:17, Ben Horgan wrote:
>>>
>>>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>>>> ---
>>>>>    drivers/resctrl/mpam_devices.c | 8 +++++---
>>>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>>>>> mpam_devices.c
>>>>> index 0dd048279e02..06f3ec9887d2 100644
>>>>> --- a/drivers/resctrl/mpam_devices.c
>>>>> +++ b/drivers/resctrl/mpam_devices.c
>>>>> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>>>>>        clean_msmon_ctl_val(&cur_ctl);
>>>>>        gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>>>>        config_mismatch = cur_flt != flt_val ||
>>>>> -              cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>>>>> +             (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
>>>>> +             (ctl_val | MSMON_CFG_x_CTL_EN);
>>>>
>>>> This only considers 31 bit counters. I would expect any change here to
>>>> consider all lengths of counter.
>>>
>>> Sorry, regardless of whether the counter is 32-bit or 64-bit, the
>>> config_mismatch logic should be handled the same way here. Am I
>>> wrong?
>>
>> Yes, they should be handled the same way. However, the overflow status
>> bit for long counters is MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L.
>>
>> I now see that the existing code in the series has this covered.
>> Both the overflow bits are masked out in clean_msmon_ctl_val(). No need
>> for any additional masking.
>>
> 
> Yes, I’ve seen the usage, except that clearing the overflow bit in the
> register is missing.
> 

Please disregard my previous mail... :)

Exactly, thanks for the review. I'll fold the fixes into v2 of the
patch.


Best Regards,
Zeng Heng

