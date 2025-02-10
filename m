Return-Path: <linux-acpi+bounces-10978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38313A2FBED
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 22:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977F71884F73
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C11C07D9;
	Mon, 10 Feb 2025 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9l0mpnQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44021189B8C;
	Mon, 10 Feb 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222684; cv=none; b=qdFmlZzujExMwxUvmqwQISyUG9lUxUI3uNqefZ1WBz7ng6kk/y66Ab9JhDX84aUkyo0Vxk4UlBdSHbEyCz49a8YIQ7kOKxJ12JKQTkaYXBMDIscvFVJgOf+jUG5xT8EmWdO/gYXP7OAtpVKL2LaD/PaoVt8omD0k04bcHRyWnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222684; c=relaxed/simple;
	bh=IiZI6Y+jSHKNVuJcmPYi5fkyq5b2zOSr7oCwF4V/zF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG3vT2kCCu4z1taZQ9QsU3PUyKR4jgbHnYlqb+FesUtDRwlC6OQoZznKk+icAYPnblm5NWgxeHvnKsZLksi64X1Ki2CKzti2qDco/d4bKLp2Um0/UqCnItxf+1SvemDdgwIShK97+nvEURuFhIUpJ+x3lashU+nHrCDNO/XgS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9l0mpnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131D0C4CED1;
	Mon, 10 Feb 2025 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739222683;
	bh=IiZI6Y+jSHKNVuJcmPYi5fkyq5b2zOSr7oCwF4V/zF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t9l0mpnQDIGjED4MiXFbdwmG6tEhvX5Jm6TUzQZ5rUg8c5JtM+25z/YPfVt7r/ASq
	 wB8DyPexaTzgoCPG5xg8rNL2ltuPvVbAcFmoKl+JI/mYpSVUUnu2e4xh9GC9KF2SFI
	 Qnc0vcHSPaQDbxc8bBTDzuEtJryBQQvsgIxGcqUkD1GdCPDyJvQtKaAl96KjSfstGD
	 SzzhKfCwqeY/XYpq56Klpsb3Vbuitk2sblF4Y4ti0CEaLajv9OKY3QQMBIYu+eOK0b
	 REExXNT8ItbKWsfCNUWy2KVmbBz6w73c3D5VZtz4Zqs3x5qEkYBcb689LTPSclUH9k
	 Y0uX5hhO94tgg==
Message-ID: <c8527274-fd84-4745-b996-d1c66694aba4@kernel.org>
Date: Mon, 10 Feb 2025 15:24:42 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ACPI: battery: Save and report battery capacity over
 suspend
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250208162210.3929473-1-superm1@kernel.org>
 <20250208162210.3929473-3-superm1@kernel.org>
 <bzltxadthnef5c4xaidfcjuq7tt2h23znn76povptoxbb2iax6@xvuzfqbtomzb>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <bzltxadthnef5c4xaidfcjuq7tt2h23znn76povptoxbb2iax6@xvuzfqbtomzb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/2025 09:23, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Feb 08, 2025 at 10:22:08AM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> To find out if a device is malfunctioning over suspend it's often
>> interesting to know how much battery was lost.
>>
>> At the start of the suspend cycle cache the amount of battery.
>> During resume, read the battery level again and if the battery
>> has decreased report the difference to the suspend stats using
>> pm_report_sleep_energy()
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> This code assumes, that there is only a single battery, but there
> can be more than one battery supplying the system. For example
> Thinkpads used to have an internal battery and a user swappable
> one.
> 
> Also it seems in almost all cases debugging this from userspace
> by dropping a script in /usr/lib/systemd/system-sleep is good
> enough, so I wonder if extending the kernel ABI makes sense at
> all.
> 

Thanks for looking.  I think it could be extended to add all the 
batteries up and collectively look at how much each went down.

But that's a good point it's pretty easy to do the same thing from 
userspace.

> Greetings,
> 
> -- Sebastian
> 
>>   drivers/acpi/battery.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 6760330a8af55..f21bfd02a26d1 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -124,6 +124,7 @@ struct acpi_battery {
>>   	char oem_info[MAX_STRING_LENGTH];
>>   	int state;
>>   	int power_unit;
>> +	int capacity_suspend;
>>   	unsigned long flags;
>>   };
>>   
>> @@ -1011,9 +1012,6 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>>   		return 0;
>>   	}
>>   
>> -	if (resume)
>> -		return 0;
>> -
>>   	if (!battery->update_time) {
>>   		result = acpi_battery_get_info(battery);
>>   		if (result)
>> @@ -1032,6 +1030,14 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>>   			return result;
>>   	}
>>   
>> +	if (resume) {
>> +		if (battery->capacity_suspend > battery->capacity_now)
>> +			pm_report_sleep_energy(battery->capacity_suspend - battery->capacity_now);
>> +		else
>> +			pm_report_sleep_energy(0);
>> +		return 0;
>> +	}
>> +
>>   	/*
>>   	 * Wakeup the system if battery is critical low
>>   	 * or lower than the alarm level
>> @@ -1285,6 +1291,22 @@ static void acpi_battery_remove(struct acpi_device *device)
>>   }
>>   
>>   /* this is needed to learn about changes made in suspended state */
>> +static int acpi_battery_suspend(struct device *dev)
>> +{
>> +	struct acpi_battery *battery;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	battery = acpi_driver_data(to_acpi_device(dev));
>> +	if (!battery)
>> +		return -EINVAL;
>> +
>> +	battery->capacity_suspend = battery->capacity_now;
>> +
>> +	return 0;
>> +}
>> +
>>   static int acpi_battery_resume(struct device *dev)
>>   {
>>   	struct acpi_battery *battery;
>> @@ -1301,7 +1323,7 @@ static int acpi_battery_resume(struct device *dev)
>>   	return 0;
>>   }
>>   
>> -static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
>> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, acpi_battery_suspend, acpi_battery_resume);
>>   
>>   static struct acpi_driver acpi_battery_driver = {
>>   	.name = "battery",
>> -- 
>> 2.43.0
>>
>>


