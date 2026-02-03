Return-Path: <linux-acpi+bounces-20825-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI9TN31BgWl6FAMAu9opvQ
	(envelope-from <linux-acpi+bounces-20825-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 01:29:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDC0D2FBC
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 01:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824AC300363A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 00:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623031A3160;
	Tue,  3 Feb 2026 00:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXOHf1fM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7D18D658
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078396; cv=none; b=FYSC9od26/UL4HGp0J/TMP5srOBRc9WUxm6G4gMynenOOeqONgwYeHTEG6vWDqfj0ok7MrGj2T/yuLdQB/ud77CG2b9OrfBCXWKcgDo9zze0lNthnsc7i3GdExPcAJXj8GPSWa1FWSvTQ54AvB9Ht0nhRS674jpOAz7RCt4xxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078396; c=relaxed/simple;
	bh=lBxpp5TwDJeQrWcQDy+VSo0+8Yk8tpMpQP3NeBwBHt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwWGl2nP3sJu1kELOwwOZkdhyUgNMqT8GPa8ovicH8x6Al4KcL2lY05mFgrDdubC/Q9N7JqJ+ZkDBGkwM6NhikOJe4IiVRonxJyiVzAoopSZ4kCeNKZIzOXY41Klj4PltSAY4Tz0f4WQ4S2L8tyeCoqHap4+hp1tST+wafda3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXOHf1fM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3264443a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2026 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770078394; x=1770683194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj9DGCZDqnyud/88uMxDaXERPVFoP9PUcwkcmUSA9xA=;
        b=eXOHf1fMu7VkgDc9t9BL2Wgnbyic1/mFf/hvqNpUIKDxNrOI25DS91LWCOx7Au0Jmh
         0w2xHgeWhVvBcfXX44OQbqWK94l5mUg8yAOQk44aXA1JqyB59LedCDBwTQEKTTpwJfKD
         A1TW6wCm7rToxAcJu9fHanWNpNGJmfTkmLZPAsle3FpP2Rn3nq/z+tlnAAV3B7TjzwZx
         D9jCulZlEb8yZobIUdLl8PLPMtRB7ZSE6ok2LJ9wJ/xJ6/T4SzGbUvVan+X6YNLNyM0m
         Iljpbk3wjfYbQFWSalgSLrgo/tfIXmABGTzlHNd8egw8wMogvPsV6AL1qCqDYQExw/ZA
         Rk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770078394; x=1770683194;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj9DGCZDqnyud/88uMxDaXERPVFoP9PUcwkcmUSA9xA=;
        b=oKC6p8ulvuir1+HqMDHySPxG/6wp3lZr9KmNiMWabcyWYxZIYX3CbFkMQ0eZyBpCif
         PyyaswCYfcBYjNmqWQwQgGUqUY9jWzTeaTFmvjokKyIlBishI/7GWMwapCI1GymP4lf0
         IcI/gg/FNaLWFD0MJj8WyG4jJAZTeSdYm1qVPHWACgNfmXjbdTlFScNdRMv9XHGZtqzt
         ITBsYwE0GELRr65M2cUec74CTXSz+8ZW+LC2uDmhHvo8TbeQDgfbSQLcuy7s6wLDjQCi
         1BykW/yKmTlPo4CIRxa3q+XXO0aUWELdrUDXm+NXKmQxUBpcoqJrUp7nmj9ixqBs0vQZ
         xwGw==
X-Gm-Message-State: AOJu0Yy3awRJeQzAuC59x8j8VrSbZFfnEpcGPSf+MzjoRlVgx63eSq7Y
	+fU4g6UPUTVGtAeW0l/fpqCK8LsI22GPmWLxYyST7M54l8OFHj4hD5yR
X-Gm-Gg: AZuq6aIwVQnPsjEIToptgxMONd//2dopBKFuTPE/WQNv+w4UE/fKogDQcbrlg83QcSg
	UUWdSWg5p1B7oxRkzb10nBYF2DTfRqmDsG/8c/5uBeMbN/3xkx+O1bSQ/GMtuoiK4onltPNJ0jt
	9aP5GiTgyM52gveEFUMmL6ztv6XPDlA9DIq8rnpPl8NSIGzmJSGWpspooa+rtwHSIhr4wTfX07s
	5W9zLr2eWZ/wQLjcPtcHC58nIwcNR5H40ys85W70SChJB71tFg0nzjITJta+IXCGu7Nkz4ZDP2G
	UbRXTTNsfTfYGCZQ647l1VA+LxFTpW1sckKyuwlIkLECKdryTCXHfxA6eINEztaKw1t92JXk7BB
	JH0iRGXWv+bHoqhVP4N3xDeMi9/QqA2nERONbx7u02qC/547o9KnQqHFpgtxrSOi8myZGz4bRyE
	WlLwkxHxTujWFqeY6heW1bqvQr3ZaPFhpohcl9KjQX6aGec+e7JnEYJkD5b8PT
X-Received: by 2002:a17:90b:3c49:b0:340:bfcd:6afa with SMTP id 98e67ed59e1d1-3543b2dcea7mr11180871a91.8.1770078393724;
        Mon, 02 Feb 2026 16:26:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354774e0034sm578711a91.0.2026.02.02.16.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 16:26:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a510ab93-ce0a-466e-b3d0-6e872d4fa182@roeck-us.net>
Date: Mon, 2 Feb 2026 16:26:31 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net>
 <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net>
 <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net>
 <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net>
 <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
 <27d60756-d33e-4926-9a02-f52505339de6@roeck-us.net>
 <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20825-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,gooddata.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DDC0D2FBC
X-Rspamd-Action: no action

On 2/2/26 11:26, Rafael J. Wysocki wrote:
> On Mon, Feb 2, 2026 at 7:14 PM Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> wrote:
>>
>>>
>>> On 2/2/26 08:48, Jaroslav Pulchart wrote:
>>>>>
>>>>> On Thu, Jan 29, 2026 at 04:26:37PM +0100, Jaroslav Pulchart wrote:
>>>>>>>
>>>>>>> On 1/27/26 03:58, Jaroslav Pulchart wrote:
>>>>>>> ...
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> Thank you for the analysis and insights.
>>>>>>>>>>
>>>>>>>>>> To add some context from our side: we observe this issue shortly after
>>>>>>>>>> a server reinstall or fw updates followed by a reboot, typically when
>>>>>>>>>> hwmon sensors are accessed for the first time (e.g. by monitoring during
>>>>>>>>>> early system initialization). We have not seen it trigger during normal
>>>>>>>>>> operation, such as a simple reboot or on long-running systems.
>>>>>>>>>>
>>>>>>>>>> Given this behavior, it is possible that the issue is related to
>>>>>>>>>> hwmon_device_unregister() being triggered early during system
>>>>>>>>>> initialization, but I do not have concrete evidence at this point.
>>>>>>>>>>
>>>>>>>>>> As a workaround, we will exclude the ACPI power meter from hwmon monitoring
>>>>>>>>>> (Grafana Alloy) until the mentioned refactoring or a fix becomes available.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Would it be possible for you to test the patch series I just sent out ?
>>>>>>>>
>>>>>>>> I suppose these 5 patches from
>>>>>>>> https://lore.kernel.org/lkml/20260123182208.2229670-1-linux@roeck-us.net/
>>>>>>>>     ?
>>>>>>>
>>>>>>> Correct.
>>>>>>>
>>>>>>>> I will try them and let you know.
>>>>>>>>
>>>>>>> Thanks !
>>>>>>
>>>>>>
>>>>>> The issue is still there:
>>>>>> ...
>>>>>
>>>>> Thnaks a lot for testing.
>>>>>
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.105931] INFO: task alloy:5985 blocked for more than 124 seconds.
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.114475]       Tainted: G            E 6.18.7-2.gdc.el9.x86_64 #1
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.122872] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.132932] task:alloy           state:D stack:0     pid:5985 tgid:5871  ppid:1      task_flags:0x400140 flags:0x00080001
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.145975] Call Trace:
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.149985]  <TASK>
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.154931]  __schedule+0x2b5/0x690
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.160934]  schedule+0x23/0x80
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.166498]  schedule_timeout+0xe8/0x100
>>>>>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.172936]  __wait_for_common+0x99/0x1c0
>>>>>> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.179148]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.185936]  acpi_ipmi_space_handler.part.0+0x1ac/0x370 [acpi_ipmi]
>>>>>> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.194929]  acpi_ev_address_space_dispatch+0x16d/0x3c0
>>>>>
>>>>> Looks like acpi holds another lock. Can you check if the patch submitted by
>>>>> Rafael fixes the problem ?
>>>>
>>>> Hello,
>>>>
>>>> I tested the patch as a standalone change, and the issue is still present.
>>>>
>>>> However, I can now reliably reproduce the problem. It is triggered while
>>>> Dell iDRAC is being reset or updated and is temporarily unavailable. During
>>>> this time, a [kipmi0] task enters D state for an extended period, and
>>>> shortly after (or during this), the ACPI power meter hwmon interface ends up
>>>> in the locked state described earlier.
>>>>
>>>> This explains why we mostly observe the issue after redeployments in our
>>>> environment: server redeployments typically include iDRAC firmware updates
>>>> or resets performed together with operating system installation or updates.
>>>>
>>>
>>> Thanks for the update. Do you have a dmesg log showing the problem with Rafael's
>>> patch applied, by any chance ?
>>
>> [  740.004138] INFO: task alloy:8260 blocked for more than 122 seconds.
>> [  740.010752]       Tainted: G            E       6.18.8-1.gdc.el9.x86_64 #1
>> [  740.019257] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.030103] task:alloy           state:D stack:0     pid:8260
>> tgid:8260  ppid:1      task_flags:0x400100 flags:0x00080001
>> [  740.045068] Call Trace:
>> [  740.050334]  <TASK>
>> [  740.055075]  __schedule+0x2b5/0x690
>> [  740.062073]  schedule+0x23/0x80
>> [  740.068081]  schedule_preempt_disabled+0x11/0x20
>> [  740.074962]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  740.083073]  hwmon_attr_show+0x36/0x130
>> [  740.089081]  dev_attr_show+0x19/0x60
>> [  740.095876]  sysfs_kf_seq_show+0xbf/0x140
>> [  740.102810]  seq_read_iter+0x112/0x510
>> [  740.109070]  ? security_file_permission+0x8e/0xa0
>> [  740.117100]  vfs_read+0x215/0x340
>> [  740.123113]  ksys_read+0x61/0xe0
>> [  740.130088]  do_syscall_64+0x5d/0xb40
>> [  740.137032]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  740.144601] RIP: 0033:0x408d8e
>> [  740.151070] RSP: 002b:000000c001cad498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  740.160825] RAX: ffffffffffffffda RBX: 0000000000000022 RCX: 0000000000408d8e
>> [  740.170097] RDX: 0000000000000080 RSI: 000000c007c28880 RDI: 0000000000000022
>> [  740.180085] RBP: 000000c001cad4d8 R08: 0000000000000000 R09: 0000000000000000
>> [  740.190074] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  740.201069] R13: 0000000000000040 R14: 000000c0058b1dc0 R15: ffffffffffffffff
>> [  740.211072]  </TASK>
>> [  740.215117] INFO: task alloy:8268 blocked for more than 123 seconds.
>> [  740.224109]       Tainted: G            E       6.18.8-1.gdc.el9.x86_64 #1
>> [  740.234089] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.243611] task:alloy           state:D stack:0     pid:8268
>> tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  740.258077] Call Trace:
>> [  740.261260]  <TASK>
>> [  740.266083]  __schedule+0x2b5/0x690
>> [  740.273081]  schedule+0x23/0x80
>> [  740.279055]  schedule_preempt_disabled+0x11/0x20
>> [  740.286087]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  740.294074]  hwmon_attr_show+0x36/0x130
>> [  740.300089]  dev_attr_show+0x19/0x60
>> [  740.306074]  sysfs_kf_seq_show+0xbf/0x140
>> [  740.313074]  seq_read_iter+0x112/0x510
>> [  740.319075]  ? security_file_permission+0x8e/0xa0
>> [  740.326064]  vfs_read+0x215/0x340
>> [  740.331218]  ksys_read+0x61/0xe0
>> [  740.337078]  do_syscall_64+0x5d/0xb40
>> [  740.342083]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  740.349376] RIP: 0033:0x408d8e
>> [  740.355086] RSP: 002b:000000c008403498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  740.365088] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 0000000000408d8e
>> [  740.375072] RDX: 0000000000000080 RSI: 000000c006a47d80 RDI: 000000000000001f
>> [  740.383669] RBP: 000000c0084034d8 R08: 0000000000000000 R09: 0000000000000000
>> [  740.393072] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  740.401326] R13: 0000000000000040 R14: 000000c005ea7880 R15: ffffffffffffffff
>> [  740.411087]  </TASK>
>> [  740.416089] INFO: task alloy:8270 blocked for more than 123 seconds.
>> [  740.425081]       Tainted: G            E       6.18.8-1.gdc.el9.x86_64 #1
>> [  740.434091] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.444078] task:alloy           state:D stack:0     pid:8270
>> tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  740.457108] Call Trace:
>> [  740.462080]  <TASK>
>> [  740.467073]  __schedule+0x2b5/0x690
>> [  740.472252]  schedule+0x23/0x80
>> [  740.478087]  schedule_preempt_disabled+0x11/0x20
>> [  740.485099]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  740.491096]  hwmon_attr_show+0x36/0x130
>> [  740.497082]  dev_attr_show+0x19/0x60
>> [  740.503078]  sysfs_kf_seq_show+0xbf/0x140
>> [  740.510030]  seq_read_iter+0x112/0x510
>> [  740.516073]  ? security_file_permission+0x8e/0xa0
>> [  740.523355]  vfs_read+0x215/0x340
>> [  740.529077]  ksys_read+0x61/0xe0
>> [  740.534925]  do_syscall_64+0x5d/0xb40
>> [  740.540253]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  740.548077] RIP: 0033:0x408d8e
>> [  740.553078] RSP: 002b:000000c0085cf498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  740.563075] RAX: ffffffffffffffda RBX: 000000000000001b RCX: 0000000000408d8e
>> [  740.572088] RDX: 0000000000000080 RSI: 000000c006d44f80 RDI: 000000000000001b
>> [  740.582076] RBP: 000000c0085cf4d8 R08: 0000000000000000 R09: 0000000000000000
>> [  740.591086] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  740.600086] R13: 0000000000000040 R14: 000000c005703c00 R15: 0000000000000054
>> [  740.609481]  </TASK>
>> [  740.614084] INFO: task alloy:8287 blocked for more than 123 seconds.
>> [  740.623089]       Tainted: G            E       6.18.8-1.gdc.el9.x86_64 #1
>> [  740.632094] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.642083] task:alloy           state:D stack:0     pid:8287
>> tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  740.656080] Call Trace:
>> [  740.660694]  <TASK>
>> [  740.665087]  __schedule+0x2b5/0x690
>> [  740.671086]  schedule+0x23/0x80
>> [  740.677080]  schedule_timeout+0xe8/0x100
>> [  740.683134]  __wait_for_common+0x99/0x1c0
> 
> So this is wait_for_completion(&tx_msg->tx_complete) in
> acpi_ipmi_space_handler(), if I'm not mistaken, which never gets
> completed, so stuff cannot make progress.
> 
> I guess what happens is that one of the ACPI methods evaluated by the
> acpi_power_meter driver trips on an IPMI operation region and locks up
> because of the above.
> 
> Did you, by any chance, upgrade the firmware in the time frame between
> 6.17 and 6.18?
> 

"It is triggered while Dell iDRAC is being reset or updated and is temporarily unavailable."

so I guess this is a yes. What I don't understand is why this wasn't seen before.
I would have assumed that the problem exists even without the additional
lock in the hardware monitoring core. Obviously I am missing something.

Any idea ?

Thanks,
Guenter


