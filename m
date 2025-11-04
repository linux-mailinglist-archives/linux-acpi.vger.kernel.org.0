Return-Path: <linux-acpi+bounces-18483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B445C30556
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 10:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A912C3ADEAF
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892E2D0602;
	Tue,  4 Nov 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="f4Pv1rm9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C231F3B8A;
	Tue,  4 Nov 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249083; cv=none; b=eIDSfggzSRxUEMSnrS9YRFCmIsMFvofaKUHW6K1IUMLXyEzd+hj6Pk5st7tNmsZJns0C6wOB9zejrL2XkWDbZheMGHiNk+CRPN1Qf/7q4qydVQm6qV2gdatHosPmaxzO/wS/wrYX2lGpTNvGkEuMBD7rLMjRmSfUtiScu4AkVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249083; c=relaxed/simple;
	bh=r3tQ0Szv+FMlbIxY4VqNBVRmUYxhaJhTcGifkgewxFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q5s1BBct4a96OlHeF13e2Ou30WforBQ6KZ9G7CkRLuEAolwRuBDowDttoBkKGnXQ18VKijukU7FMecqws0L0m/OGXqyVBMiHODbNeg0FiHH0P8GbyDOfAGB82KBdGBuQAIIs3XYDLVF417NAv8zXB5NK7ZSDVQyEstV8FW3/N/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=f4Pv1rm9; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BPoZviuvXSS0vcZ/zKWMYvh/zgUUKs3Cv2NlUfmw2jM=;
	b=f4Pv1rm9FVwpf16ppTHIVR2fQ2ygOrxsGoMItnYnMY4a0deLzM4nM/Maxz3WMOy6JEOVCeV40
	SGVtFpcxX+JF712Xlb2W3Ln4YX/WPZ0Hvx7WuHEldpCxPiMFdv9wwcQ+lfqVjzRApNzPNIAmTEX
	1z2zxdRISe6oJp3+l+fKyxk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d13Hc4JQHzpStT;
	Tue,  4 Nov 2025 17:36:28 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 941DC180238;
	Tue,  4 Nov 2025 17:37:57 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 17:37:57 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 17:37:56 +0800
Message-ID: <0029f2b2-4a52-4fd4-a76c-1032868ffbb0@huawei.com>
Date: Tue, 4 Nov 2025 17:37:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] ACPI: processor: idle: Relocate and verify
 acpi_processor_ffh_lpi_probe
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-4-lihuisong@huawei.com>
 <CAJZ5v0gf=eTuY_CoUDSp94Naj3fxjapc_FWYY+nBjX6qvvM_cg@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gf=eTuY_CoUDSp94Naj3fxjapc_FWYY+nBjX6qvvM_cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/11/4 1:56, Rafael J. Wysocki 写道:
> On Mon, Nov 3, 2025 at 9:42 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The platform used LPI need check if the LPI support and the entry
>> method is valid by the acpi_processor_ffh_lpi_probe(). But the return
>> of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
>> isn't verified by any caller.
>>
>> What's more, acpi_processor_get_power_info() is a more logical place for
>> verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev().
>> So move acpi_processor_ffh_lpi_probe() from the latter to the former and
>> verify its return.
>>
>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
> If you want to add this Fixes: tag, please add some information on
> what systems it breaks on and what the symptoms are to the changelog.
Sorry, I didn't specifically construct it.
This patch is just an optimization patch. All right, I will drop this 
Fixes tag.
Thanks for your reminder.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 5213a545fa78..c73df5933691 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1266,7 +1266,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>
>>          dev->cpu = pr->id;
>>          if (pr->flags.has_lpi)
>> -               return acpi_processor_ffh_lpi_probe(pr->id);
>> +               return 0;
>>
>>          return acpi_processor_setup_cpuidle_cx(pr, dev);
>>   }
>> @@ -1277,7 +1277,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>>
>>          ret = acpi_processor_get_lpi_info(pr);
>>          if (ret)
>> -               ret = acpi_processor_get_cstate_info(pr);
>> +               return acpi_processor_get_cstate_info(pr);
>> +
>> +       if (pr->flags.has_lpi) {
>> +               ret = acpi_processor_ffh_lpi_probe(pr->id);
>> +               if (ret)
>> +                       pr_err("Processor FFH LPI state is invalid.\n");
>> +       }
>>
>>          return ret;
>>   }
>> --

