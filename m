Return-Path: <linux-acpi+bounces-18137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA675C005F3
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 226D13595AA
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FBE30B503;
	Thu, 23 Oct 2025 09:59:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C92F5A1F;
	Thu, 23 Oct 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213596; cv=none; b=uxa3mZcS7u1lTtZjcDKOYKqZ6X0nRRh3QQVEppjxs5t/kO04WREFl2rq7MAYn2Hq9DWwOIanuRv75gNT6nGvMUz49lTqq1/xi4iHM5Emn6y61BtTTuSGraPaZkRj4IDI4XXWbqIVCk215IRbB9nuNbG4Npm23DBhpPztm2zaXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213596; c=relaxed/simple;
	bh=9ZH0ly9d0T/MSQlVFerFTC1udKUb6QvB/Q1uo2YEAw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bb3do73tOSFw9XoPXIrXsOmeSMMQKfz3WkPME1/5I5u1ivFXNs6sGWy0a4zcsYubkJF/oqNMnEJzHuoh5mMcDx1M7siMNrS1jg5tul9sKOAcZi8i8sGK0R1sn8J0llhRlpAHipwRI+yTgM+ZE+Rgfz6PYafFl0M/RWkLQO6n8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cshPb0bWNz11Wrv;
	Thu, 23 Oct 2025 18:01:07 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D6B431401E9;
	Thu, 23 Oct 2025 17:59:50 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 17:59:50 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 17:59:50 +0800
Message-ID: <5caae4ef-e259-47cc-b0b7-f383dce4a334@huawei.com>
Date: Thu, 23 Oct 2025 17:59:49 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] ACPI: processor: idle: Return failure when get
 lpi_state->arch_flags failed
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-4-lihuisong@huawei.com>
 <CAJZ5v0hNj817g=rr8+YTGaeBkkfNuuU7FGuZyyb1j61BMOKTGA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hNj817g=rr8+YTGaeBkkfNuuU7FGuZyyb1j61BMOKTGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/22 3:36, Rafael J. Wysocki 写道:
> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The architecture specific context loss flags is important for ARM.
>> And this flag is used to control the execution of different code
>> flows in acpi_processor_ffh_lpi_enter().
>>
>> So it is better to return failure when get lpi_state->arch_flags
>> failed.
> A failure means no idle states at all.
Actually, I didn't know why driver should continue to do cpu idle 
scaling if the idle state doesn't meet the developer's expectations.🙂
> Wouldn't it be better to skip the state with invalid arch flags?
This arch flags is important.  And acpi_processor_ffh_lpi_enter will use it.
There is no other place to verify its validity. so here do it.
This check is just to prevent potential issues in cpuidle scaling later.
>
>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 681587f2614b..f36f9514b6c7 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -984,8 +984,11 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>>                  if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
>>                          lpi_state->flags = 0;
>>
>> -               if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags))
>> -                       lpi_state->arch_flags = 0;
>> +               if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)) {
>> +                       pr_err("Get architecture specific context loss flags failed.\n");
>> +                       ret = -EINVAL;
>> +                       goto end;
>> +               }
>>
>>                  if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_freq))
>>                          lpi_state->res_cnt_freq = 1;
>> --
>> 2.33.0
>>

