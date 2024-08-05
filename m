Return-Path: <linux-acpi+bounces-7292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C860C947CFC
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B0A1F2371A
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E113B5A0;
	Mon,  5 Aug 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnt+gHDo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122213B2AC;
	Mon,  5 Aug 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868917; cv=none; b=V6h+zil7p6VUDhnITQ24cTdyPxf/gFbfDB0AWhXkdSLjHhgnviwBXUagb+Q/l5J8eX/zEhc0ZCF6DoOLSAg/664KcABN8jsVk1K+XUFAjO6WxEBq8utDTj5N4pm0TP5fyt7M8CXPxaO2l5WPJtmcKKkgzZEDjqNPI/mP7mIA23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868917; c=relaxed/simple;
	bh=v4H5uLIq2UkFTtOGGd2Ghye0fNjVdn+3tAv7CuH7r7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCrSmQaOpcJQsqH23TxTumMoD52i8Z0pekwDgZ7ljeEkE1o6LoO6y8J3YShawyZ7FZLBHMPsMUI3fYZxZ5cjhQHdDmbpilwXcEmUu4BaHMbbpXHoAmUbUrH7KW5dPt53+TNkIYvWHM2nb4LwTw3tJ27iJXRsy0Ol0pjT0fdqvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnt+gHDo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so10538449a12.2;
        Mon, 05 Aug 2024 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722868914; x=1723473714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wPOnax04MCjlH7sAiV0x5iI2FlYXD+nlARfq5eueQs=;
        b=Hnt+gHDo/OofBxxoH3WSg/E2LCXYTo/nvgGE/LQbbfFOZ/4/yIomCq2l4Tjpz9vAEL
         avo8lOKtXV8yUCWAVYD9L3SG5M7r29U441aMAX7vfw3v2kd3K8qXicWKjb3NMX+H1Rof
         zWVek/PBJnmJ2q9xqb+D8knKIHd1j0f72b4HHZJXcuN2cigzQEErWcB+Vn0HaulCXrJF
         oy9nRyoLiT6z1G/istuh4Ab4SPJx83jPyOKMIAFi2Q58X7dHa/+z67ZjKKwGIXnbPiXC
         fcEjvapdca4+RFslh/6i7+7ex1qhRzID3sKvj/6xPPnHu27Dh3PCLuPX0VyzSBWpkkO7
         deWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868914; x=1723473714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wPOnax04MCjlH7sAiV0x5iI2FlYXD+nlARfq5eueQs=;
        b=a6R5uzfGeBBfJfGIh9/804bKGWt90q7vWxuSYtVN/w/AfRlo8NnuGxLrRFNtFMRX/x
         Q2PjAdaf6Vd8ela4US4p+hwzp49EFQEbV8V3FI4Zhaqw+LADeJFz4oFteuEPkoBKZy+B
         qTU3B17vMWhoJ0ppk1EMuZp1xfzJcfC5JEyFQNkGCdn1M1ruH0O++jwudwaMEtFIWIVa
         q/4mLsV8Pges/XJle/bEscONdgI+9BIajKbJyRWcJHdt95CHgUvxv0O9TS06B9Zv9IUT
         rrmmK0x6XXohX+ciYWuhcfd4deqv/jJ4kQ1wLyJBtyKtFvXgEsSpahSnhDy5oqzVL7CH
         lz1A==
X-Forwarded-Encrypted: i=1; AJvYcCUwRQcShhhx2rzucBrlxe0/2wMFKiOvZ9LGC5pkEIINL5hPxk8QWJYPEmBZfLBEfDo20HJ7rdWDnpZtV96T2jj6DkUpCtem66axvambzoUQG4Ff0AAdPW8XH+9i8TQyCtWsYzhUvWYegYwm7yPmqCV/4RY2FXI3qAdGkDGtTEs2uutKp/kMrFLoNDb7tBs8Ubaf+fwXGx2Iol7w4Z/V8q5QinrqVanVzu3W+RtaBERUThGPfHlRCbDnIg==
X-Gm-Message-State: AOJu0Ywgl0UT8ieNscEF3sEKahSJJxCDJs/niMWiCO6CLTOcxrR8IuFT
	7ztA2nLRpqI4ZqaIR1uiMMHpbpSRi4/nPMMdpI3btD8bBzInr5xX
X-Google-Smtp-Source: AGHT+IFzqAB6G4v/aHSsuVrzNy99AsjgLgbTXWCfUA7rRiWqkAa0Svb/TdBppdhK8zgF81Uq/cISTA==
X-Received: by 2002:a50:ff0e:0:b0:5a1:b9c0:7758 with SMTP id 4fb4d7f45d1cf-5b7f58eb6f7mr8897936a12.33.1722868913838;
        Mon, 05 Aug 2024 07:41:53 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3a37bsm5058411a12.88.2024.08.05.07.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:41:53 -0700 (PDT)
Message-ID: <e7625068-c26f-4a3b-972e-eff266c8facf@gmail.com>
Date: Mon, 5 Aug 2024 16:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
To: Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
 <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>
 <20240801123901.GC6756@google.com>
 <9083938c-c2df-4429-904d-700e5021331c@gmail.com>
 <20240805143207.GE1019230@google.com> <20240805143352.GF1019230@google.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240805143352.GF1019230@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2024 16:33, Lee Jones wrote:
> On Mon, 05 Aug 2024, Lee Jones wrote:
> 
>> On Fri, 02 Aug 2024, Javier Carrasco wrote:
>>
>>> On 01/08/2024 14:39, Lee Jones wrote:
>>>> On Mon, 29 Jul 2024, Javier Carrasco wrote:
>>>>
>>>>> On 25/07/2024 18:28, Lee Jones wrote:
>>>>>> On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
>>>>>>> This series aims to clarify the use cases of:
>>>>>>>
>>>>>>> - device_for_each_child_node[_scoped]()
>>>>>>> - fwnode_for_each_available_child_node[_scoped]()
>>>>>>>
>>>>>>> to access firmware nodes.
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> Applied, thanks!
>>>>>>
>>>>>> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>>>>>>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
>>>>>> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
>>>>>>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
>>>>>> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
>>>>>>       (no commit info)
>>>>>>
>>>>>> --
>>>>>> Lee Jones [李琼斯]
>>>>>>
>>>>>
>>>>> Hi Lee,
>>>>>
>>>>> could you please tell me where you applied them? I rebased onto
>>>>> linux-next to prepare for v3, and these patches are still added on top
>>>>> of it. Can I find them in some leds/ branch? Thank you.
>>>>
>>>> Sorry, I was side-tracked before pushing.
>>>>
>>>> Pushed now.  They should be in -next tomorrow.
>>>>
>>>
>>> Thanks, I see
>>>
>>> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>>>
>>> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to
>>> access child nodes
>>>
>>> applied to -next, but
>>>
>>> [5/6] leds: pca995x: use device_for_each_child_node() to access device
>>> child nodes
>>>
>>> has not been applied yet.
>>
>> Yep, looks like b4 didn't like that one:
>>
>> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
>> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
>>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
>> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
>>       (no commit info)
>>
>> I'll try again and see if it can be pulled in.
>>
>> If not you'll have to resubmit it.
> 
> Now results in conflict:
> 
>     Applying patch(es)
>     Applying: leds: pca995x: use device_for_each_child_node() to access device child nodes
>     Using index info to reconstruct a base tree...
>     M	drivers/leds/leds-pca995x.c
>     Checking patch drivers/leds/leds-pca995x.c...
>     Applied patch drivers/leds/leds-pca995x.c cleanly.
>     Falling back to patching base and 3-way merge...
>     error: Your local changes to the following files would be overwritten by merge:
>     	drivers/leds/leds-pca995x.c
>     Please commit your changes or stash them before you merge.
>     Aborting
>     error: Failed to merge in the changes.
>     Patch failed at 0001 leds: pca995x: use device_for_each_child_node() to access device child nodes
>     hint: Use 'git am --show-current-patch=diff' to see the failed patch
>     hint: When you have resolved this problem, run "git am --continue".
>     hint: If you prefer to skip this patch, run "git am --skip" instead.
>     hint: To restore the original branch and stop patching, run "git am --abort".
>     hint: Disable this message with "git config advice.mergeConflict false"
>     
>     Failed to apply patches (fix and either hit return to continue or Ctrl+c to exit)
> 
> Please rebase and resubmit.
> 

Thank you for making the effort anyway, I will resubmit the patch.

Best regards,
Javier Carrasco


