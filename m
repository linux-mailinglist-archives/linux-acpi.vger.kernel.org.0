Return-Path: <linux-acpi+bounces-19353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10550C9246B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8173AA1C9
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504921FF49;
	Fri, 28 Nov 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QZ+XNFlE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2B9463;
	Fri, 28 Nov 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339455; cv=none; b=DNFju9w4Zd23cON36lWT3+wY2N0Lvb4/cqILosUeLuwcKADDGXhh55v4oax0oy+dJHSVfuZCfD8DHcWDNnMCzPA/HdwUkkagdU72skEM0gOtJCp09hIA5LMpCm6dlT9z1Vt5M3Ybln68ffptO/Qz6kr8dvUUjBFMYw/dq9e9HQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339455; c=relaxed/simple;
	bh=O5oSzGPdB2Ajs9Gy1jijvL+uNWRGLs16tyz8VG67a0U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LQvmcKdhSed1LvKk19BEDnJrceIaswp4fBtD4HEghqA5cTM/Eul0Md38V0NXxzJvLGjzUU3fJaST1l4qaOx2kxD2qT5wiPN+XQoq0nvnK9hGJJ7VDhOlb20q1FSmTDWJGEJKcNkkU2QnwiXvbFQgzCOPpqLykZuZbVxzLr9ywSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QZ+XNFlE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764339443;
	bh=O5oSzGPdB2Ajs9Gy1jijvL+uNWRGLs16tyz8VG67a0U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QZ+XNFlE5p6/hA2IJ6tR5kikcHDARJ7EZnmOhzawLf2p6ed8pOuTGYMIf5AK/KH86
	 jtzU5GIf9GvhYODF4+n8635SqGpxri+j1hAIyKpi0CiOYcoMHYDG9z/0+55QgZtJks
	 oP/D31DwGTDlmRbsJLRZ3FrbxbOQK6+WNqDA6JyCuLCqEsQtKANIdECdgXsYMl1cCA
	 cbqPCzUPF9MhrUM9BtwhfqFmw2RV5YHVX8GGr5KR7YDcGKCT7WRI/TaXrr+ZFRVLZi
	 WUdJvm1ggHXR8ybOfL1IyIEZopGtX1N0nLEWSc9+HZU3inZdfIA651RPQovUf+50h/
	 gfUz9NTZ3nSbQ==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 74BA317E0ECB;
	Fri, 28 Nov 2025 15:17:20 +0100 (CET)
Message-ID: <84c67307-9441-4dd7-9a0d-c448585976b2@collabora.com>
Date: Fri, 28 Nov 2025 19:17:00 +0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, kernel@collabora.com,
 superm1@kernel.org
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is pressed
 during hibernation
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <CAJZ5v0iWCxXSw3fBbesoMEWqGrRL9xrD85pMoW8rPuBBwTayhw@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAJZ5v0iWCxXSw3fBbesoMEWqGrRL9xrD85pMoW8rPuBBwTayhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 11:42 PM, Rafael J. Wysocki wrote:
> On Fri, Nov 7, 2025 at 7:45 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> acpi_pm_wakeup_event() is called from acpi_button_notify() which is
>> called when power button is pressed. The system is worken up from s2idle
>> in this case by setting hard parameter to pm_wakeup_dev_event().
> 
> Right, so presumably you want to set it for hibernation too.
> 
>> Call acpi_pm_wakeup_event() if power button is pressed and hibernation
>> is in progress.
> 
> Well, this is not what the code does after the change.
> 
>> Set the hard parameter such that pm_system_wakeup()
>> gets called which increments pm_abort_suspend counter. The explicit call
>> to acpi_pm_wakeup_event() is necessary as ACPI button device has the
>> wakeup source. Hence call to input_report_key() with input device
>> doesn't call pm_system_wakeup() as it doesn't have wakeup source
>> registered.
>>
>> Hence hibernation would be cancelled as in hibernation path, this counter
>> is checked if it should be aborted.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since RFC:
>> - Use pm_sleep_transition_in_progress()
>> - Update descriptin why explicit call to acpi_pm_wakeup_event() is
>>   necessary
>> ---
>>  drivers/acpi/button.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>> index 3c6dd9b4ba0ad..e4be5c763edaf 100644
>> --- a/drivers/acpi/button.c
>> +++ b/drivers/acpi/button.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/dmi.h>
>>  #include <acpi/button.h>
>> +#include <linux/suspend.h>
>>
>>  #define ACPI_BUTTON_CLASS              "button"
>>  #define ACPI_BUTTON_FILE_STATE         "state"
>> @@ -458,11 +459,16 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>>         acpi_pm_wakeup_event(&device->dev);
> 
> The above is what you want to change, as this already reports the
> event.  Reporting it twice is unnecessary and potentially confusing.
Thanks for mentioning. This will be fixed easily by adding newer
version of acpi_pm_wakeup_event() which takes hard parameter.

> 
>>         button = acpi_driver_data(device);
>> -       if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
>> -               return;
>> -
>>         input = button->input;
>>         keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
>> +       if (event == ACPI_BUTTON_NOTIFY_STATUS && keycode == KEY_POWER &&
>> +           pm_sleep_transition_in_progress()) {
>> +               pm_wakeup_dev_event(&device->dev, 0, true);
>> +               return;
>> +       }
> 
> First, this will affect suspend too.
I'll fix terminologies in entire series.

> 
> Second, this reports an already reported wakeup event.
As mentioned above, I'll update to only 1 call to pm_wakeup_dev_event().> 
> Next, why KEY_POWER only?  Is KEY_SLEEP not expected to wake up?
Yes, this is true. This will be fixed in next version.

> 
> And why event == ACPI_BUTTON_NOTIFY_STATUS?  Isn't this what
> ACPI_BUTTON_NOTIFY_WAKE is for?
While device is hibernating, at that if power button is pressed, 
ACPI_BUTTON_NOTIFY_STATUS event is received. 

ACPI_BUTTON_NOTIFY_WAKE is received when we turn on the device from sleeping state
(suspend) or turned off state (hibernated).

> 
>> +
>> +       if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
>> +               return;
>>
>>         input_report_key(input, keycode, 1);
>>         input_sync(input);
>> --


-- 
---
Thanks,
Usama

