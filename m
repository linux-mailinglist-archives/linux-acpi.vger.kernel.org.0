Return-Path: <linux-acpi+bounces-20397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A903ED2CA1C
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624A2302E05E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81FF34D90C;
	Fri, 16 Jan 2026 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="iRlSlLWp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3C25EF9C;
	Fri, 16 Jan 2026 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545491; cv=none; b=PAVIwiy7/rIf0Pe/RcwfKHRLg/7reZvaFFhMP7OmFjvPy7Ve6zM5UzM0dCz2BAQhXqT/KCpIrr9MR6O57CaLNmBQncJ0wn3MFxSoUtxLasJeJjUVVRSoteaWtt3Fyn38t5RRUSfeAYejHhDOzr/tiCREPjpSSii6S9e+umngzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545491; c=relaxed/simple;
	bh=u7eMeyLB4B0mhEMA5spd2K45pkYXzynrjUmKpfCfZL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KJUu4ZiY2G8wFkBgGqnQOZAqGxvQjr1iJ0hbfcFNmDBQwl9gEUVWfy/tEd6iwSoSvSu+rfCz3n7FNaN/sc+zS+ma1QV/xJr459UZsha0M7EsKdVt4l9GuRFSYglN9+3cNm554itGMg1o6FGS2QF9BcQxLJ6UNpbhK9l+9vj4bWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=iRlSlLWp; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ni2m24F4hbM2ae2lBzcBnVuP1JzodDb2jS+4POsSskI=;
	b=iRlSlLWpDL3Vc1lcK3gPGJo1zar1eIT3lktImrLC2BlZ294R6xfUs46xEjSlIAWa3pGc0u1er
	/0BYXyKx0tAM1GVeUn6N+dc4KykpAiwjGYLFZRns42p9lU1DDUc6HtBq+NS56Eisjs1O12eRF4M
	gjW51aKBXExoFy/UghDHWmk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dsqpY0fSPz12LDt;
	Fri, 16 Jan 2026 14:35:01 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E29040537;
	Fri, 16 Jan 2026 14:38:00 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 14:38:00 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Jan
 2026 14:37:59 +0800
Message-ID: <ededfb4c-4ade-45cc-ae09-5b6589dc339c@huawei.com>
Date: Fri, 16 Jan 2026 14:37:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: processor: idle: Relocate and verify
 acpi_processor_ffh_lpi_probe
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
References: <20251125065210.3670266-1-lihuisong@huawei.com>
 <20251125065210.3670266-2-lihuisong@huawei.com>
 <CAJZ5v0j9Mp5AqQwpakVLWDmK10cjOOiKtetfCr2OSSukekdPhQ@mail.gmail.com>
 <2b1a456f-b9e3-4722-84ba-ba4fdd4b2ece@huawei.com>
 <CAJZ5v0hfwWCSOdyhqn_ZHGnHrbZ1YcXk8t5o8=cGXDbc1WfnEw@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hfwWCSOdyhqn_ZHGnHrbZ1YcXk8t5o8=cGXDbc1WfnEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 1/15/2026 9:06 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 15, 2026 at 1:09 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>> Hi Rafael,
>>
>> On 1/15/2026 1:27 AM, Rafael J. Wysocki wrote:
>>> On Tue, Nov 25, 2025 at 7:52 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> The platform used LPI need check if the LPI support and the entry
>>>> method is valid by the acpi_processor_ffh_lpi_probe(). But the return
>>>> of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
>>>> isn't verified by any caller.
>>>>
>>>> What's more, acpi_processor_get_power_info() is a more logical place for
>>>> verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev().
>>>> So move acpi_processor_ffh_lpi_probe() from the latter to the former and
>>>> verify its return.
>>>>
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/acpi/processor_idle.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>> index 5f86297c8b23..cdf86874a87a 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -1252,7 +1252,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>>>
>>>>           dev->cpu = pr->id;
>>>>           if (pr->flags.has_lpi)
>>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
>>>> +               return 0;
>>>>
>>>>           acpi_processor_setup_cpuidle_cx(pr, dev);
>>>>           return 0;
>>>> @@ -1264,7 +1264,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>>>>
>>>>           ret = acpi_processor_get_lpi_info(pr);
>>>>           if (ret)
>>>> -               ret = acpi_processor_get_cstate_info(pr);
>>>> +               return acpi_processor_get_cstate_info(pr);
>>>> +
>>>> +       if (pr->flags.has_lpi) {
>>>> +               ret = acpi_processor_ffh_lpi_probe(pr->id);
>>>> +               if (ret)
>>>> +                       pr_err("Processor FFH LPI state is invalid.\n");
>>>> +       }
>>>>
>>>>           return ret;
>>>>    }
>>>> --
>>> Please reorder this behind the next patch in the series.
>> Patch 2/3 depends on this patch.
>> So I don't know how to reorder this patch.
> I should have been more precise, sorry.
>
> Please first convert acpi_processor_setup_cpuidle_dev() to a void
> function and then make the changes from this patch on top of that.
The acpi_processor_ffh_lpi_probe may return an error.
And acpi_processor_setup_cpuidle_dev can pass the error code to its 
caller(Although the caller ignored it currently).
It may be inapproprate to convert acpi_processor_setup_cpuidle_dev() to 
a void function directly if we doesn't move acpi_processor_ffh_lpi_probe 
out first.
So I first relocate the position of acpi_processor_ffh_lpi_probe. Then 
changing it to a void function would be more logical.

Or we need to drop the return value of acpi_processor_ffh_lpi_probe and 
convert acpi_processor_setup_cpuidle_dev to a void function, like:
-->

-static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
-					    struct cpuidle_device *dev)
+static void acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
+					     struct cpuidle_device *dev)
  {
  	if (!pr->flags.power_setup_done || !pr->flags.power || !dev)
-		return -EINVAL;
+		return;
  
  	dev->cpu = pr->id;
  	if (pr->flags.has_lpi) {
-		return acpi_processor_ffh_lpi_probe();
+               acpi_processor_ffh_lpi_probe();
+		return;
         }
  
  	acpi_processor_setup_cpuidle_cx(pr, dev);
-	return 0;
  }

What do you think now?

>

