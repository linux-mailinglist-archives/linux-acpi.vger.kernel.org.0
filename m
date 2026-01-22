Return-Path: <linux-acpi+bounces-20575-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBcNHK2kcmmMoQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20575-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 23:29:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126FB6E265
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 23:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4692A300C59D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1637107F;
	Thu, 22 Jan 2026 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR/vtUUg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8336920E
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120935; cv=none; b=BAG+q+aYMzpRnmrgrvCMOMGS/QEGp3P2UCvnYKtnbY14KCu6Y9ya0giK1c3r5E8sdBh5snjPPYPaLpX+24DRBQKintJlvVqf8t6Iz9p0uAdH+DjMpQdA+y5Jn2bLrL5vZuSLNUiQE6n8ldy+omzQ+6UCoVdX+dU3EL0lAWoJFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120935; c=relaxed/simple;
	bh=Ww6JI24WyVKaOTnSpMAoDJHMfr4gWTESqJzmp7NwNMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwIKgle6kictIYj4DAfBZTTgsg0vkbeUxKf8I6yd2Az2KgDPIPXsJ7IQ3yZjZ5cnJb8eI8Vf3ezR5iaTFlcZcHggG2AVndKwhZmhJ4DW8kOkWKbaqUKcOCud85JSgKXkhAKVtL+gwHtYg9UpzeWVBaOI1V/DObJJwL3JkTEMcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR/vtUUg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29efd139227so11404875ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769120930; x=1769725730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ8Ptphxfx/s85nEV5mUoQB9MpWQ43/7kHR4HQJuZbs=;
        b=XR/vtUUg8eNKUPtotk/GdEduk4qSQ/LmaMRVPMeNi+LGUr/DctL6dTO71zNDjr2WgC
         ETePKHOPJYskIL9kJ/mKSh3VVwOrmUSoH/SL/yF4eL0mlNB2kMqMWtqPyrHTLU9yfr5e
         kcXmH2h+i5BXrMtmOsL8uSqjrZcJTVX/YlSt5h4mgqyTal1h0Ye459cZpYghyamBzJ/C
         VxRIWUZ7n4sL4aRx1UdaCWoIgR1yqBxsy3sGyIQSPDb3rHVpN/ga0lFOq7rpmo/tHNby
         91Dy/C7HaBlhQOltW2x6g37M2RawQjTt3jQXdpclQnD6xPJnTj80MjWT+J9qTJhTFXmh
         E82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120930; x=1769725730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ8Ptphxfx/s85nEV5mUoQB9MpWQ43/7kHR4HQJuZbs=;
        b=xFlSyrqEzyEwIGks90paZcMBz+eFEmnQ/RFmTOnUGwUDy6vU2anQQnntPF+abplsYZ
         2sbEXmQHbYbEFmHin9JYXvnGeWPkgQyh5m37eR76xoSqgr4tfZr77UTGHxNJM7OVd3Tm
         mtrLLzh2e/2FnSZawqMHHMqRMTuSWj14RDQg6d76W/EwZRZTmBZXVRSc7DvZpcseA40l
         vRhW8INi+1F3q5fcTa1dUc5KbSP7a58h7uKBc46WUU4Sa/uuK1Mm/P1myRvy21S9+Xfp
         y79JsKUO+jsTXgshbWx2QLCPdxS1I9vt8L52smu1SlA3seYiVl2GFbdD2VmLDTC8S2WL
         nDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi/SRsj0PSnALbku9xXzwqyXOoQW31GE2I0emsRiB4NIZTW/ETZwFVd1xh2+v7cMOuLTb6d4YxcsFI@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSIbIdtIASK26h5yL1sOwMr1TNiRHp2GXG36cSgQVOCwlyM9q
	WnAxuA26AkDqfrAJIVeIG4urhBmb0dCpcjjHYvlu6ButyVirPKkW07K8
X-Gm-Gg: AZuq6aI1mnlZ4XShxepOlW1QvXequrrKBbh7qTEFzY5xAxUIDl4xmla8xKm57RWvEEn
	16Mlinu5/w9Ky86fYGd8JIOnJi+mBWmkWO5mQxtw8ZR7fh1Q8TILtIUhj86RM/WYrnSpiRndgM+
	it0m8HdQkVQanVfk4q43q7MiOV4hrgJ3rje+yFRZN2jGH7PdNtttj2XBziM5gRzsRca8t2MNwp7
	WFzlw8IpmySbqIhbTFPVLXFKr+oQ11WNZy+0Cz+9sMD4nIEZIIq4e2rfWi8aJGqOd3tF3SmRbiG
	h0AoOqaEyMbKR3XlBdyHMfmRy7QtV2Fd7JNaIDZ+zSNkuBf6GiHRTIZU1XAP65qtMza9bogTaY7
	7ZdS3ITq20P1ShRO6shXqrihQQGZ356wHHlo9GzaMsEZVsQfRXZQmRc4z7YoDrge7tF3HQU4U0w
	Na0o8L52TSKvie0a2pLCrJGReVvU0WHrWvz9OWw/S0OR/B5F2ik73dEmyg2mem
X-Received: by 2002:a17:902:d54f:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a7fe734034mr7899265ad.50.1769120929632;
        Thu, 22 Jan 2026 14:28:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3533521707asm3312569a91.8.2026.01.22.14.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 14:28:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net>
Date: Thu, 22 Jan 2026 14:28:47 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20575-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gooddata.com:email,roeck-us.net:mid,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 126FB6E265
X-Rspamd-Action: no action

On 1/22/26 12:42, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 8:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/22/26 10:55, Rafael J. Wysocki wrote:
>>> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
>>> <jaroslav.pulchart@gooddata.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
>>>> in the ACPI power meter hwmon interface. Reading power*_average sysfs
>>>> attributes blocks indefinitely and causes tasks to enter uninterruptible
>>>> sleep (D state).
>>>
>>> The most recent change in the acpi_power_meter driver was made in
>>> 6.15, so this is not a regression in that driver.
>>>
>>> Also, nothing suspicious is done in power1_average_min_show() and
>>> power1_average_min_store() AFAICS.
>>>
>>
>> I suspect a circular locking problem between the hwmon lock and the
>> resource lock. Unfortunately I don't immediately see it.
>>
>> Would it be possible to test this with a kernel which has lock debugging
>> enabled ? I'd test it myself but I don't have a system available
>> that supports the acpi power meter.
> 
> One problem I found in acpi_power_meter through code inspection is
> calling hwmon_device_unregister() under resource->lock in
> acpi_power_meter_notify(), which may be responsible for the observed
> symptoms, but then I'm not sure why it started to be visible after
> 6.18.
> 

I noticed that too. It is kind of broken; a driver should never do that.
The proper solution would have been to re-evaluate sensor visibility.
I have a patch series to add that capability to the hwmon core, but that
is untested so I never submitted it.

Anyway, I don't immediately see how that would trigger the problem.

Guenter


