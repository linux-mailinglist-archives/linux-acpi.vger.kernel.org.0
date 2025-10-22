Return-Path: <linux-acpi+bounces-18110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A468EBFD50C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0400D3588A2
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22184246764;
	Wed, 22 Oct 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZYttj0Nl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876B25782D;
	Wed, 22 Oct 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150863; cv=none; b=d/W7rBGTOPSXfyWkwm9OsE8VNdiUxv1ApLXEsHHzlOpDWeg9YtnWhIedhn5FahTUTdirL7P4gnpIlPrBD67gWNBePPcGoIoSQXFUrfTCbg9BZN2SzROQ3/rtyNQf5wO74MlBUO6CGD+BhT2aQlLN/1S1dlq+j+Own5jZObjcC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150863; c=relaxed/simple;
	bh=HAhQ/HsnWHIBcI2BhcqVo/RcuYa+M+SMPj4DaF/UVf8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CXJC/Kqev4V4rZdl3b7RXJrnZsWzQY/6TawTUUvD1lkIS64C8CkyfZyNTwz2Dm14/LN7pR/PEmLC7hyvNuFXBviY2SHvyEORP61aubYZd88eInk2JtfK+seqqRYzBUNDXsgB1IHh5lGQUwfl11CuH2icS+Fj9AWoGInacN6+plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZYttj0Nl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761150859;
	bh=HAhQ/HsnWHIBcI2BhcqVo/RcuYa+M+SMPj4DaF/UVf8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZYttj0NlJDpX9YsaCcv2SCRukiG1G46h9zTQ9F19s+RC6c64e77XCksFYmWI7Udsi
	 pXQmytaGNCOB3eTl7XowGKBPFne+X8fZnpAhHyIsKDSwK8QAkk6rxa3mqT2+izospN
	 owGXaQFe7QKejVZJIzrLfI53qS0XpqErFwFD1L0qJCHo1+KXjWJdeKCv9aKP9AHwZq
	 E3+9DrA1R3QwWoQRKm+9Fl4b9pzn9VyoSZco2xtGyKWJL1tjIoMCiY3iLLdrT5JQpv
	 LVEgZf0ABDCH4gfr8/cxuo8UTmHJZkWwpydRFUsdR/l5Sa0n7iolIAGDhWmtSFvaaD
	 vcFSo87fySJTg==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CAA717E00AC;
	Wed, 22 Oct 2025 18:34:13 +0200 (CEST)
Message-ID: <bd186145-c85c-41e3-bdc6-c2aaba4e874f@collabora.com>
Date: Wed, 22 Oct 2025 21:33:42 +0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com
Subject: Re: [RFC 3/4] Input: Ignore the KEY_POWER events if hibernation is in
 progress
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20251018142114.897445-1-usama.anjum@collabora.com>
 <20251018142114.897445-4-usama.anjum@collabora.com>
 <7308c2c0-3881-445d-9771-fad5c3259518@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <7308c2c0-3881-445d-9771-fad5c3259518@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/25 2:14 AM, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/18/2025 9:21 AM, Muhammad Usama Anjum wrote:
>> Serio drivers call input_handle_event(). Although the serio drivers have
>> duplicate events, they have separate code path and call
>> input_handle_event(). Ignore the KEY_POWER such that this event isn't
>> sent to the userspace if hibernation is in progress.
>>
>> Abort the hibernation by calling pm awake API as well.
> 
> So do you observe events both from ACPI and from input?  Or was this patch based upon an earlier version of the ACPI patch?
Yes, I observe events from both ACPI and input driver when power button is pressed.
AFAIU this happens because of historic reasons of button wired through keyboard
controller.

The call to pm_wakeup_dev_event() can be removed. But I've added it for non-ACPI
devices. Maybe those devices handle only input events through this path. Do you
think this can be the case?
 > 
> Because it feels like to me perhaps another way to solve this would be for patch 2 to to send the input event and just keep pm_wakeup_dev_event() here instead of both places.
I was sending input event in patch 2 earlier. I was having difficulty in managing
so many dependencies in acpi_button_notify(). It suspends the button events. I'll
reiterate and see if I can achieve this in next series because this would be most
clean solution.

> 
>>
>> Without this, the event is sent to the userspace and it suspends the
>> device after hibernation cancellation.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   drivers/input/input.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index a500e1e276c21..0979f18aae6a2 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/kstrtox.h>
>>   #include <linux/mutex.h>
>>   #include <linux/rcupdate.h>
>> +#include <linux/suspend.h>
>>   #include "input-compat.h"
>>   #include "input-core-private.h"
>>   #include "input-poller.h"
>> @@ -362,6 +363,11 @@ void input_handle_event(struct input_dev *dev,
>>         lockdep_assert_held(&dev->event_lock);
>>   +    if (code == KEY_POWER && hibernation_in_progress()) {
>> +        pm_wakeup_dev_event(&dev->dev, 0, true);
>> +        return;
>> +    }
>> +
>>       disposition = input_get_disposition(dev, type, code, &value);
>>       if (disposition != INPUT_IGNORE_EVENT) {
>>           if (type != EV_SYN)
> 


-- 
---
Thanks,
Usama

