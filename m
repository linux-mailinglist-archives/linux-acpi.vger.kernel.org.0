Return-Path: <linux-acpi+bounces-9632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D99D0FD8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 12:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05B11F22DA5
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0C198E80;
	Mon, 18 Nov 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7AqIGNN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8F198E77
	for <linux-acpi@vger.kernel.org>; Mon, 18 Nov 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929902; cv=none; b=lcG25z+zXQ7H1FJlXjI+nWy7eHfJh7JaiDkFEENoXL/UrYdrK2Q2nFuUCm2JxqAv98Dz0pDbDKiHW9AA/WF7M+FJ1TC3r7nf5UFrgiWqhmDZ4TWVWONcldLGaHGkXADRPu0FbBrK+YuhyCU3HO6dmrZuJ1a5Qic08ONWuGL+wAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929902; c=relaxed/simple;
	bh=oESMn1LEmVNmGUiTbjsDWqJWOp/IPPBvGpuOSSOKZ38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbeEk/rF0z6HVrapYTXTFR/IDtOrM8LKZ/NeiuItU1y4lV2u5TFIvYm55v9uzE4GBw4UBV/O5CgRb0AoZRVgBZ1WyCQwo7zAkEfqeKUQRjSb6TTJ7US7gElnF85GRTbTvAy3ZDkwHLnjhOdeMAY5fBn2KbSf6wuj31M3OMd0UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7AqIGNN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731929899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZrM+6f0a6JSJKh2gj/Png+irOpVHNOAEu2gMRnnpxc=;
	b=X7AqIGNN9I+b8YTMVDWZ4JmJJ83pHcGK23bdnkDd5SW4hyA3tGq57JNWFhJu2CSJgCpeQa
	rq8DuSun/Ue1d9WpkUf6TWnpfQmy6uGfpqmrG3jwXAVGzIPtnLBLg4tR32KvggD2G+rQhq
	ltxcH2Ab4uAQ/MeyFafb6Ml+YNMvmog=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-iArdCouuP_i-yn5mebKdsQ-1; Mon, 18 Nov 2024 06:38:18 -0500
X-MC-Unique: iArdCouuP_i-yn5mebKdsQ-1
X-Mimecast-MFC-AGG-ID: iArdCouuP_i-yn5mebKdsQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a2c3e75f0so169853566b.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Nov 2024 03:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929897; x=1732534697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZrM+6f0a6JSJKh2gj/Png+irOpVHNOAEu2gMRnnpxc=;
        b=Ag/mIlmw67bvv0kHfo4PxERAYozYRmB4bfIiJiaqt4NfRM6kl3Q6+ms9BRxrgp6TDX
         /Z3hi+hvBo3t41/KHIs3fXR2f248EomSYnCMDvN8SDqXK+RATURK2j/NShZym0/6HWBD
         QUr00EtJYHt7FKcpX/AJuoztjrAhLtIYEuSJ/EITRqszv2X8eD5s6kjPXJC/1WqgiJcS
         ZnBU0qZEuPCRgwWHAeaW9e9xQ6dP9ZOB/VCa55cVdA4p/HYaFe284DvsHqFJ1ZgZdUBl
         +drfFS1j7boeNEN5xGqeG1oa37RW0G0OcVVEVRtpIOy78kQTpFgsj+roRtGSSg+cXZtk
         6ndw==
X-Forwarded-Encrypted: i=1; AJvYcCWnlo8EK+JNy6czExEcNUZWd/rBgYt5NNRmqbDWVDl1sdBB5d1EqZqjxWEIxX71REBLwS2BFAgyzix6@vger.kernel.org
X-Gm-Message-State: AOJu0YxSw4sdpZuFW+W6AzKYr0zRrgXL4V48DKPnUkaQyhJEl2JWom2l
	NQzS4Z3nL90lZHzvcmAyvPEj83QeB0P+UqUXPO/slxFeMaU9UNaJ8NHaWfkUqsPumh/ZxtiLrND
	5Q0qtptFJNmHINZ0Jtxk4uzApYV3IWm4IxKFztRirkVPzvgZKsRBywBrFU8k=
X-Received: by 2002:a17:907:3f95:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-aa483525e00mr1198623666b.43.1731929897321;
        Mon, 18 Nov 2024 03:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfFkqW6TL+8jKQefv/92+ahWKuKrfkkhKOeQulO6+cH0bYM/9ydIcxbw1TiBm1mURMwyBDwg==
X-Received: by 2002:a17:907:3f95:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-aa483525e00mr1198620866b.43.1731929896964;
        Mon, 18 Nov 2024 03:38:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e086058sm534699366b.184.2024.11.18.03.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:38:16 -0800 (PST)
Message-ID: <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com>
Date: Mon, 18 Nov 2024 12:38:15 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in
 acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, peterz@infradead.org,
 frederic@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Todd Brandt <todd.e.brandt@intel.com>
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael, Len,

On 18-Nov-24 12:03 PM, Rafael J. Wysocki wrote:
> On Sat, Nov 16, 2024 at 12:11 AM Len Brown <lenb@kernel.org> wrote:
>>
>> From: Len Brown <len.brown@intel.com>
>>
>> Replace msleep() with usleep_range() in acpi_os_sleep().
>>
>> This has a significant user-visible performance benefit
>> on some ACPI flows on some systems.  eg. Kernel resume
>> time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).
> 
> Sure.
> 
> And the argument seems to be that it is better to always use more
> resources in a given path (ACPI sleep in this particular case) than to
> be somewhat inaccurate which is visible in some cases.
> 
> This would mean that hrtimers should always be used everywhere, but they aren't.
> 
> While I have nothing against addressing the short sleeps issue where
> the msleep() inaccuracy is too large, I don't see why this requires
> using a hrtimer with no slack in all cases.
> 
> The argument seems to be that the short sleeps case is hard to
> distinguish from the other cases, but I'm not sure about this.
> 
> Also, something like this might work, but for some reason you don't
> want to do it:
> 
> if (ms >= 12 * MSEC_PER_SEC / HZ) {
>         msleep(ms);
> } else {
>        u64 us = ms * USEC_PER_MSEC;
> 
>       usleep_range(us, us / 8);
> }

FWIW I was thinking the same thing, that it would be good to still
use msleep when the sleep is > (MSEC_PER_SEC / HZ), not sure
why you added the 12 there ? Surely something like a sleep longer
then 3 timerticks (I know we have NOHZ but still) would already be
long enough to not worry about msleep slack ?

And I assume the usleep_range(us, us / 8); is a typo ? Ma can
never be less then max, maybe you meant: usleep_range(us, us + 8) ?

OTOH it is not like we will hit these ACPI acpi_os_sleep()
calls multiple times per second all the time. On a normal idle
system I expect there to not be that many calls (could still
be a few from ACPI managed devices going into + out of
runtime-pm regularly). And if don't hit acpi_os_sleep() calls
multiple times per second then the chances of time coalescing
are not that big anyways.

Still I think that finding something middle ground between always
sleeping the exact min time and the old msleep() call, as Rafael
is proposing, would be good IMHO.

Regards,

Hans




> 
>> usleep_range(min, min) is used because there is scant
>> opportunity for timer coalescing during ACPI flows
>> related to system suspend, resume (or initialization).
>>
>> ie. During these flows usleep_range(min, max) is observed to
>> be effectvely be the same as usleep_range(max, max).
>>
>> Similarly, msleep() for long sleeps is not considered because
>> these flows almost never have opportunities to coalesce
>> with other activity on jiffie boundaries, leaving no
>> measurably benefit to rounding up to jiffie boundaries.
>>
>> Background:
>>
>> acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
>> and it must not return before the requested number of msec.
>>
>> Until Linux-3.13, this contract was sometimes violated by using
>> schedule_timeout_interruptible(j), which could return early.
>>
>> Since Linux-3.13, acpi_os_sleep() uses msleep(),
>> which doesn't return early, but is still subject
>> to long delays due to the low resolution of the jiffie clock.
>>
>> Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
>> ("timers: Remove historical extra jiffie for timeout in msleep()")
>> The 4ms savings is material for some durations,
>> but msleep is still generally too course. eg msleep(5)
>> on a 250HZ system still takes 11.9ms.
>>
>> System resume performance of a Dell XPS 13 9300:
>>
>> Linux-6.11:
>> msleep HZ 250   2460 ms
>>
>> Linux-6.12:
>> msleep HZ 250   1943 ms
>> msleep HZ 1000  1233 ms
>> usleep HZ 250   1127 ms
>> usleep HZ 1000  1130 ms
>>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
>> Signed-off-by: Len Brown <len.brown@intel.com>
>> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
>> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
>> ---
>>  drivers/acpi/osl.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 70af3fbbebe5..daf87e33b8ea 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>>
>>  void acpi_os_sleep(u64 ms)
>>  {
>> -       msleep(ms);
>> +       u64 us = ms * USEC_PER_MSEC;
>> +
>> +       usleep_range(us, us);
>>  }
>>
>>  void acpi_os_stall(u32 us)
>> --
>> 2.43.0
>>
> 


