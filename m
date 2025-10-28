Return-Path: <linux-acpi+bounces-18282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23978C14ADA
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 13:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB4BC4EE0DF
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB621D9663;
	Tue, 28 Oct 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="m9mpOgko"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F170814;
	Tue, 28 Oct 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655529; cv=none; b=cPmzWgRX4WOgalNHgTiw4zX8FZH9JzGXUjGQ4n6rAxxAumY5eKJyxPzHpHSl3M/NzG6+bz4SDIR371I624zYGnmY0ALSFRyMvGBP7QkL+oZ/jotBC/A3ECblRmGEZNP4lV6QUV10DCsxorQKXVsabcdJ6u6yKhMyNC9Ig241CbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655529; c=relaxed/simple;
	bh=9wZk5sXSgzA5BvgJk1Uy0tGDc/rTznFeMKkA10O9MLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=khCmgykFkD2e1U6KwnAn4Y3WLXZLBJdkiukdAO82E31K/XW/8bhZdOziz66T8AtHnWJ+kqb1gR3zGsPlyQWfese0wmVkSG2frsv18l+zFxgY4mevtYSs5gAaOD9eSDGAyEFKwb2w98Zs484NbWM/sGI2ga6ZeiQL/einzKjh7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=m9mpOgko; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x3ca+g4DlaRMbjc/5KfmK6KVWO/wR38SdI3Tr46Amw0=;
	b=m9mpOgkoqP2PdC+FmGwy/s9r+MNMhTIEoyibiPhE8Mgzmv1pGCp/AawYcvCExasS2Bxe1oVMA
	sn/CHI7K3DD+QxGDLeuY62JlRb89lS9HEheSZlT/VZQ/ED18bBczn0mXri1zTdPEsvOEvVZ8Faf
	KPTb/cY0l/ZywnzWl2jGTBk=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cwqny75ZZz12LFQ;
	Tue, 28 Oct 2025 20:44:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B1D67140277;
	Tue, 28 Oct 2025 20:45:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 20:45:16 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 20:45:15 +0800
Message-ID: <8b1dc682-928a-4898-876c-ae6ccf59d328@huawei.com>
Date: Tue, 28 Oct 2025 20:45:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-6-lihuisong@huawei.com>
 <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
 <92b1b431-9855-43fb-8bb3-801649064438@huawei.com>
 <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
 <ab814879-37d6-49dc-8a38-6b94cabf9327@huawei.com>
 <CAJZ5v0hHO_vuQ71sQ2=vmjEMNr3jYh6Wx_nk55gQVdGgWFDHKQ@mail.gmail.com>
 <37fb4e84-d404-449e-986a-e5ccb327bd78@huawei.com>
 <CAJZ5v0j9i1W3JmDQP+-tTqu1dnE1i1XeZUk5=JMKRN_e++iJ7w@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0j9i1W3JmDQP+-tTqu1dnE1i1XeZUk5=JMKRN_e++iJ7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/27 20:28, Rafael J. Wysocki 写道:
> On Mon, Oct 27, 2025 at 2:43 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/10/26 20:40, Rafael J. Wysocki 写道:
>>> On Fri, Oct 24, 2025 at 11:40 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>>> 在 2025/10/23 18:35, Rafael J. Wysocki 写道:
>>>>> On Thu, Oct 23, 2025 at 12:17 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>>>>>> 在 2025/10/22 3:42, Rafael J. Wysocki 写道:
>>>>>>> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>>>>>> Both ARM64 and RISCV architecture would validate Entry Method of LPI
>>>>>>>> state and SBI HSM or PSCI cpu suspend. Driver should return failure
>>>>>>>> if FFH of LPI state are not ok.
>>>>>>> First of all, I cannot parse this changelog, so I don't know the
>>>>>>> motivation for the change.
>>>>>> Sorry for your confusion.
>>>>>>> Second, if _LPI is ever used on x86, the
>>>>>>> acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() will
>>>>>>> get in the way.
>>>>>> AFAICS, it's also ok if X86 platform use LPI.
>>>>> No, because it returns an error by default as it stands today.
>>>>>
>>>>>>> Why does the evaluation in acpi_processor_setup_cpuidle_dev() not work?
>>>>>> The acpi_processor_ffh_lpi_probe does verify the validity of LPI for ARM
>>>>>> and RISCV.
>>>>>> But the caller of the acpi_processor_setup_cpuidle_dev()don't verify the
>>>>>> return value.
>>>>>> In addition, from the name of acpi_processor_setup_cpuidle_dev(), its
>>>>>> main purpose is to setup cpudile device rather than to verify LPI.
>>>>> That's fair enough.
>>>>>
>>>>> Also, the list of idle states belongs to the cpuidle driver, not to a
>>>>> cpuidle device.
>>>>>
>>>>>> So I move it to a more prominent position and redefine the
>>>>>> acpi_processor_setup_cpuidle_dev to void in patch 9/9.
>>>>>>>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>>>>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>>>>> ---
>>>>>>>>      drivers/acpi/processor_idle.c | 10 ++++++++--
>>>>>>>>      1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>>>>>> index 5684925338b3..b0d6b51ee363 100644
>>>>>>>> --- a/drivers/acpi/processor_idle.c
>>>>>>>> +++ b/drivers/acpi/processor_idle.c
>>>>>>>> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>>>>>>>
>>>>>>>>             dev->cpu = pr->id;
>>>>>>>>             if (pr->flags.has_lpi)
>>>>>>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
>>>>>>>> +               return 0;
>>>>>>>>
>>>>>>>>             return acpi_processor_setup_cpuidle_cx(pr, dev);
>>>>>>>>      }
>>>>>>>> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>>>>>>>>
>>>>>>>>             ret = acpi_processor_get_lpi_info(pr);
>>>>>>>>             if (ret)
>>>>> So I think it would be better to check it here, that is
>>>>>
>>>>> if (!ret) {
>>>>>           ret = acpi_processor_ffh_lpi_probe(pr->id));
>>>>>           if (!ret)
>>>>>                   return 0;
>>>>>
>>>>>           pr_info("CPU%d: FFH LPI state is invalid\n", pr->id);
>>>>>           pr->flags.has_lpi = 0;
>>>>> }
>>>>>
>>>>> return acpi_processor_get_cstate_info(pr);
>>>>>
>>>>> And the default acpi_processor_ffh_lpi_probe() needs to be changed to return 0.
>>>> Sorry, I don't understand why pr->flags.has_lpi is true if
>>>> acpi_processor_ffh_lpi_probe() return failure.
>>> It is set by acpi_processor_get_lpi_info() on success and
>>> acpi_processor_ffh_lpi_probe() does not update it.
>> The acpi_processor_get_lpi_info() will return failure on X86 platform
>> because this function first call acpi_processor_ffh_lpi_probe().
>> And acpi_processor_ffh_lpi_probe return EOPNOTSUPP because X86 platform
>> doesn't implement it.
>> So I think pr->flags.has_lpi is false on X86 plaform.
> On x86 it is 0, but what if acpi_processor_ffh_lpi_probe() fails on arm64, say?
Arm64 supports the acpi_processor_ffh_lpi_probe().
So pr->flags.has_lpi is 1 on success.
>>>> In addition, X86 platform doesn't define acpi_processor_ffh_lpi_probe().
>>>> this function will return EOPNOTSUPP.
>>> Which is exactly why it is a problem.  x86 has no reason to implement
>>> it because FFH always works there.
>> Sorry, I still don't understand why X86 has no reason to implement it.
>> I simply think that X86 doesn't need it.
>> AFAICS, the platform doesn't need to get LPI info if this platform
>> doesn't implement acpi_processor_ffh_lpi_probe().
> Well, that's what is implemented in the current code, but it will need
> to be changed if x86 is ever added and I'd rather avoid cleanups
> making it harder to change.
What you mean is that X86 use LPI?
If X86 also define acpi_processor_ffh_lpi_probe and use LPI, this patch 
is also good to it.

