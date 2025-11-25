Return-Path: <linux-acpi+bounces-19252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C2C84AC0
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 12:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0E53AE961
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC823164B1;
	Tue, 25 Nov 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b/hRfxuJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD1314B9F;
	Tue, 25 Nov 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069211; cv=none; b=RKkE0hPJbHc4lo03aez25mcP9+9haO1drazk4KqFkaiNtMsSytvB4G93+pM11bR2JK2grdaw+t1rVwOtSjJ7vrzKaRGrx3TSoVlP5w2dz1O7GGTW5Jn7nmIflJUEs+IeZ4kBmAGylsqNEEnDU59ehSO2B7c54+nPjUMJpYHxyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069211; c=relaxed/simple;
	bh=OJOYAzww7u5+PTngMYuK5Kr9ktZ50LD7ZGC26gWbY94=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TC4yLZSldaTvO3kJ9QqtbL4OyRxYWLasVJFLx7uwWVJAQMAWEcIBvjoAz49rhc1tCW0xFHdmqAM1BDw+yKLCya83P5YLWv1Cqm6Z2j+LZOYk2vQAv+6ddisbj6a23QOqQLyddJV2acYkOWH/GDwuWNR9Xn8CirmF9A5b8WewpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b/hRfxuJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764069208;
	bh=OJOYAzww7u5+PTngMYuK5Kr9ktZ50LD7ZGC26gWbY94=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=b/hRfxuJcsjap9QQ3nO3ycLRQfEhfc05/DyE7kPBFeSlMEKN2RIL5vd7EVpiZV0PD
	 qZ0ONKcIm9ZmwS9+XFq6gPWYBLSVKE5KTuwcAWPJyX+uF0wgSfJ8cs3XsqTY/8ZKhB
	 h8bkvgAc0j1/kUB2IrdISbVsGTR7VdEgwxstVOlHYODlYbciVcA3y7YUZ5Rk8lPkea
	 T0lUdRSwhLAuFa5J6tUYmWmrLVF1HzgN5eDP8odiMCkBXUMJL43yea296dfCC3Wn6v
	 1VLI00PBfiAxcTY5rgiEsgUvY+ZH8of0ML5i97e7SROwgQkjMNah8spEyQNSZaolY/
	 a0wlpVBbR3NqA==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9919717E12D5;
	Tue, 25 Nov 2025 12:13:24 +0100 (CET)
Message-ID: <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
Date: Tue, 25 Nov 2025 16:12:54 +0500
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
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025112433-emphasize-helpful-b748@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

Thank you for the review.

On 11/24/25 10:03 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 07, 2025 at 11:44:29PM +0500, Muhammad Usama Anjum wrote:
>> acpi_pm_wakeup_event() is called from acpi_button_notify() which is
>> called when power button is pressed. The system is worken up from s2idle
>> in this case by setting hard parameter to pm_wakeup_dev_event().
>>
>> Call acpi_pm_wakeup_event() if power button is pressed and hibernation
>> is in progress. Set the hard parameter such that pm_system_wakeup()
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
>
My thinking is that people don't press power button after triggering
hibernation. They will only press power button if they want to cancel the
hibernation or resume from hibernation a bit later when hibernation completes. 
> This could be dangerous, as this is not what happens today, are you sure
> that people aren't just used to pressing the button multiple times until
> the system is hibernated? If so, that would now break with this change
> as it's hard to determine what is going on.
Yes, its possible. Previously the device wouldn't cancel hibernation on power
button press; while now it'll cancel.

So should we put this cancellation under some config option to avoid breaking
the default behavior?

> 
> And why does hibernate take so long?  Why not fix that up instead?
Hibernation is inherently slow: it must freeze devices, copy and
compress/encrypt memory, then resume storage devices to write the image to
disk.

While I've thought about increasing the speed, I've no concrete ideas yet.
The main problem is that its sequential in nature.

> 
> thanks,
> 
> greg k-h


-- 
---
Thanks,
Usama

