Return-Path: <linux-acpi+bounces-19280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B8C8A020
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 14:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB343A9BD2
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412931CA7D;
	Wed, 26 Nov 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hg8ivDDd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAB2F8BC3;
	Wed, 26 Nov 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163634; cv=none; b=t48w/cZP+imirr6oOgoa67K4HKSVQKZteTjU0IPLG2qwN8hkcfsQ2ukqDpVEVtRQ4DmtJifazqVX3ugc1HP1335K8uMagLxtO8+QLzcSCEpVonnCJBFWRb79vBqbQDDYyLybDXiBZj0+rbAfC6dgg/mLgjebkV/A174jXOUVWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163634; c=relaxed/simple;
	bh=DSMhYON7uEGSO4yTfH8l/pMs5uXDMtuWeSv6hnic1N4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HnGpA2YlAQMLaut7sfdD7irneY7GQiY8kZkjVCaSREcMU6qvnBUHwXtGslyUutxZDM+meAdLFc4qHQLkCaL6d9+rkkXocpeVRu4cYU4r6jYwBo42lVoLvmOWiiSIJo9TXxHJAekgn1LEqexUf5iea4xvAyaMtZzj4yJD/LJfcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hg8ivDDd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764163630;
	bh=DSMhYON7uEGSO4yTfH8l/pMs5uXDMtuWeSv6hnic1N4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hg8ivDDdl3eXnp7CRP196ogMs1sRZxX7n7d8kHTWuwFW17PjIHbmQCjrTNHW6uvf0
	 BajHC42ysribGYgqFMFWetHL+RO/GPzfwJqzU1nYB0nOA7FjnjYYZVW+cn5JJCz641
	 VOnqjXdK6K+eYDnL6XHBmHHRtgnCiMpY/zXPo3cAckjXTwW7VdGPz3GktXtYnwZoBf
	 o/1v4t2ZLrkFfhYvGPdWxIuFKEuvFv9CY3+O7dmgusYYaOJCIbcR+5lzXI+n4aKa5f
	 Zxi8a9bBMYqMEGp4sGuv9hvvhp4M3CsPeyOHGvgHI7cMW/J3rGbH7SmaWiwTPDUiAU
	 dacrR+mXFjATQ==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7FB6917E10E7;
	Wed, 26 Nov 2025 14:27:06 +0100 (CET)
Message-ID: <d4ae5b48-d437-494d-8253-0bb66fedd78e@collabora.com>
Date: Wed, 26 Nov 2025 18:26:36 +0500
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
 Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is pressed
 during hibernation
To: Mario Limonciello <superm1@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <2025112433-emphasize-helpful-b748@gregkh>
 <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
 <2025112506-acting-tipoff-3a49@gregkh>
 <cef1d96b-b642-4e69-8c1b-2e0bf7528edf@collabora.com>
 <2025112612-backup-driving-e6e6@gregkh>
 <92de74fb-fc75-4260-bb1d-2d6dd522183f@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <92de74fb-fc75-4260-bb1d-2d6dd522183f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/26/25 5:55 PM, Mario Limonciello wrote:
>>> First I need a board/machine with serial console access to view all logs in real
>>> time. :)
>>
>> usb debug cables might be your solution.
>>
> Just a word of warning before you go too far down this path to get a console working from XHCI debug.
> 
> This is probably a Hal changing a light bulb problem [1]. Last time I tried XHCI debug cables on some modern AMD systems I ran into a problem that the BAR is too big for early_ioremap().  Looking through LKML it's come up a few times in the past too [2] [3].
> 
> Link: https://youtu.be/5W4NFcamRhM?si=qOFrCTzvK6-H-4AX [1]
> Link: https://lore.kernel.org/linux-usb/ZCOq3PUBCtHkwdnw@mail-itl/ [2]
> Link: https://lore.kernel.org/linux-usb/CAAcb1K_bezseTM8DrOrzVUi_W+nZoE2N0CO4k3AQWPw7=7pyjw@mail.gmail.com/ [3]
> 
> The other obvious idea is to use netconsole, but you need a PCIe Ethernet controller, but I think you'll have more success in development using KVM as these are generic architectural problems.
> 
> To help you get started with this I may point out something that was shared to me for another hibernate bug [4].
> 
> Link: https://lore.kernel.org/linux-pm/20251105180506.137448-1-safinaskar@gmail.com/ [4]
> 
> Askar Safin (CC'ed) produced a script that does a very minimal kernel build, sets up a VM with the right sizes of disks/swap/etc.  It's trivial to make kernel changes and re-run the script, and you can  also attach a debugger to the KVM instance.  Maybe you can adapt something like that.  You can wrap it with 'time' calls to actually measure performance for any ideas and prove them out too.
I was just going to try it. Thank you so much for double confirming. I'll
test and see.

-- 
---
Thanks,
Usama

