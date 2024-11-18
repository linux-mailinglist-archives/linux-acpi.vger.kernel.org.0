Return-Path: <linux-acpi+bounces-9634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE09D1061
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B39F28301B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC91991B4;
	Mon, 18 Nov 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJTZd2XP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361C198E6E
	for <linux-acpi@vger.kernel.org>; Mon, 18 Nov 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931856; cv=none; b=n4GDtmUogwJgypheX7K3HxKQxLplMojEspkFXrX160sy+XqvDofVGew0pUkn/cxVy64dnZT/XOYA0sa12wDJhTg6sMuuxlxigifXf3K8VynHHIGpT5Ngi1NFV7ByWMUZ9NfhnoWmawEnILSMfNj5ef8DlICcCYh1SeWwTGgJUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931856; c=relaxed/simple;
	bh=KE+goHykeI6HewMC7lfDXCNfv8iKOUiGTsjxnqlj20k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNFuL5ECtE2l7+7PHLhaXbrAGAnVP9JSDYnN50vNGNfPcdiFVPJxXh3MSx4jv9/E27nnUg1dyJpqxeBE+5s/bJws1P696RbX6KvItCyRzOrh+9BjW6pIh9/DwgIfXmWHhq8eXI6RvGPUM/2cKHjIXJYNAA4LnCxIb2Zpf7rin9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJTZd2XP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731931853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQaEMgsNPBJ1vhvYCqqS05T3kCuF54QxjFkAZFgnQrY=;
	b=UJTZd2XP2CCc7sBDwmDif44SXxqMf32gu+Wtbab6jCKvzYKdcQZYu8fKHPL5m+TPTKM3jB
	BDGiXF2ebny2e+7emlYPG6HZqIHxs20xMC6vcjPRWlO8tyAKxRGQezdRG/JMm9E98CNLms
	fZCnLUKz2rRZoGlX+8KU6EcgmWletng=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-K1-SYAm7M26T1w3F2RYP6g-1; Mon, 18 Nov 2024 07:10:52 -0500
X-MC-Unique: K1-SYAm7M26T1w3F2RYP6g-1
X-Mimecast-MFC-AGG-ID: K1-SYAm7M26T1w3F2RYP6g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso140872266b.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Nov 2024 04:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731931851; x=1732536651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQaEMgsNPBJ1vhvYCqqS05T3kCuF54QxjFkAZFgnQrY=;
        b=VVLWwerWMetnhGxxZ/pCk0f4t3QPzA/jm4DrBOb7urvjFyfJIeu5o+ff/7MzOR2w3L
         TL6/KinJb0Qltp9ZT+Qlz345LfnIm2UxLeZj34NCrt5dfE1Z11NqDu0Vb+NnQ/C0Gyln
         vVzWCsf31aNLYtrufj/sNPy2dQrxIp0VwFkUNcQ++IqKrA5u30pIDx/97NnIizvIT+SI
         T2fEz2Q89VruKvJYaAuQgqfy5/tkMqdxlzV53yJa0XJRQEIT3g53ZO9F0KGTSkZRS05P
         JuOAu74UzJs10sc8bYYrZ8hTBeDfv5zC1iI/u06X0kgUOYgkI4kFeEbFtZTj5lK/7FRm
         wK4A==
X-Forwarded-Encrypted: i=1; AJvYcCWLmpU3zXD5S+BLUS0d+AZJvu695Ea/2bx3ZAK0xH9Mq9nt0RfItCRHyqmP1KsKsQqoZqank5dCp5Mc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3NE1zR+pNAb+y3vK8C7GfWDLBDjMqppBrH9LrxFlQg9ZQYN2
	9JZ02vP21GanMORpNGOmqTEqs+TKATeqOrStxc84Gp7w6dcssQLJqELBzcu2gu69JVT1jjw85Y1
	zqg1h/6nqseB6Fa+8F29/7v8hJBLQNYmm7o6C9zJOazlCt+oZ8fof6q4YWbI=
X-Received: by 2002:a17:907:a0e:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-aa483553f62mr1172424266b.60.1731931850827;
        Mon, 18 Nov 2024 04:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjnaPzht7Tz5cfB+HN/5KGgqTyfgW3av52j0RDRAyvsdAlLE/VJcxD8KTU7SG/+Mt23nVb0w==
X-Received: by 2002:a17:907:a0e:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-aa483553f62mr1172422866b.60.1731931850450;
        Mon, 18 Nov 2024 04:10:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfbddf326esm1635926a12.82.2024.11.18.04.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 04:10:49 -0800 (PST)
Message-ID: <95f1b1f6-af16-415c-acd0-8eb1ab49746a@redhat.com>
Date: Mon, 18 Nov 2024 13:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in
 acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, anna-maria@linutronix.de,
 tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org,
 corbet@lwn.net, akpm@linux-foundation.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Todd Brandt <todd.e.brandt@intel.com>
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com>
 <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 18-Nov-24 1:02 PM, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Mon, Nov 18, 2024 at 12:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael, Len,
>>
>> On 18-Nov-24 12:03 PM, Rafael J. Wysocki wrote:
>>> On Sat, Nov 16, 2024 at 12:11 AM Len Brown <lenb@kernel.org> wrote:
>>>>
>>>> From: Len Brown <len.brown@intel.com>
>>>>
>>>> Replace msleep() with usleep_range() in acpi_os_sleep().
>>>>
>>>> This has a significant user-visible performance benefit
>>>> on some ACPI flows on some systems.  eg. Kernel resume
>>>> time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).
>>>
>>> Sure.
>>>
>>> And the argument seems to be that it is better to always use more
>>> resources in a given path (ACPI sleep in this particular case) than to
>>> be somewhat inaccurate which is visible in some cases.
>>>
>>> This would mean that hrtimers should always be used everywhere, but they aren't.
>>>
>>> While I have nothing against addressing the short sleeps issue where
>>> the msleep() inaccuracy is too large, I don't see why this requires
>>> using a hrtimer with no slack in all cases.
>>>
>>> The argument seems to be that the short sleeps case is hard to
>>> distinguish from the other cases, but I'm not sure about this.
>>>
>>> Also, something like this might work, but for some reason you don't
>>> want to do it:
>>>
>>> if (ms >= 12 * MSEC_PER_SEC / HZ) {
>>>         msleep(ms);
>>> } else {
>>>        u64 us = ms * USEC_PER_MSEC;
>>>
>>>       usleep_range(us, us / 8);
> 
> Should be
> 
>       usleep_range(us, us + us / 8);
> 
> (I notoriously confuse this API).

I see.

>>> }
>>
>> FWIW I was thinking the same thing, that it would be good to still
>> use msleep when the sleep is > (MSEC_PER_SEC / HZ), not sure
>> why you added the 12 there ? Surely something like a sleep longer
>> then 3 timerticks (I know we have NOHZ but still) would already be
>> long enough to not worry about msleep slack ?
> 
> The typical msleep() overhead in 6.12 appears to be 1.5 jiffy which is
> 1.5 * MSEC_PER_SEC / HZ and I want the usleep() delta to be less than
> this, so
> 
> delta = ms / 8 <= 1.5 * MSEC_PER_SEC / HZ

Ok, that makes sense. But this probably requires a comment explaining
this so that when someone looks at this in the future they understand
where the 12 comes from.

Where as the / 8 is just a choice right? I think it is decent choice,
but still this is just a value you picked which should work nicely,
right ?

>> OTOH it is not like we will hit these ACPI acpi_os_sleep()
>> calls multiple times per second all the time. On a normal idle
>> system I expect there to not be that many calls (could still
>> be a few from ACPI managed devices going into + out of
>> runtime-pm regularly). And if don't hit acpi_os_sleep() calls
>> multiple times per second then the chances of time coalescing
>> are not that big anyways.
>>
>> Still I think that finding something middle ground between always
>> sleeping the exact min time and the old msleep() call, as Rafael
>> is proposing, would be good IMHO.
> 
> Thanks for the feedback!

You're welcome.

Len any chance you can give Rafael's proposal a test run on the
same Dell XPS 13 9300 and see what this means for the resume time ?

If this gets close enough to your patch I think we should go with
what Rafael is proposing.

Regards,

Hans




>>>> usleep_range(min, min) is used because there is scant
>>>> opportunity for timer coalescing during ACPI flows
>>>> related to system suspend, resume (or initialization).
>>>>
>>>> ie. During these flows usleep_range(min, max) is observed to
>>>> be effectvely be the same as usleep_range(max, max).
>>>>
>>>> Similarly, msleep() for long sleeps is not considered because
>>>> these flows almost never have opportunities to coalesce
>>>> with other activity on jiffie boundaries, leaving no
>>>> measurably benefit to rounding up to jiffie boundaries.
>>>>
>>>> Background:
>>>>
>>>> acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
>>>> and it must not return before the requested number of msec.
>>>>
>>>> Until Linux-3.13, this contract was sometimes violated by using
>>>> schedule_timeout_interruptible(j), which could return early.
>>>>
>>>> Since Linux-3.13, acpi_os_sleep() uses msleep(),
>>>> which doesn't return early, but is still subject
>>>> to long delays due to the low resolution of the jiffie clock.
>>>>
>>>> Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
>>>> ("timers: Remove historical extra jiffie for timeout in msleep()")
>>>> The 4ms savings is material for some durations,
>>>> but msleep is still generally too course. eg msleep(5)
>>>> on a 250HZ system still takes 11.9ms.
>>>>
>>>> System resume performance of a Dell XPS 13 9300:
>>>>
>>>> Linux-6.11:
>>>> msleep HZ 250   2460 ms
>>>>
>>>> Linux-6.12:
>>>> msleep HZ 250   1943 ms
>>>> msleep HZ 1000  1233 ms
>>>> usleep HZ 250   1127 ms
>>>> usleep HZ 1000  1130 ms
>>>>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
>>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>>> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
>>>> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
>>>> ---
>>>>  drivers/acpi/osl.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>> index 70af3fbbebe5..daf87e33b8ea 100644
>>>> --- a/drivers/acpi/osl.c
>>>> +++ b/drivers/acpi/osl.c
>>>> @@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>>>>
>>>>  void acpi_os_sleep(u64 ms)
>>>>  {
>>>> -       msleep(ms);
>>>> +       u64 us = ms * USEC_PER_MSEC;
>>>> +
>>>> +       usleep_range(us, us);
>>>>  }
>>>>
>>>>  void acpi_os_stall(u32 us)
>>>> --
>>>> 2.43.0
>>>>
>>>
>>
> 


