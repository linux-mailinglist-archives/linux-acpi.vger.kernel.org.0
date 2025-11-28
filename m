Return-Path: <linux-acpi+bounces-19357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97BC92B88
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 18:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB9EF4E47B4
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC5286D64;
	Fri, 28 Nov 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TlTZ/tFa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5072284889;
	Fri, 28 Nov 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349296; cv=none; b=QIzIjpvtbtM1jHCbnltXmrcc5nJD+zgbxM0Zuiaje6/5QfqH1QV7RuthuAZkjJ27YOQzUhpL90OLn69VuS1aABN9OlQrKg/cycGvr//rkzONKIs8Y/G4xbtL9d/18f/jMvmJbCk0CO/bFIJy8fU9Kkj0r8xt/3K5+NLGtOPxPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349296; c=relaxed/simple;
	bh=w+/+uB72XXqP5XOu6Dj/JQYa1DwZHV2PT5EEegSpDsI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nZjFoL2SZHs3vmQ29arFXsm/vyp9ZNDbsxFz7DCnyj+zxEwpnf+2FxqbSwzB53j/XS4yxX1f5QhPPkP3e9Ks46PepPlhzmPPvvb1Vgos+dhJLuhnuS/Cs0ETRbdZ2SQ/dTCZPVynxIDnN4qhI8LkWhHCdK+gpxnsBtsWRmEsd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TlTZ/tFa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764349292;
	bh=w+/+uB72XXqP5XOu6Dj/JQYa1DwZHV2PT5EEegSpDsI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TlTZ/tFaBjUTQjrEtaY6uiqao2rYr/Oq3aK8OjUImxux9pzdGbCtmjUWVw1BS6lAY
	 7bEpT7OD0FCBP1P4it+EsdjjL2yXzARWVe/hIUA6Cbln2X0pwn4pq09gAx5XjN8ghg
	 5Vj2YZOmYN9+KqQ1KZh1x6XrHn0J2fVhzr6L8WrRNEfU0huVdLBcPMXIEt98u8beaF
	 yJhtk6oyI/rfBO/PjigeP6FTOPzcE4u9YgKHUYwvDQo6YoMmoPrs4zeYaNMCkw6Yg1
	 Z0cl0bAfmNXReXuIVzCIuScQc+Ew9e5GOGglJI8ew6g2OKZ7S1W6wqbpcpWxPbxdW5
	 e28w2n2SdH7cA==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8FD7717E06C3;
	Fri, 28 Nov 2025 18:01:29 +0100 (CET)
Message-ID: <a26e1b2f-50dc-4956-8bea-49d0e9ac2e4e@collabora.com>
Date: Fri, 28 Nov 2025 22:00:54 +0500
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
 <6f1f3210-47c6-4c00-8fb9-35f48bae2581@collabora.com>
 <CAJZ5v0iDUPB9s2fPJxqVqPGj5wbw54tR4thmDD2V-r4+Q2prwg@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAJZ5v0iDUPB9s2fPJxqVqPGj5wbw54tR4thmDD2V-r4+Q2prwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/25 5:25 PM, Rafael J. Wysocki wrote:
> On Tue, Nov 25, 2025 at 11:23 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 11/24/25 11:50 PM, Rafael J. Wysocki wrote:
>>> On Fri, Nov 7, 2025 at 7:45 PM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> Input (Serio) drivers call input_handle_event(). Although the serio
>>>> drivers have duplicate events, they have separate code path and call
>>>> input_handle_event(). Ignore the KEY_POWER such that this event isn't
>>>> sent to the userspace if hibernation is in progress.
>>>
>>> Your change affects suspend too.
>>>
>>> Also, what's the goal you want to achieve?
>> Two goals:
>> * Don't send event to userspace
>> * Set pm_wakeup for hibernation cancellation for non-acpi devices (This api
>>   call should be tested on non-acpi devices such as arm board to see if it
>>   helps. I don't have an arm board in hand)
>>
>>>
>>>> Abort the hibernation by calling pm_wakeup_dev_event(). In case of serio,
>>>> doesn't have wakeup source registered, this call doesn't do anything.
>>>> But there may be other input drivers which will require this.
>>>>
>>>> Without this, the event is sent to the userspace and it suspends the
>>>> device after hibernation cancellation.
>>>
>>> I think that's because user space handles it this way, isn't it?
>>
>> Yes, it depends on how userspace handles such events. There are different settings
>> configured for systemd-logind when power event is received. The purpose is to consume
>> this event to cancel the hibernation without letting userspace know about it.
>>
>> Thinking more about it, I wasn't sure if all of such events are compulsory to be
>> delivered to userspace. But then I found an example: In acpi_button_notify(), all
>> such events are not sent to userspace if button is suspended. So it seems okay to
>> not send this as well and just consume in the kernel.
> 
> You want the given key (and it doesn't matter whether or not this is
> KEY_POWER or something else) to play two roles.  One of them is to
> send a specific key code to user space and let it handle the keypress
> as it wants.  This is how it works most of the time.  The second one
> is to wake up the system from sleep (and I'm not sure why you want to
> limit this to hibernation) in which case the key code will not be sent
> to user space.
> 
> For this to work, you need to switch between the two modes quite
> precisely and checking things like pm_sleep_transition_in_progress()
> (which is only used for debug and its raciness is not relevant there)
> is not sufficient for this purpose.  That's what the "suspended" flag
> in the ACPI button driver is for.
I've been testing and trying out `suspended` flag. But this flag gets set very late.
If we depend on it, we'll not be able to wakeup in time after cancelling hibernation.

Initially we were using hibernation_in_progress() in RFC and we switched to
pm_sleep_transition_in_progress() in order to cancel the sleep as well (which wasn't 
the original intention).

The sleep detection isn't working through pm_suspend_target_state or pm_suspend_in_progress()
as it is set very late in suspend process. While hibernation_in_progress() gets set in
start of hibernation.

Then as you said, they are unreliable. I'm thinking what other options. But I've not
found any. Please share ideas what other way can work instead of suspended flag better? 

-- 
---
Thanks,
Usama

