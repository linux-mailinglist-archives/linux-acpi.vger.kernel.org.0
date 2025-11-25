Return-Path: <linux-acpi+bounces-19248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5FDC844EB
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D38BE4E080E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2372ECD14;
	Tue, 25 Nov 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bb9QSvs3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72C2E9ECA;
	Tue, 25 Nov 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064449; cv=none; b=WFGXFqUa7okNO0YBvcRH0U2OKSQtmPK8GglDVmEhK9/+uI75kIxHNfs5Xwsp/9j2yq374bbC08hvgwDSKZ8ur2RMPl97lz9gQb0xppJm6o6undHxdW5Omyync5Ij8U/RI1bf4AXs4TaTk6Mu2jtSmBPtspRSVsuEI1QB8A2ozzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064449; c=relaxed/simple;
	bh=rr34/a1ie3cyaKkr8XjenTC8kZoD9Dm/nJWu3Wq5z4s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r4XjYWzOSiOmsbt9K4iRj3WdreW1xSzZ+2lWMUBsqUdSCWSM2YtY4duVsJAaaa2823lYVvFPrecYZfu7DcSbDART5NleFxHWp0hHWNIH24ldRam2GhGGx4HRTyvOMIah+ZISUw86l23g3wxGi8bHqLgu0ewQXdW09QHmnqa+Lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bb9QSvs3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764064439;
	bh=rr34/a1ie3cyaKkr8XjenTC8kZoD9Dm/nJWu3Wq5z4s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bb9QSvs30CKZp/52Diiij5ClyF1qlRUc1UM+AWHK7eAQ27bgB2juwHPge5WFHpVr1
	 CVCDDZxatZLCqvlIt8Dr4GDa4s7vJrRUtjuJYgr22G0hdZCb21EgXC8PSHUkwwnGML
	 fRuKmxtoKKyPG4tDGtYOTFeX7etAx83m6uk8fP1ejb6VFKvl9MQEJqZ2OiVqsCmESn
	 8JPW7NNkBIfx2t1S9QJtdIhNM9tiQ17qgo9Zd6bfGCErtsi+nJ2V3OniSQUSfoymyZ
	 UEzrbdyboMkml7qZy0Wqwg7YT0/cUmdn/kSlXaqyaKTHZyT5dnFWrhgvVt/6ZoRTjZ
	 sMZb0HJ8lBfkg==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB1B317E0EDB;
	Tue, 25 Nov 2025 10:53:55 +0100 (CET)
Message-ID: <b71b3e35-fc76-4397-9d60-20778685e37c@collabora.com>
Date: Tue, 25 Nov 2025 14:53:40 +0500
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
Subject: Re: [PATCH 4/4] PM: sleep: clear pm_abort_suspend at suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-5-usama.anjum@collabora.com>
 <CAJZ5v0iucMXFkKuRxtAUyAqW11NHHGVuYnjJNbroeMgJoGY1kw@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAJZ5v0iucMXFkKuRxtAUyAqW11NHHGVuYnjJNbroeMgJoGY1kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

Thank you for reviewing.

On 11/24/25 11:54 PM, Rafael J. Wysocki wrote:
> On Fri, Nov 7, 2025 at 7:45 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Clear pm_abort_suspend counter in case a wakeup is detected during
>> hibernation process. If this counter isn't reset, it'll affect the
>> next hibernation cycle and next time hibernation will not happen as
>> pm_abort_suspend is still positive.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  drivers/base/power/main.c | 2 ++
>>  kernel/cpu.c              | 1 +
>>  kernel/power/hibernate.c  | 5 ++++-
>>  kernel/power/process.c    | 1 +
>>  4 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 5760abb25b591..84e76f8df1e02 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1642,6 +1642,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
>>                 goto Complete;
>>
>>         if (pm_wakeup_pending()) {
>> +               pm_wakeup_clear(0);
>>                 WRITE_ONCE(async_error, -EBUSY);
>>                 goto Complete;
>>         }
>> @@ -1887,6 +1888,7 @@ static void device_suspend(struct device *dev, pm_message_t state, bool async)
>>
>>         if (pm_wakeup_pending()) {
>>                 dev->power.direct_complete = false;
>> +               pm_wakeup_clear(0);
>>                 WRITE_ONCE(async_error, -EBUSY);
>>                 goto Complete;
>>         }
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index db9f6c539b28c..74c9f6b4947dd 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1921,6 +1921,7 @@ int freeze_secondary_cpus(int primary)
>>
>>                 if (pm_wakeup_pending()) {
>>                         pr_info("Wakeup pending. Abort CPU freeze\n");
>> +                       pm_wakeup_clear(0);
>>                         error = -EBUSY;
>>                         break;
>>                 }
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index e15907f28c4cd..1f6b60df45d34 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -349,8 +349,10 @@ static int create_image(int platform_mode)
>>                 goto Enable_irqs;
>>         }
>>
>> -       if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
>> +       if (hibernation_test(TEST_CORE) || pm_wakeup_pending()) {
>> +               pm_wakeup_clear(0);
>>                 goto Power_up;
>> +       }
>>
>>         in_suspend = 1;
>>         save_processor_state();
>> @@ -660,6 +662,7 @@ int hibernation_platform_enter(void)
>>                 goto Enable_irqs;
>>
>>         if (pm_wakeup_pending()) {
>> +               pm_wakeup_clear(0);
>>                 error = -EAGAIN;
>>                 goto Power_up;
>>         }
>> diff --git a/kernel/power/process.c b/kernel/power/process.c
>> index dc0dfc349f22b..e935b27a04ae0 100644
>> --- a/kernel/power/process.c
>> +++ b/kernel/power/process.c
>> @@ -67,6 +67,7 @@ static int try_to_freeze_tasks(bool user_only)
>>                         break;
>>
>>                 if (pm_wakeup_pending()) {
>> +                       pm_wakeup_clear(0);
>>                         wakeup = true;
>>                         break;
>>                 }
>> --
> 
> I don't think pm_wakeup_clear() needs to be called in so many places.
> 
> Any why isn't it sufficient to call it in freeze_processes()?  For
> suspend, it is sufficient, so what's different about hibernation in
> that respect?

It seems this patch was written by me when [1] was added which removed the
unconditional call pm_wakeup_clear(0) from freeze_processes(). It was later
reverted [2].

I've removed this patch and tested again to find out:
- try_to_freeze_tasks() gets called from freeze_process() after
  unconditional clearing of pm_wakeup. So pm_wakeup doesn't get cleared
  until next hibernation or any other similar operation. So for hibernation
  cancellation this patch isn't required. I'll drop it.

But shouldn't this wakeup event be consumed without waiting for next hibernation
(or similar operation to happen)?

[1] 56a232d93cea ("PM: sleep: Make pm_wakeup_clear() call more clear") - Aug 20
[2] 79816d4b9e9b ("Revert "PM: sleep: Make pm_wakeup_clear() call more clear"") - Oct 22

---
Thanks,
Usama

