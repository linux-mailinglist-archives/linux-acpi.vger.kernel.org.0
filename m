Return-Path: <linux-acpi+bounces-20375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF448D24629
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A24301B125
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED438BF8B;
	Thu, 15 Jan 2026 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mgBe9qUR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAA1E8826;
	Thu, 15 Jan 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478954; cv=none; b=KHABFOqTUnca55txYDaWTd6Ka9ab3ZUEMiH+xu+35kE4UrCc0d2Xm1J225Je04N7wzgFpdQ2GDUx2nZpQSYawUTMp/9gO7U9jd1NA9QCZ3W0xCuKO91+rZqYQABNbZY3VhR7xtChnaeqRXONhGQ0kM3DDiRrcINmvwNkVqXrM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478954; c=relaxed/simple;
	bh=mTx0+Jo/eMYZINLdveDtQ78g/of2CjpNLGc4mszBF6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UKJDweUejUeLAEKP99NA53Qu/56AGX9Q6klidp33Iu2mpl2cdynr8KaW/bzmviFn7Z1MsO6rIzAYEcaCytX+7gwWQ6pFm0IoJBwLGXGMfs8uewu7O4x3lqq7iFGy9iv6CA3H/KTV3KFtMT6+qFeFKqR/QDq+r/5eq9T62J/d0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mgBe9qUR; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5k6/7v8yV6HrQ/WzTilWAJ1i4IfvxU7m4urWOhxP/B8=;
	b=mgBe9qURj8TI95Hdp/7zCyUq87Kuy64vX5KectKpeZFZ0hC3g2Z9xW523hZ4lOu6Wv8XdiuX5
	flq4yQDl2FMK9PNi0wmdOkdHq70dkAdulYhn0QBtYctb60rO65HWx1ENE+jnIz/syqg7Sv8ZzYP
	vmGwYLlid+7k7OEjEHc3MVI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dsMBj5RZLz1K9Z7;
	Thu, 15 Jan 2026 20:05:49 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EECDA4056C;
	Thu, 15 Jan 2026 20:09:07 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 20:09:07 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 20:09:07 +0800
Message-ID: <2b1a456f-b9e3-4722-84ba-ba4fdd4b2ece@huawei.com>
Date: Thu, 15 Jan 2026 20:09:02 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0j9Mp5AqQwpakVLWDmK10cjOOiKtetfCr2OSSukekdPhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Rafael,

On 1/15/2026 1:27 AM, Rafael J. Wysocki wrote:
> On Tue, Nov 25, 2025 at 7:52 AM Huisong Li <lihuisong@huawei.com> wrote:
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
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 5f86297c8b23..cdf86874a87a 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1252,7 +1252,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>
>>          dev->cpu = pr->id;
>>          if (pr->flags.has_lpi)
>> -               return acpi_processor_ffh_lpi_probe(pr->id);
>> +               return 0;
>>
>>          acpi_processor_setup_cpuidle_cx(pr, dev);
>>          return 0;
>> @@ -1264,7 +1264,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
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
> Please reorder this behind the next patch in the series.
Patch 2/3 depends on this patch.
So I don't know how to reorder this patch.
>

