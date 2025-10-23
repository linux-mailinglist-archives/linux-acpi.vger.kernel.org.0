Return-Path: <linux-acpi+bounces-18141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88542C006F6
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4706F3ABAF6
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F44307AC5;
	Thu, 23 Oct 2025 10:19:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADD305976;
	Thu, 23 Oct 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214790; cv=none; b=Lv8pDbjF23IanhukTYdN42pf8v7Z9HCe/8XeXjuTaZr0j+Nx8nibLMhxBlyLn1BI6bexCTO2AZwFGubxRSNk2d4GaIKHSeviNjNTr+oUeDj4Irg60YNf5bTlhGt9zkJC2etFWwlBZI/QlCAW0leQHGwuhElUJ8CGHXbJGgklKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214790; c=relaxed/simple;
	bh=4BkSBKzEX9jV9K9sd9sISF9TzT01yQgYZ1Xm0Ub9M7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FQ9kIQ86rx4+ervkUr1y5UsLLInW2sGXaqiavrfSIUnLOq3G4IHzYxwavg/lUpN+onUxhyvIsnJcKl9Y0sUbseqreZkwYnLbB5axKKCIWnNx6tpNW9FibC7F89OH1aMaBlnT+ezBGSKDPclvR/ZoV3qTIAkP3XFLtBgM5oZfCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cshjR6bYkzJsZ2;
	Thu, 23 Oct 2025 18:14:51 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E6FD618048F;
	Thu, 23 Oct 2025 18:19:43 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 18:19:43 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:19:43 +0800
Message-ID: <da38cf78-bd18-49ee-a25d-c4b446cfa2fa@huawei.com>
Date: Thu, 23 Oct 2025 18:19:42 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] ACPI: processor: idle: Remove died codes about the
 verification of cstate count
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-8-lihuisong@huawei.com>
 <CAJZ5v0j4F5fPwhKup768EUdgWfUHXATiK0zuNwK2fJyC2fqy2A@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0j4F5fPwhKup768EUdgWfUHXATiK0zuNwK2fJyC2fqy2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/22 3:51, Rafael J. Wysocki 写道:
> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
>> be called after successfully obtaining the power information. These setup
>> functions have their own main role, but also verify the validity of cstate
>> count.
>>
>> Actually, the acpi_processor_get_power_info_cst() will return failure
>> if the cstate count is zero and acpi_processor_get_power_info() will return
>> failure.
>>
>> So the verification of cstate count in these functions are died code.
> It is useless overhead rather because the conditions checked cannot be true.
Yes.
This patch actually prepares for patch 8/9 and patch 9/9.
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 22 +++++++---------------
>>   1 file changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 92b231f5d514..2d672afc7498 100644
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
>> @@ -1246,7 +1236,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>>          if (pr->flags.has_lpi)
>>                  return acpi_processor_setup_lpi_states(pr);
>>
>> -       return acpi_processor_setup_cstates(pr);
>> +       acpi_processor_setup_cstates(pr);
>> +       return 0;
>>   }
>>
>>   /**
>> @@ -1266,7 +1257,8 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
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
>> 2.33.0
>>

