Return-Path: <linux-acpi+bounces-18484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDCBC305BF
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 10:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF7014E233D
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E11313536;
	Tue,  4 Nov 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Ia0NjXDI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371331329E;
	Tue,  4 Nov 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250094; cv=none; b=URr9jKImNydOxbSw3pijTTqjZNRbokW81NI+G+GRk7xk9l/5Ig727RlXr0qCGYuZQDsrD3iYBdzo8WPQc07hxLSFI510u22tG44gDTDaG6n8qztisHPOdCHJkbigvEyMqMmoY6FhTan/JBxZgjyyuM/kWAyc4yyOYpj4QKnlo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250094; c=relaxed/simple;
	bh=sX9UKkyVb3tpBfMOyt/mu+XM2AsdErAzW+FC4GZCdYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PIwHfljrJwUZiZfrwDrV83HtxKru5XSoNK12/HnTbjWJeCIzzSdZFQdNYB3fSVMXJa2ZsxUNL8LU33PX92/gcA/3oz+PZWZaHaUUP8Y8mhjscxc37mrqOwMgBg8uifbt9GfFdc6aOdzUE2mLF514VTBJ8TNZFo9jLgKYL7k9LVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Ia0NjXDI; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FgMw8XkOnRx9u46oeD+eQsnFPaZfFi2PJjezX5apYEM=;
	b=Ia0NjXDI4MO2f/uD9fNbmqz2QiR2Nh4oo34Pm3WXGNUGTwD4evrQQqqeECy3Xc93ZjKw7hu/d
	wu8d2vSozoHQu2wlFQTaX1jM9HGn8erW0bN/omZ4n8AW6DDS0Dxj7mEZkm3bZz3/0ZzWFFxsBSd
	iVHI69xvPAeYezB+WK8lofc=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d13g22fXhzpStT;
	Tue,  4 Nov 2025 17:53:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E0E6180080;
	Tue,  4 Nov 2025 17:54:47 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 17:54:47 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 17:54:46 +0800
Message-ID: <339a202a-86aa-46f5-b45d-aea653f3e382@huawei.com>
Date: Tue, 4 Nov 2025 17:54:45 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] ACPI: processor: idle: Disable ACPI idle if get
 power information failed in power notify
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-5-lihuisong@huawei.com>
 <CAJZ5v0idhxfOa8_Zp4Z_j5Rqh4GW4JsBpGT_hT=v=NgcEZRb+g@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0idhxfOa8_Zp4Z_j5Rqh4GW4JsBpGT_hT=v=NgcEZRb+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/11/4 2:09, Rafael J. Wysocki 写道:
> On Mon, Nov 3, 2025 at 9:42 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The old states may not be usable any more if get power information
>> failed in power notify. The ACPI idle should be disabled entirely.
> How does it actually disable anything?  It only changes the
> acpi_processor_power_state_has_changed() return value AFAICS, but that
> return value isn't checked.
The acpi_processor_power_state_has_changed() will disable all cpuidle 
device first.
AFAICS, the disabled cpuidle_device would not do cpuidle, please see 
cpuidle_not_available() and cpuidle_idle_call().
It's enough for this?
>
>> Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating the C-states")
> So how does it fix anything?
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index c73df5933691..4627b00257e6 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1317,6 +1317,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>          int cpu;
>>          struct acpi_processor *_pr;
>>          struct cpuidle_device *dev;
>> +       int ret = 0;
>>
>>          if (disabled_by_idle_boot_param())
>>                  return 0;
>> @@ -1345,8 +1346,18 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>                          cpuidle_disable_device(dev);
>>                  }
>>
>> -               /* Populate Updated C-state information */
>> -               acpi_processor_get_power_info(pr);
>> +               /*
>> +                * Populate Updated C-state information
>> +                * The same idle state is used for all CPUs, cpuidle of all CPUs
>> +                * should be disabled.
>> +                */
>> +               ret = acpi_processor_get_power_info(pr);
>> +               if (ret) {
>> +                       pr_err("Get processor-%u power information failed, disable cpuidle of all CPUs\n",
>> +                              pr->id);
> pr_info() at most, preferably pr_debug() or maybe pr_info_once().
Ack, pr_info_once is good to me.
>
>> +                       goto release_lock;
> "unlock" would be a better name.
Ack
>
>> +               }
>> +
>>                  acpi_processor_setup_cpuidle_states(pr);
>>
>>                  /* Enable all cpuidle devices */
>> @@ -1354,18 +1365,19 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>                          _pr = per_cpu(processors, cpu);
>>                          if (!_pr || !_pr->flags.power_setup_done)
>>                                  continue;
>> -                       acpi_processor_get_power_info(_pr);
>> -                       if (_pr->flags.power) {
>> +                       ret = acpi_processor_get_power_info(_pr);
> This does not need to be called if _pr->flags.power is unset.  Why are
> you changing this?

_pr->flags.power is set in acpi_processor_get_power_info().
Ok, I know what you mean.
_pr->flags.power is unset if acpi_processor_get_power_info fail to execute.
But it may be the old value. So here should be necessary.

>
>> +                       if (!ret && _pr->flags.power) {
>>                                  dev = per_cpu(acpi_cpuidle_device, cpu);
>>                                  acpi_processor_setup_cpuidle_dev(_pr, dev);
>>                                  cpuidle_enable_device(dev);
>>                          }
> If it succeeds for the next CPU, the return value will be still 0, won't it?
I think it is 0.
Do we need to do something for it, like, adding debug log?
>
>>                  }
>> +release_lock:
>>                  cpuidle_resume_and_unlock();
>>                  cpus_read_unlock();
>>          }
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   void acpi_processor_register_idle_driver(void)
>> --

