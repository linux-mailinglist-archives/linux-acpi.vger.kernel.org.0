Return-Path: <linux-acpi+bounces-18140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D54C006AE
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A5654E51B7
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C72F067E;
	Thu, 23 Oct 2025 10:17:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD62DC770;
	Thu, 23 Oct 2025 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214631; cv=none; b=U3MOyMI2YLzSzwPG5AyjOycM1Pj3XPHAHt+QrM9LX3yDy4omxMfitV+Cdo1FO/7iUFobJrJFrztD+fPWcXwHsiwysXtCPjGapWIVm53jIzF9BSMHn9xwvXNENxeP9dcmWyJv5Ol81JR16T+RHw7ZYRikMejo3wyWaR5HFl2rZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214631; c=relaxed/simple;
	bh=JAq8jW6ujVEy5nEmF8TQ1AzqT5SLo9CcH9tLA1eLQEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sds+n8KYNQISl+5JDUD1IR4gJGB2ZA8v6cENUuvXqnKHGgwf/uDMCzkAmcIEGEXihfHCh9k8GY1r7ourntqRSOdNq66P/IU7JG2x7XdvVa+eCx3fNs75iVCub3GjPYUTCQo80JFPltv+N6UL9MIJTGlU2+dMLTNaTNGb9nqK6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cshl31tdsznfVN;
	Thu, 23 Oct 2025 18:16:15 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BB8618048F;
	Thu, 23 Oct 2025 18:17:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 18:17:03 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:17:02 +0800
Message-ID: <92b1b431-9855-43fb-8bb3-801649064438@huawei.com>
Date: Thu, 23 Oct 2025 18:17:01 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/22 3:42, Rafael J. Wysocki 写道:
> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>> Both ARM64 and RISCV architecture would validate Entry Method of LPI
>> state and SBI HSM or PSCI cpu suspend. Driver should return failure
>> if FFH of LPI state are not ok.
> First of all, I cannot parse this changelog, so I don't know the
> motivation for the change.
Sorry for your confusion.
> Second, if _LPI is ever used on x86, the
> acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() will
> get in the way.
AFAICS, it's also ok if X86 platform use LPI.
>
> Why does the evaluation in acpi_processor_setup_cpuidle_dev() not work?
The acpi_processor_ffh_lpi_probe does verify the validity of LPI for ARM 
and RISCV.
But the caller of the acpi_processor_setup_cpuidle_dev()don't verify the 
return value.
In addition, from the name of acpi_processor_setup_cpuidle_dev(), its 
main purpose is to setup cpudile device rather than to verify LPI.
So I move it to a more prominent position and redefine the 
acpi_processor_setup_cpuidle_dev to void in patch 9/9.
>
>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 5684925338b3..b0d6b51ee363 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>
>>          dev->cpu = pr->id;
>>          if (pr->flags.has_lpi)
>> -               return acpi_processor_ffh_lpi_probe(pr->id);
>> +               return 0;
>>
>>          return acpi_processor_setup_cpuidle_cx(pr, dev);
>>   }
>> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
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
>> 2.33.0
>>

