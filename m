Return-Path: <linux-acpi+bounces-7562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAD9514CA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 08:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46A31F247CF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A067FBA2;
	Wed, 14 Aug 2024 06:48:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB84D8A8;
	Wed, 14 Aug 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618080; cv=none; b=I501u976uJnVHSIN0yxrdsKSYIBrBL79UKzL7N/Q+iNyMymMBpPIXbf5ne/zwM5F1EQ7IJ4SP3btX81fyAvYXtOUs4fNdHycZMos3jzJMptKcckPcyMMILv/bc91LSWpU6e72Dyy+AZMeVVwz5EY3QySWyrW4C9Mn8Fc0xg2Nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618080; c=relaxed/simple;
	bh=DCNr5+4t1xytMUt0Xt3CcaIGKJSMLIYDREjZP8TkHXI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HT1TlCeZt1h5FSZh4jFgbN5H8R3dgom1s6tdusMobtGzOu/CwGk62SeKMjIMGKvxvq7l5ppzEOdlCwo+R8O/tDJMB1fZ+aIDuARoHaNViv0OFH5jlA8YSrIRd+VmvM6s7e2oK6NY6T9Zxf2VBH1zRWoK07Fwu3GECRC8PZdiB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so7274257a12.2;
        Tue, 13 Aug 2024 23:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618076; x=1724222876;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5bvJSxOBvuWRxdChoobI1KogQglvyFcn+jWX2rf1tk=;
        b=xDMuFOhdtLskmNQVn9LZSWHBc8fLju2R3CLXkY1spDaxNVa/iT8POeP/X5YJxGHzF1
         08s79AWUGBZAlO/f6Ln+dOyOTXVKtp/XJWjT5alcwsctus9Bmn0+0ucoaakNnrlrQkdz
         uRxRTxyeN3du4BciTc/LgSw2qWCwzfgsSa6ifyEQ1NibuhrYZYx+y/Xh1lvyVfOROpsM
         cvlp3+ojlJLLnItGwW0hZRhuUR59dQodOhKViWuLJh5VeB/nh+FVFnvtdaReYkrfprdo
         qo+x/PG5sCTdiA1g1iCfOJsYlpu+l4nfb8Kxz/GmTs581smN3M1Z2RjWODGAu0KJF2Os
         35NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmuT16BJbVyW9bCWLN0y4wNCBhHJaD0u7jFON8TGg9uk+LQED1aDgP9aSgpyuh7KrjMklU/flNY5lKdkdTNC857vbClg4A0LF7yg==
X-Gm-Message-State: AOJu0YxSbRCkjip3GHklhjGp4WSopZW4Fll1oDsxTogk6a/KILUc3vxu
	yCb4vwzYpzisDpT1G+DN0FgV0LvWZv58LUEUK4TJT9A1aKPjDYsU
X-Google-Smtp-Source: AGHT+IFkVLt6ZhrJ+Mk88Qj0+zLTEI8i6U6Pp7fDBVP+I8kkl10IsUNniwNrnOveK5Mfogtyzkd3sA==
X-Received: by 2002:a05:6402:42d1:b0:5b8:f69b:65e8 with SMTP id 4fb4d7f45d1cf-5bea1beba00mr1484632a12.0.1723618075536;
        Tue, 13 Aug 2024 23:47:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190ad278sm3534134a12.25.2024.08.13.23.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 23:47:55 -0700 (PDT)
Message-ID: <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
Date: Wed, 14 Aug 2024 08:47:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
From: Jiri Slaby <jirislaby@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14. 08. 24, 7:22, Jiri Slaby wrote:
> Hi,
> 
> one openSUSE's user reported that with 6.10, he sees one CPU under an 
> IRQ storm from ACPI (sci_interrupt):
>     9:   20220768          ...  IR-IO-APIC    9-fasteoi   acpi
> 
> At:
> https://bugzilla.suse.com/show_bug.cgi?id=1229085
> 
> 6.9 was OK.
> 
> With acpi.debug_level=0x08000000 acpi.debug_layer=0xffffffff, there is a 
> repeated load of:
>> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6D: 
>> Status=20, Enable=00, RunEnable=4A, WakeEnable=00

0x6d seems to count excessively (10 snapshots every 1 second):
> /sys/firmware/acpi/interrupts/gpe6D:   82066  EN STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:   86536  EN STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:   90990     STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:   95468  EN STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  100282  EN STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  105187     STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  110014     STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  114852     STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  119682     STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  124194     STS enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe6D:  128641  EN STS enabled      unmasked

acpidump:
https://bugzilla.suse.com/attachment.cgi?id=876677

DSDT:
https://bugzilla.suse.com/attachment.cgi?id=876678

> Any ideas?
> 
> thanks,-- 
js


