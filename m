Return-Path: <linux-acpi+bounces-19259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233BC86027
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32ECA4E2190
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A832937D;
	Tue, 25 Nov 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V9ci28Ga"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39B1487E9;
	Tue, 25 Nov 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088913; cv=none; b=F3g4+KQxpe+SedCoU/t5HvtkAGM49od9sUTj5tRljyAfvZ0i+sGQU/IwiVWICof0xehn19bDSNzCkoVX0FWQ6xuHMz/nL3jlmd4gZCF77Lb9Tp6RYA3b/hqexFKaF8t70KzYozFfX3onXvIaWOu/T/nc/a4nY4pdpJEJnH3XkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088913; c=relaxed/simple;
	bh=wwVWQ8qs5FyaFgj2VKw9vuePt2aYfqUPEd7y+BOSRVw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XqeHsPJSU7FWjbDwem2HEX0SMetfZIcJ9OF6IP3q15Cr7fPO0pQsX+7+dpEDVrKQYJSeSGsbFdE4UvqShwr9KNeByt/FbUmK0PeQo8xN6QlGdoi+mSahYTRm54DSIg8BNX9zdHd/nSzJ+9LpTtAxVZdcJIvgaAuE/SPrt9LIAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V9ci28Ga; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764088909;
	bh=wwVWQ8qs5FyaFgj2VKw9vuePt2aYfqUPEd7y+BOSRVw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V9ci28GahN2kkzienIhBTFqRLlnWrbA5eDmQqoK7gOQlGX64ye+RfULR9pQFESuwi
	 qcX4KCMZ4yZFmbDnOFiDXeu9NDtKLY+O4nsql3JT5xIvOcj9G7Oz6yFHMWGa3dv77k
	 QTTFKOnWtHbyz9bP3BgAxOFOW9sjaSOAUc2uwoBcFShpcbBQ7ijEr5HzJbnKKcv7H9
	 vovNGa6miYFWculfJK47TW0Olwubbpy6XbtIZLtkIgEIw603CRWZ4BuEAo5vCp+8YD
	 j51qzBmc8tWHIrJPNBL8Jtm4R4hpBaXLLhl6f6KVX8KCLCVsMySD62k2EJMiXOGcho
	 PkEKbPO0cOcEA==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A21017E0AC3;
	Tue, 25 Nov 2025 17:41:45 +0100 (CET)
Message-ID: <cef1d96b-b642-4e69-8c1b-2e0bf7528edf@collabora.com>
Date: Tue, 25 Nov 2025 21:41:22 +0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, kernel@collabora.com,
 superm1@kernel.org
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is pressed
 during hibernation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <2025112433-emphasize-helpful-b748@gregkh>
 <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
 <2025112506-acting-tipoff-3a49@gregkh>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025112506-acting-tipoff-3a49@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 4:47 PM, Greg Kroah-Hartman wrote:
> On Tue, Nov 25, 2025 at 04:12:54PM +0500, Muhammad Usama Anjum wrote:
>> Hi Greg,
>>
>> Thank you for the review.
>>
>> On 11/24/25 10:03 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Nov 07, 2025 at 11:44:29PM +0500, Muhammad Usama Anjum wrote:
>>>> acpi_pm_wakeup_event() is called from acpi_button_notify() which is
>>>> called when power button is pressed. The system is worken up from s2idle
>>>> in this case by setting hard parameter to pm_wakeup_dev_event().
>>>>
>>>> Call acpi_pm_wakeup_event() if power button is pressed and hibernation
>>>> is in progress. Set the hard parameter such that pm_system_wakeup()
>>>> gets called which increments pm_abort_suspend counter. The explicit call
>>>> to acpi_pm_wakeup_event() is necessary as ACPI button device has the
>>>> wakeup source. Hence call to input_report_key() with input device
>>>> doesn't call pm_system_wakeup() as it doesn't have wakeup source
>>>> registered.
>>>>
>>>> Hence hibernation would be cancelled as in hibernation path, this counter
>>>> is checked if it should be aborted.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>
>> My thinking is that people don't press power button after triggering
>> hibernation. They will only press power button if they want to cancel the
>> hibernation or resume from hibernation a bit later when hibernation completes. 
>>> This could be dangerous, as this is not what happens today, are you sure
>>> that people aren't just used to pressing the button multiple times until
>>> the system is hibernated? If so, that would now break with this change
>>> as it's hard to determine what is going on.
>> Yes, its possible. Previously the device wouldn't cancel hibernation on power
>> button press; while now it'll cancel.
>>
>> So should we put this cancellation under some config option to avoid breaking
>> the default behavior?
> 
> Do not add another config option, that way lies madness.  As proof, what
> would your distro select for this, in order to preserve old behavior?  :)
I think, the new behavior would be desirable by most distros. They don't care
about the old behavior. But its just my thinking. What do you think is the way forward?

Even if there are users which used to pressing power button during hibernation,
will not press it after a few tries if they really want the hibernation to complete.

> 
>>> And why does hibernate take so long?  Why not fix that up instead?
>> Hibernation is inherently slow: it must freeze devices, copy and
>> compress/encrypt memory, then resume storage devices to write the image to
>> disk.
>>
>> While I've thought about increasing the speed, I've no concrete ideas yet.
>> The main problem is that its sequential in nature.
> 
> Then fix that?
That's in the plan. But who knows when we get time to attempt that. 

First I need a board/machine with serial console access to view all logs in real
time. :)

---
Thanks,
Usama

