Return-Path: <linux-acpi+bounces-18111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A475BFD656
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9C562B55
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616DF2D6E5E;
	Wed, 22 Oct 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dErpl+Zk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED43261B8C;
	Wed, 22 Oct 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151217; cv=none; b=g/lq9xeP09Mo2kmqJpPGsF02sey/y+EPrIIe6TrvqnBe3edxiKkH1akk1bEyFQgg9NvtTRFFLIZudDPv8TQj97HBwWJnco0a70I9MViV66GyL/DruQ5YtDNLrPVuqhe3h/2e5i9wCRVdlL/bHOCVgLGttA/39GcnvPPl1UauKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151217; c=relaxed/simple;
	bh=ciJehXq5o5SwrU5CynADR0fWhxlriyXPU9lvhu3zrXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FURb8U89W7tk9i2Jz8rj/KusmRx8X0kb7oOnD+BH+BlqXEoL9IwzuSCo+OF9HXuUF9d+9LJAbxaEhraK+eRIfyPq63+5Jkk2WCyPfraFivUAqa+zK5khosY9ILOlbhlu5mhz7IVYgcbP+DPi2u4c/bRfRL41e/Rw5vsI7cG7v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dErpl+Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20EFC4CEE7;
	Wed, 22 Oct 2025 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761151215;
	bh=ciJehXq5o5SwrU5CynADR0fWhxlriyXPU9lvhu3zrXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dErpl+ZkBRoHcXn+Pddc/PVH5zpXwmDyAtzGwiG4eOKLlr6LG6z6YvF/t9Yq4sO+F
	 9t5LJIBFvxjOqVKS2/e5At80pLtLOFtNJ+Oex20uATqBkhRO/Evf6MlN8flGwb9AsN
	 QqgLQ4YHqkME8uxKQmFYa5xVFIcDklN3sqrVucSRJWFWw628eBv8UyqMqm7s/P1vXY
	 Px0kKOKrjHvbMH58ECW9TFFRYHSNxcOkxBk82MZXThVdVw7KxlEKq0AM9zvnXqR+LE
	 fYXQ1JJill9aC/EJwlKh+yaPoBXkGaTYJD0DlmYuITk6feRxWqG4Sq2WG0gt21H4Mn
	 sz9zjch0zSjxQ==
Message-ID: <552ba489-a876-4ef1-b23f-93cbe8ef6c93@kernel.org>
Date: Wed, 22 Oct 2025 11:40:13 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] Input: Ignore the KEY_POWER events if hibernation is in
 progress
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Cc: kernel@collabora.com
References: <20251018142114.897445-1-usama.anjum@collabora.com>
 <20251018142114.897445-4-usama.anjum@collabora.com>
 <7308c2c0-3881-445d-9771-fad5c3259518@kernel.org>
 <bd186145-c85c-41e3-bdc6-c2aaba4e874f@collabora.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <bd186145-c85c-41e3-bdc6-c2aaba4e874f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/25 11:33 AM, Muhammad Usama Anjum wrote:
> On 10/22/25 2:14 AM, Mario Limonciello (AMD) (kernel.org) wrote:
>>
>>
>> On 10/18/2025 9:21 AM, Muhammad Usama Anjum wrote:
>>> Serio drivers call input_handle_event(). Although the serio drivers have
>>> duplicate events, they have separate code path and call
>>> input_handle_event(). Ignore the KEY_POWER such that this event isn't
>>> sent to the userspace if hibernation is in progress.
>>>
>>> Abort the hibernation by calling pm awake API as well.
>>
>> So do you observe events both from ACPI and from input?  Or was this patch based upon an earlier version of the ACPI patch?
> Yes, I observe events from both ACPI and input driver when power button is pressed.
> AFAIU this happens because of historic reasons of button wired through keyboard
> controller.
> 
> The call to pm_wakeup_dev_event() can be removed. But I've added it for non-ACPI
> devices. Maybe those devices handle only input events through this path. Do you
> think this can be the case?

Well my point was if both are coming through - it's probably better to 
just have pm_wakeup_dev_event() in input and pass the input event from ACPI.

>   >
>> Because it feels like to me perhaps another way to solve this would be for patch 2 to to send the input event and just keep pm_wakeup_dev_event() here instead of both places.
> I was sending input event in patch 2 earlier. I was having difficulty in managing
> so many dependencies in acpi_button_notify(). It suspends the button events. I'll
> reiterate and see if I can achieve this in next series because this would be most
> clean solution.

OK!

> 
>>
>>>
>>> Without this, the event is sent to the userspace and it suspends the
>>> device after hibernation cancellation.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    drivers/input/input.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>>> index a500e1e276c21..0979f18aae6a2 100644
>>> --- a/drivers/input/input.c
>>> +++ b/drivers/input/input.c
>>> @@ -26,6 +26,7 @@
>>>    #include <linux/kstrtox.h>
>>>    #include <linux/mutex.h>
>>>    #include <linux/rcupdate.h>
>>> +#include <linux/suspend.h>
>>>    #include "input-compat.h"
>>>    #include "input-core-private.h"
>>>    #include "input-poller.h"
>>> @@ -362,6 +363,11 @@ void input_handle_event(struct input_dev *dev,
>>>          lockdep_assert_held(&dev->event_lock);
>>>    +    if (code == KEY_POWER && hibernation_in_progress()) {
>>> +        pm_wakeup_dev_event(&dev->dev, 0, true);
>>> +        return;
>>> +    }
>>> +
>>>        disposition = input_get_disposition(dev, type, code, &value);
>>>        if (disposition != INPUT_IGNORE_EVENT) {
>>>            if (type != EV_SYN)
>>
> 
> 


