Return-Path: <linux-acpi+bounces-19251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CFC8474A
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 11:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4F5D34CD92
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9062F12BD;
	Tue, 25 Nov 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dIzMeFyv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143B2F12DF;
	Tue, 25 Nov 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066186; cv=none; b=PyKJhI4cupM216sn1bA29m71LhzfKTnKrOKVj8es7Xwk3+XFlVKSIa4HmfjjLkPmKp2IHSiIps9ZJnW6VTJKPU1Bs4e/2xaFBsgF2JANpH2EgM/XAaS2AWDbpR3NeNCjije85IiSvnaJPI4oDmmZrcQ3QI+6LKTovkhwLtvE9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066186; c=relaxed/simple;
	bh=XFXNYnESsOv2zDGk5WoMfbrMLyrnZBpDxDyo1KN5Lm0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RuGNwYCf+o17L9JRlr7YjCHC9bR5+Pa2EA8iQsqOVSAkiTpA2QVX3aPvAVLDpPBw2yYbwhYmPlt44zEQean0stDn3ufaEnfASNwe6KJWbhZARrz1bh7s8KjmHugfrWXOitINoEWC2NCtyPbEdSR4GwKD5QO6RluSKv+c/im2nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dIzMeFyv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764066181;
	bh=XFXNYnESsOv2zDGk5WoMfbrMLyrnZBpDxDyo1KN5Lm0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dIzMeFyvLVbQeYz+Nx5ZNpub3H0/pWzFlcRqd0HkK98Mh8nJriuUbXp+wJ0+MktJE
	 SSSMQ/YgTj13o6oxi2aPKmCuBeB52z5tVRFCDqZRbdJ32VDNKfFiMKltFwl9ImdzPS
	 Q8loQ/EWvbJva8UG3xFst27zyyLixfW+fSStTJ5nSsXQm4D0FMmfmu/Z8Zteotd2B1
	 98xGpvbroijTl4yzuYNxGjLUVt//zwDaEtUPnceFtNJC/AC+ItT7vHtfaaMuAys95i
	 3t+pk1I5Z3kwI0ixyv4APYDoJbCa9M8o4A3OhOVKnO+qoOEtD/JK46Te4Mu7jdcCfF
	 k+5HiK6mJg3SQ==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8EBBA17E005F;
	Tue, 25 Nov 2025 11:22:58 +0100 (CET)
Message-ID: <6f1f3210-47c6-4c00-8fb9-35f48bae2581@collabora.com>
Date: Tue, 25 Nov 2025 15:22:28 +0500
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
Subject: Re: [PATCH 3/4] Input: Ignore the KEY_POWER events if hibernation is
 in progress
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-4-usama.anjum@collabora.com>
 <CAJZ5v0gtGjE-rSwM4Kom4cDEhp3eSOkLCmbLwrt_9u9a7VP6zQ@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAJZ5v0gtGjE-rSwM4Kom4cDEhp3eSOkLCmbLwrt_9u9a7VP6zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 11:50 PM, Rafael J. Wysocki wrote:
> On Fri, Nov 7, 2025 at 7:45 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Input (Serio) drivers call input_handle_event(). Although the serio
>> drivers have duplicate events, they have separate code path and call
>> input_handle_event(). Ignore the KEY_POWER such that this event isn't
>> sent to the userspace if hibernation is in progress.
> 
> Your change affects suspend too.
> 
> Also, what's the goal you want to achieve?
Two goals:
* Don't send event to userspace
* Set pm_wakeup for hibernation cancellation for non-acpi devices (This api
  call should be tested on non-acpi devices such as arm board to see if it
  helps. I don't have an arm board in hand)

> 
>> Abort the hibernation by calling pm_wakeup_dev_event(). In case of serio,
>> doesn't have wakeup source registered, this call doesn't do anything.
>> But there may be other input drivers which will require this.
>>
>> Without this, the event is sent to the userspace and it suspends the
>> device after hibernation cancellation.
> 
> I think that's because user space handles it this way, isn't it?
Yes, it depends on how userspace handles such events. There are different settings
configured for systemd-logind when power event is received. The purpose is to consume
this event to cancel the hibernation without letting userspace know about it.

Thinking more about it, I wasn't sure if all of such events are compulsory to be
delivered to userspace. But then I found an example: In acpi_button_notify(), all
such events are not sent to userspace if button is suspended. So it seems okay to
not send this as well and just consume in the kernel.

> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since RFC:
>> - Use pm_sleep_transition_in_progress()
>> - Update description
>> ---
>>  drivers/input/input.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index a500e1e276c21..7939bd9e47668 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/kstrtox.h>
>>  #include <linux/mutex.h>
>>  #include <linux/rcupdate.h>
>> +#include <linux/suspend.h>
>>  #include "input-compat.h"
>>  #include "input-core-private.h"
>>  #include "input-poller.h"
>> @@ -362,6 +363,11 @@ void input_handle_event(struct input_dev *dev,
>>
>>         lockdep_assert_held(&dev->event_lock);
>>
>> +       if (code == KEY_POWER && pm_sleep_transition_in_progress()) {
>> +               pm_wakeup_dev_event(&dev->dev, 0, true);
>> +               return;
>> +       }
>> +
>>         disposition = input_get_disposition(dev, type, code, &value);
>>         if (disposition != INPUT_IGNORE_EVENT) {
>>                 if (type != EV_SYN)
>> --


-- 
---
Thanks,
Usama

