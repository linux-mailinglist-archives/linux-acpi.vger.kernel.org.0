Return-Path: <linux-acpi+bounces-3069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB68405DF
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jan 2024 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB6C1C21DC5
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jan 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62916166D;
	Mon, 29 Jan 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzDvxbQf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5830612C8
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jan 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533257; cv=none; b=NPKwiSZyWbdyCwvL8/ykmzVFBNb3OTIMTHWoN4K9d46L5r9VTyjlGS03F/aVU6HcuwtL6HCDLwPfbocz3ki7t+GeCCcsRMlUo4JlW7t9LTlF5BOt1tAIb86zZ9Lwv0kS6THUUYuD7ZOFSGm52+fA2WCRjsAWx1fi4O1r28aTU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533257; c=relaxed/simple;
	bh=ZUftvY8xSmdixBbMe+tMeh6dBZkFaxNGGUn2u28AxaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUSvDa9QLJd8VlxUErfL/qmDW9LdoJGgW4nNmgqqOEVvrhpwIOXjpde8RB9huRz4vMwNmMV67+Zik8ahd2NJrtN/xcjexRzkAP5VewHd4KpDvZFgAq0DynruDGXZtjI/MlCyG9VOxabeLwLRPIovy49vUIcN6HM5Pmomi4KlEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzDvxbQf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706533254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84oJDHzD1dXthM5sC8FulnqvfgG4LNPiKIgzEQs/jsg=;
	b=QzDvxbQfIoxTmOfA8F+F6P6nzsraEc8ZIazVzBFg6bjwpgP0uXZx95s4WHd83isN33fIka
	FrPumDZ4Q/iv/VU85Cnn2hLsrZqiArzM+QQr1L/ncYfphav6jUXf5orjAR06g765nBNt1Y
	lx5+ky80t012VfYPjcrwQMO3MoFqxuw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-gVVllZjPMg2wATHFk9jyQA-1; Mon, 29 Jan 2024 08:00:53 -0500
X-MC-Unique: gVVllZjPMg2wATHFk9jyQA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5101b9343easo1725136e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jan 2024 05:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533252; x=1707138052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84oJDHzD1dXthM5sC8FulnqvfgG4LNPiKIgzEQs/jsg=;
        b=TtRHV97mE1yA/usNs3ReCC3h8PXfKnke7aNxWAP45LKXqWfQCk3bBV1bI80JhU6pAn
         XN1eEfLlCs43saeKQjjWX2I8joNTqn1MuwkTAXhizK+CVE+cgLmteP/absCc9ZQbUItz
         w/TCKT05hxWZXfzZ7izcl30uto/pBEhub13vI1hefzLyt9YeCTOrUUlSoW9l+RrutlZ1
         tyMIO2Spzl6O28/EiYhR2YoC5v2WWoT+Sp+ax2u+NEAbg9Wfc2VTmuaY22GidZuhH80Y
         AxMMnPzsiQfZUcfRCTKN0VnHM6eIXXvpq2HBbhlFmZgQgNKEXTXFi141w7CyKdlJ+NuT
         JpmQ==
X-Gm-Message-State: AOJu0YwSYH5aOnIwNOhkAULiPADFoKhoP3lVRzLMvFcR4uEh2049cpSJ
	NivLeCASVk1Ukgha4Fu0shUwmJN4gR2tcQAN6jygmKR0pdGW/8JujieUdJaw6HT1hU6ubG62/mw
	rO3ZLNVZlcdOYnRq8C3g9AHS4xW9vQXnRCACBJQ20m+uSBLd8aBadySwgDgs=
X-Received: by 2002:a05:6512:3d0d:b0:510:1702:db30 with SMTP id d13-20020a0565123d0d00b005101702db30mr4552933lfv.39.1706533251636;
        Mon, 29 Jan 2024 05:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS10VX2eDVy8e+lLDdrpQRAvg2P6Wt+/Y2zmfeLuCAbBC0wm4KmjZ//jfPp5AlPBr2x15KVw==
X-Received: by 2002:a05:6512:3d0d:b0:510:1702:db30 with SMTP id d13-20020a0565123d0d00b005101702db30mr4552914lfv.39.1706533251249;
        Mon, 29 Jan 2024 05:00:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d9-20020a193849000000b005100db532cesm1126839lfj.48.2024.01.29.05.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:00:50 -0800 (PST)
Message-ID: <848e9543-8923-4d0c-9f6b-559de64f1fb1@redhat.com>
Date: Mon, 29 Jan 2024 14:00:48 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hp-wmi: info hotkey has no keycode or scancode
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, Dennis Nezic <dennisn@dennisn.mooo.com>
Cc: platform-driver-x86@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <ZawX2mquuTCv0tuF@panther>
 <a8fa0308-0998-48e4-a104-c2b57ee9bd8e@gmx.de> <Zaw9mnfEL65B5r4O@panther>
 <e97ae805-d006-4f0c-96c0-976385772bb7@gmx.de> <Za4T0RwClHOoCPCy@panther>
 <cd86386a-653e-401c-9b70-0860d2e1906a@gmx.de> <Za8xL39m1X22f2Bb@panther>
 <Za9DQdLg2d_CnrZG@panther> <3e574768-8d5b-465b-9860-567d0845d3fb@gmx.de>
 <3e517aa3-4020-4b29-b7b3-85271503d03d@gmx.de> <Za_Xss52DlydJOOO@panther>
 <e53a660b-f766-479c-8507-ffe25ca0e26e@redhat.com>
 <57df06ee-3aa1-4501-9dc6-a7bc57d770be@gmx.de>
 <6775d202-6cdc-4de7-b562-39d659a4667d@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6775d202-6cdc-4de7-b562-39d659a4667d@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/25/24 21:53, Armin Wolf wrote:
> Am 23.01.24 um 20:58 schrieb Armin Wolf:
> 
>> Am 23.01.24 um 16:34 schrieb Hans de Goede:
>>
>>> Hi,
>>>
>>> On 1/23/24 16:13, Dennis Nezic wrote:
>>>> On 23 Jan 15:22, Armin Wolf wrote:
>>>>> Am 23.01.24 um 09:58 schrieb Armin Wolf:
>>>>>
>>>>>> Am 23.01.24 um 05:40 schrieb Dennis Nezic:
>>>>>>
>>>>>>> On 22 Jan 22:23, Dennis Nezic wrote:
>>>>>>>> On 22 Jan 11:44, Armin Wolf wrote:
>>>>>>>>> Am 22.01.24 um 08:05 schrieb Dennis Nezic:
>>>>>>>>>
>>>>>>>>>> On 21 Jan 16:16, Armin Wolf wrote:
>>>>>>>>>>> Am 20.01.24 um 22:39 schrieb Dennis Nezic:
>>>>>>>>>>>
>>>>>>>>>>>> On 20 Jan 21:52, Armin Wolf wrote:
>>>>>>>>>>>>> Am 20.01.24 um 19:58 schrieb Dennis Nezic:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Guys, the "info" illuminated touch-key (hotkey?) on my laptop
>>>>>>>>>>>>>> "doesn't
>>>>>>>>>>>>>> work", showkey doesn't report any keycode or scancode. I
>>>>>>>>>>>>>> don't
>>>>>>>>>>>>>> see any
>>>>>>>>>>>>>> wmi related error messages from dmesg. All the other
>>>>>>>>>>>>>> illuminated
>>>>>>>>>>>>>> "hotkeys" work fine, although confusingly evtest and
>>>>>>>>>>>>>> "libinput
>>>>>>>>>>>>>> debug-events" report that they're coming through the event
>>>>>>>>>>>>>> interface
>>>>>>>>>>>>>> associated with "AT Translated Set 2 keyboard" instead of
>>>>>>>>>>>>>> "HP WMI
>>>>>>>>>>>>>> hotkeys", but hey, as long as I receive them I'm okay :p.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> hp-wmi.c does seem to reference it:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> How can I go about troubleshooting this? (I'm using kernel
>>>>>>>>>>>>>> 6.6.8)
>>>>>>>>>>>>> it can be possible that your machine does not use hp-wmi to
>>>>>>>>>>>>> deliver keycodes
>>>>>>>>>>>>> to the operating system, but instead emulates a standard
>>>>>>>>>>>>> keyboard controller.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Can you check with "kacpimon" that events concerning a PNP0C14
>>>>>>>>>>>>> device are being
>>>>>>>>>>>>> received?
>>>>>>>>>>>> Very possible indeed. "kacpimon" doesn't show anything when I
>>>>>>>>>>>> press that
>>>>>>>>>>>> touchkey, but it does when I press all the other touchkeys. (I
>>>>>>>>>>>> do get
>>>>>>>>>>>> lots of accelerometer noise.)
>>>>>>>>>>>>
>>>>>>>>>>> Interesting, can you please share the output of:
>>>>>>>>>>> - "kacpimon" while you where pressing the buttons
>>>>>>>>>>> - "acpidump"
>>>>>>>>>> ...
>>>>>>>>> Those events are touchscreen events, maybe your mouse is
>>>>>>>>> responsible for them.
>>>>>>>> Right, of course, woops, these must have been the touchpad press
>>>>>>>> events,
>>>>>>>> as I was moving the mouse around :P
>>>>>>>>
>>>>>>>>> Instead they look like this:
>>>>>>>>>
>>>>>>>> I'm definitely not seeing anything like that, just "^Input Layer:
>>>>>>>> Type"'s
>>>>>>>>
>>>>>>>>> Can you try to use kacpimon again but without root privileges?
>>>>>>>>> This
>>>>>>>>> way only netlink events show up.
>>>>>>>>> You might also stop acpid while you are using kacpimon.
>>>>>>>> 0 output from/with netlink, even though kacpimon said:
>>>>>>>>
>>>>>>>> Netlink ACPI Family ID: 24
>>>>>>>> Netlink ACPI Multicast Group ID: 5
>>>>>>>> netlink opened successfully
>>>>>>>>
>>>>>>>> Remember all my other fancy hotkeys "work", but they appear as
>>>>>>>> regular
>>>>>>>> keypress events from an "AT Translated Set 2 keyboard".
>>>>>>>>
>>>>>>>>> If you still cannot receive any netlink events, then i might need
>>>>>>>>> to take a look at your ACPI tables
>>>>>>>>> via acpidump.
>>>>>>>> https://dennisn.mooo.com/stuff/dump.txt
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Armin Wolf
>>>>>>>> Thank you again sir!
>>>>>>> A1799AC3-9429-4529-927E-DFE13736EEBA has zero instances
>>>>>>> 8232DE3D-663D-4327-A8F4-E293ADB9BF05 has zero instances
>>>>>>> 8F1F6436-9F42-42C8-BADC-0E9424F20C9A has zero instances
>>>>>>> 8F1F6435-9F42-42C8-BADC-0E9424F20C9A has zero instances
>>>>>>>
>>>>>>> (Btw that "info" key does get illuminated when I touch/press it,
>>>>>>> even
>>>>>>> though no codes are seen.)
>>>>>> These warnings in dmesg are harmless, they are informing you that
>>>>>> some
>>>>>> WMI devices are unavailable.
>>>>>>
>>>>>> I took a look at your ACPI tables and it seems that the WMI device
>>>>>> used by hp-wmi is indeed unused.
>>>>>> What is the model name of your HP notebook?
>>>> HP Compaq 8710p
>>>>
>>>>> Also i just noted that your notebook might contain a PNP0C32
>>>>> quickstart button device.
>>>>> Can you tell me the output of "cat
>>>>> /sys/bus/acpi/devices/PNP0C32\:00/status"?
>>>> 15
>>> Interesting.
>>>
>>> There have been several attempts to add support for this
>>> in the past. The last one being:
>>>
>>> https://lore.kernel.org/platform-driver-x86/20220922182424.934340-1-lkml@vorpal.se/
>>>
>>>
>>> Note that in this case this also required some vender
>>> specific poking in toshiba_acpi to get things to work.
>>>
>>> I see that the HP Compaq 8710p is about the same vintage
>>> as the Toshiba Z830 on which the last attempt to do
>>> something about the quick start buttons was done.
>>>
>>> So this might very well explain the missing button issue.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>> I can try to upstream the necessary changes. But i cannot test the
>> changes concerning the toshiba_acpi driver.
>> Would it be ok if i omit those changes?
>>
>> Dennis, can you check that your device runs the latest BIOS? And if
>> this is not the case, could you do a BIOS
>> update and send me an updated acpidump?
>>
>> The reason for this is that currently, the button device receives only
>> system wake events, but no button press
>> events during runtime. Maybe this is a BIOS bug, although this could
>> also be intentional (fancy power button).
>>
>> Armin Wolf
>>
> Hi,
> 
> while modifying the quickstart button driver to use the standard pm wake infrastructure, i have run into a
> little problem: how to properly hook up the platform device with the ACPI device wakeup infrastructure?
> 
> Is this possible when using a platform driver, or do i need to use a ACPI driver?

I'm not sure what exactly you are looking for but I think the powerbutton
handling in: drivers/platform/x86/intel/hid.c (search for wakeup) may help ?

If that does not help can you point me to the lines of code in the old version
of the code which you are trying to adjust ?

Regards,

Hans






> 
> Thanks,
> Armin Wolf
> 


