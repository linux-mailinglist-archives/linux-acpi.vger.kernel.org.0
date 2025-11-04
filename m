Return-Path: <linux-acpi+bounces-18485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A232C306C9
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DBC4224E8
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBF2D594B;
	Tue,  4 Nov 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="C7ZkOGf/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE5265630;
	Tue,  4 Nov 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250623; cv=none; b=bQYkyzZBnzSlbTNhdqquxjFvrk4x2pMqRQ6X30gL/7JH0qQ0/LFF+2zYDRY7o56rdcSg0U9d+VNlrlG2mnRnCWjJEOvCwEYew9voxpssRJrunxjgcBUrJm+T4MwuFAqbJ6fTybjmLWFXP6tRB+KRcbC0biKqVso0kb//x276Dv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250623; c=relaxed/simple;
	bh=ByKsPzhI1q6lq0Yr2T2YcrTBx/zROmh18KVgyPJeoss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VjTZuiwMPh69ec5HSwJDyf696ARuJ0xB0IYdof496QAVk9nd5pZLy4CM30S9mRxEs1lJnH3yx/AoPbe7wlCzqYe+ZLbereSYiCKzFiYqLYuAZdg9IU/mkZPAjFmS3b7Aqu9e0bCM6nk2PFS6eiwJq0w4SWXMOVHzb6cQUAi1C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=C7ZkOGf/; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tMOTGYnkv7axYrDjHMmwI8rgDmLRpJW8riM4rrASqms=;
	b=C7ZkOGf/s2O7Yy+htzNvB8cBBVea0ycy2m5WmbYBUyqvdYkbHqAIFb2NJ1wuNuIsvbj0X5my5
	BadG1ruocfgiauJeCF0GIhHxVMFYp+Zh9dU4Rq+b49qVjcHcScHW4kaogzDLTL+Xax13fkP84m/
	1HnZ3W/1OOawj8FCJI3AYOw=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d13s774ryzLlVp;
	Tue,  4 Nov 2025 18:02:03 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 44625180043;
	Tue,  4 Nov 2025 18:03:38 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 18:03:38 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:03:37 +0800
Message-ID: <e4ccdd1d-2ade-4fac-8296-3b6eebce1bfa@huawei.com>
Date: Tue, 4 Nov 2025 18:03:36 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] ACPI: processor: idle: Remove useless codes about
 the verification of cstate count
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-6-lihuisong@huawei.com>
 <CAJZ5v0ifcuqF7=+NowYOfPbKfGq5XCe4+mg_9Sv8gRHyMZ0gNQ@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0ifcuqF7=+NowYOfPbKfGq5XCe4+mg_9Sv8gRHyMZ0gNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/11/4 2:10, Rafael J. Wysocki 写道:
> On Mon, Nov 3, 2025 at 9:42 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
>> be called after successfully obtaining the power information. These setup
>> functions have their own main role, but also verify the validity of cstate
>> count.
>>
>> Actually, the acpi_processor_get_power_info_cst will return failure if the
>> cstate count is zero and acpi_processor_get_power_info will return failure.
>>
>> So the verification of cstate count in these functions are useless.
>>
>> No intentional functional impact.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 22 +++++++---------------
>>   1 file changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 4627b00257e6..1f332f02d273 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -732,8 +732,8 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>>          return 0;
>>   }
>>
>> -static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>> -                                          struct cpuidle_device *dev)
>> +static void acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>> +                                           struct cpuidle_device *dev)
>>   {
>>          int i, count = ACPI_IDLE_STATE_START;
>>          struct acpi_processor_cx *cx;
>> @@ -753,14 +753,9 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>>                  if (count == CPUIDLE_STATE_MAX)
>>                          break;
>>          }
>> -
>> -       if (!count)
>> -               return -EINVAL;
>> -
>> -       return 0;
>>   }
>>
>> -static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>> +static void acpi_processor_setup_cstates(struct acpi_processor *pr)
>>   {
>>          int i, count;
>>          struct acpi_processor_cx *cx;
>> @@ -822,11 +817,6 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>>          }
>>
>>          drv->state_count = count;
>> -
>> -       if (!count)
>> -               return -EINVAL;
>> -
>> -       return 0;
>>   }
>>
>>   static inline void acpi_processor_cstate_first_run_checks(void)
>> @@ -1248,7 +1238,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>>          if (pr->flags.has_lpi)
>>                  return acpi_processor_setup_lpi_states(pr);
>>
>> -       return acpi_processor_setup_cstates(pr);
>> +       acpi_processor_setup_cstates(pr);
>> +       return 0;
>>   }
>>
>>   /**
>> @@ -1268,7 +1259,8 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>          if (pr->flags.has_lpi)
>>                  return 0;
>>
>> -       return acpi_processor_setup_cpuidle_cx(pr, dev);
>> +       acpi_processor_setup_cpuidle_cx(pr, dev);
>> +       return 0;
>>   }
>>
>>   static int acpi_processor_get_power_info(struct acpi_processor *pr)
>> --
> Does this patch depend on the previous patches in the series?  If it
> doesn't, why don't you send it independently?
Good suggestion. Thanks, got it.
This patch doesn't depend on them.
But patch 6/7 and 7/7 depend on this patch and patch 3/7.
If they still need some times to discuss, I can send this patch first.
>
>

