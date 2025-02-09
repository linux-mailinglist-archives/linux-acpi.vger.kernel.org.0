Return-Path: <linux-acpi+bounces-10954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47FA2DDFE
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Feb 2025 14:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1C61647D6
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Feb 2025 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F61DCB24;
	Sun,  9 Feb 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb6KVJpE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4A1CCB40;
	Sun,  9 Feb 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106895; cv=none; b=lTdJqDjbytH4sKhvGOuipoEZRbOQ0U6M6kIpQB9m8y7x6Hp2n2rVTPOFX9frrpJ6aQkhXX1pHIBMM03r4tXym7v/rFe0k4RKaKVL5ClrIiCnsp0U0FnnfIaIZDzDRBxFT8ZApXQ0dSBJ1bLgqVLnlnAXBD/shNdvMYiaptwuL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106895; c=relaxed/simple;
	bh=m9ABgq92X6dt+i15/YVnew19GZmmZSD0DqPt/PUyE7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aqp1IfUfQDUvMpRpyNp1mixm3VCeoG+tUWr1xxdVFyVujMiRLEEes5UJ0QFzdHctNV3a9dAeIYac88poyCOUChmbZ1HcCPEFPs6LYcJDnsdPtrwoW41ym8RcWaZoq35SgrXgMvUn3PgPLg5lN63EAGyW5JhqgSZh1/D5+zJK+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb6KVJpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A72C4CEDD;
	Sun,  9 Feb 2025 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739106894;
	bh=m9ABgq92X6dt+i15/YVnew19GZmmZSD0DqPt/PUyE7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tb6KVJpEqU2m36GAjeaDrwHn+RjFGRv76tWjXcTynm8Hb4Urpisc1GtMf4N9w4HMZ
	 ARylDgU+f/+qiMlVm14TN8hxaGUXe+/C/yNsvr9J8vU/BYoFbB1k7fJ9c95aY7k73d
	 TAFwsn/JX0PQVIYo6YYDDPXizvYJ+tIxbeSrGofmECxsfKxVcff60LlKDqupr3kQAR
	 BZI/mClOeSsHUPQ/ahfA/c7xaNR1LjyQzucV6oAk9p0HBP0oYr50R8UPKKD3+O9rNt
	 Erj0DrIgK6A4W9LZ9ZLDaabMdGVUL5Tehc8O0+OxXD/xnYFb9+v4pEoBgFEUZxyZm+
	 WCVbkczi0ummQ==
Message-ID: <4e6cc95f-90dd-4f55-bb53-50de7d280d62@kernel.org>
Date: Sun, 9 Feb 2025 07:14:52 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ACPI: battery: Wake system on AC plug or unplug in
 over s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250208162210.3929473-1-superm1@kernel.org>
 <20250208162210.3929473-5-superm1@kernel.org>
 <CAJZ5v0j4+8nqQRtcAihpVgOHWUPE54nTWienCpFk1U7easVPnA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0j4+8nqQRtcAihpVgOHWUPE54nTWienCpFk1U7easVPnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/8/25 11:59, Rafael J. Wysocki wrote:
> On Sat, Feb 8, 2025 at 5:22 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> On Windows the OS will wake up when plugged or unplugged from AC adapter.
>> Depending upon whether the system was plugged in or unplugged will
>> determine whether the "display turns on".  If there is no user activity
>> for some time then it goes back to sleep.
>>
>> In Linux plugging or unplugging an adapter will wake the SoC from HW
>> sleep but then the Linux kernel puts it right back into HW sleep
>> immediately unless there is another interrupt active (such as a PME or
>> GPIO).
>>
>> To get closer to the Windows behavior, record the state of the battery
>> when going into suspend and compare it when updating battery status
>> during the s2idle loop. If it's changed, wake the system.
>>
>> This can be restored to previous behavior by disabling the ACPI battery
>> device `power/wakeup` sysfs file.
> 
> Why is this desirable?
> 
> What if the AC is connected to a suspended laptop when the lid is
> still closed?  Is it really a good idea to resume it then?

Yes; that's the exact situation I wanted this to work.  I have a dock 
connected to some monitors, power supply, keyboard, and mouse.  I want 
the machine to wake up when it's connected to the dock but still closed.

That's how Windows works at least.

> 
> Frankly, I'd prefer the existing behavior to be still the default.

Since this is hooking into the existing wakeups that can happen for 
battery I guess that there isn't a good way to configure one but not the 
other.

Would it be better to do something similar in the ACPI power supply device?

> 
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#environmental-context-changes-1
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/battery.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 72c8a509695e6..91f79927cc720 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -125,6 +125,7 @@ struct acpi_battery {
>>          int state;
>>          int power_unit;
>>          int capacity_suspend;
>> +       int suspend_state;
>>          unsigned long flags;
>>   };
>>
>> @@ -1012,6 +1013,12 @@ static inline bool acpi_battery_should_wake(struct acpi_battery *battery)
>>                  return true;
>>          }
>>
>> +       if (battery->state != battery->suspend_state) {
>> +               pm_pr_dbg("Waking due to battery state changed from 0x%x to 0x%x",
>> +                         battery->suspend_state, battery->state);
>> +               return true;
>> +       }
>> +
>>          return false;
>>   }
>>
>> @@ -1313,6 +1320,7 @@ static int acpi_battery_suspend(struct device *dev)
>>                  return -EINVAL;
>>
>>          battery->capacity_suspend = battery->capacity_now;
>> +       battery->suspend_state = battery->state;
>>
>>          return 0;
>>   }
>> --
>> 2.43.0
>>
>>


