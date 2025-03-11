Return-Path: <linux-acpi+bounces-12098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A7A5CA40
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FD73A3797
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05A25DD06;
	Tue, 11 Mar 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="airIh9x+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F810E5;
	Tue, 11 Mar 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709174; cv=none; b=OoQdlpKXq41xK5/w/O4wI4z1GfwcHJ/8DLxw0c4HflK8uUYFV0NthB4F1J5l7TZEHZvgp4v1BUgsnJpr+YdgZ6D5Pyp+npikmDntyVcslXPugIkTp4H7Psb24NxoQ3z9ysmLYx9e1vsJgII9YYVkZJSqL0tGgTTCAvO2COJcM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709174; c=relaxed/simple;
	bh=3Ry3yf3JWmL0fBfyqbHe4M+TCvF4oI+xF7+wwor61xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gp0QXxE/IWzlqtRhRpo/bH1YM/+mFmAYb8H6eZaeTuVoMINcxZfEuhYOVsLgjuh2lcAbTUrg2WPuLaY5cTwbMQNJcRi9gXc3RDxCDwMcspj47AN2PkWMi2EIKOc57IsXooDkbF7kcXcetcICHvL9EA8EGNlFgS93h1sIzxxbtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=airIh9x+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224019ad9edso128808285ad.1;
        Tue, 11 Mar 2025 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741709172; x=1742313972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LG6kF6C4qwqb1cIfo+7C7Aea5SBDdamgsmDp86jI3Fw=;
        b=airIh9x+F+lsfUW0t8wAQdbSb/7guOTpu4eT6bH1WdeVRuE4dz/dU+QujojCO5LAzz
         uflnYnzkERzpFd1C1ZYvrTRUb9j+cygxtqHQ8XTnCkp5FBdu42s72e8MA8o21jjlZ6ec
         vhtXjYe7Dohojm0VM/vnEbgNBCCZs/1GBVeK/9maktFIDKHJQtnWj7CFbKvVjRBqHBYj
         GckHsjCILFm1skLUhGpIo5LExququlHxFxlYCa7wBwTjlfZ1x51qZPQgtQJrTw98fiNL
         SIdYRyvxw9OJBIY6CKTjitjL8aIbuzILM1lB72YOX4+608sLiqOTlgncz44L/KAMYhQf
         af+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709172; x=1742313972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG6kF6C4qwqb1cIfo+7C7Aea5SBDdamgsmDp86jI3Fw=;
        b=M2x72g+TaAHiuHd/1dmi3/0KFwLtl4T/NIbbnzcA2+ZHcUBT/m/VuepRXJ1hAy9dsb
         S3/lFYNa6KgPc10a8sJIdPYnVS0NyjnbwwRitQWGlRSqGASST2yOiYdZJaIXhx4Y+dWh
         1YYQiiv+TmvFMQv8LetTOzY7cZLPlzI6OHDM+OcyhuHBUDeM+RKDnycD1os7Kg6cij8e
         14HDNIUckBsE0CtoQUsN54btYb3B6uc0Yqw1jtrNOH6GNJtRYzIn2l4RpKEW4JtSVPft
         RywEplv0cSjN4AdrayJQTHV471x2xuZDLmHRJr3+IZer14bD1ibQm/o8J+Maom0aiz/5
         owNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqrWouO/lXhvFeMkwV8aXTx/zrmCtnCOjow6pnPn3jxxa0g6SKKpYUJaiiaxxLJ4SNqDoSmPAz6Gyh@vger.kernel.org, AJvYcCVw2yiAKNvZ/tKxjO/HIq/QS9oc+ka/4KnKHEYKTS1t8w1a8rfK3Rxf0f4QExb/sf9DpIEyvuae1N1uECu4M4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fInG8kwGpwtaY0v9o+GqUrpE+RLSDKI+oY02TB1WUjAD5YXD
	RARpyWnMkE4J4P9xn21aKyB45J5DwjFTt+yYZLNCmqHdlqJwAbKXJ64VwQ==
X-Gm-Gg: ASbGnctIFrlRiFpXJECi+ylF9R7WK38rS63qOf9tC41W3bmWeAJEZNsTGhcG47wSHwA
	N1kgl1EvWyOFNpvbDdgbMj7XXiy+EDsQFsAKj4CjuLaNeFuJlaBdCc9h8NErDiBnmZBuknjvFP8
	uUKeAIsQytIKb8JZYXLso538GKsSl0m4xRbHzsn1fgloo8WeFH2FFjv4JA4gsstF+Fm1KbZaPg1
	a4Aby0pgOnM20Nl84Iwakcm1VqiX9zibGv1vqap9JFFJlyecb7PDK8eNYRppjuAtUMDU/8ucGOV
	a8CnEFAOrpCzSpCwl7j870gg7Q14iM2AcKwcNi5zVTQVLynmEvFg+elHqbUF9DYrAsZPg5toTaX
	IhdVGejfOa9f5H/blAw==
X-Google-Smtp-Source: AGHT+IFkxLnyhiIuq3JW2E4AeBe6ThZgeQd09UhGO4Cw3olXu1+YXOcwu7I9xPzQt+yzK/JaB454+A==
X-Received: by 2002:a05:6a00:3e29:b0:736:2f20:9d1 with SMTP id d2e1a72fcca58-736aab287e7mr24853665b3a.23.1741709171760;
        Tue, 11 Mar 2025 09:06:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b589aae4sm8070443b3a.152.2025.03.11.09.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:06:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8bdf9a4d-5d25-4b53-947b-0644c00cc999@roeck-us.net>
Date: Tue, 11 Mar 2025 09:06:09 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: Add driver for Intel OC WDT
To: Diogo Ivo <diogo.ivo@siemens.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com,
 benedikt.niedermayr@siemens.com
References: <20250311-ivo-intel_oc_wdt-v1-1-fd470460d9f5@siemens.com>
 <fea41656-ca80-491f-b84b-d118b35b5f72@roeck-us.net>
 <bc354400-52bf-46ee-8619-479c3fe9b28e@siemens.com>
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
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <bc354400-52bf-46ee-8619-479c3fe9b28e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 07:59, Diogo Ivo wrote:
> Hi Guenter, thanks for the quick review!
> 
> On 3/11/25 2:10 PM, Guenter Roeck wrote:
>> On 3/11/25 06:18, Diogo Ivo wrote:
>>> Add a driver for the Intel Over-Clocking Watchdog found in Intel
>>> Platform Controller (PCH) chipsets. This watchdog is controlled
>>> via a simple single-register interface and would otherwise be
>>> standard except for the presence of a LOCK bit that can only be
>>> set once per power cycle, needing extra handling around it.
>>>
>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>> ---
>>>   drivers/acpi/acpi_pnp.c         |   2 +
>>>   drivers/watchdog/Kconfig        |  11 ++
>>>   drivers/watchdog/Makefile       |   1 +
>>>   drivers/watchdog/intel_oc_wdt.c | 235 ++++++++++++++++++++++++++++++ ++++++++++
>>>   4 files changed, 249 insertions(+)
>>>
>>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
>>> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
>>> --- a/drivers/acpi/acpi_pnp.c
>>> +++ b/drivers/acpi/acpi_pnp.c
>>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
>>>    * device represented by it.
>>>    */
>>>   static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
>>> +    {"INT3F0D"},
>>>       {"INTC1080"},
>>>       {"INTC1081"},
>>> +    {"INTC1099"},
>>>       {""},
>>>   };
>>
>> This needs to be a separate patch.
> 
> I will split it for v2.
> 
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index f81705f8539aa0b12d156a86aae521aa40b4527d..16e6df441bb344c0f91b40bd76b6322ad3016e72 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
>>>         To compile this driver as a module, choose M here.
>>> +config INTEL_OC_WATCHDOG
>>> +    tristate "Intel OC Watchdog"
>>> +    depends on X86 && ACPI
>>> +    select WATCHDOG_CORE
>>> +    help
>>> +      Hardware driver for Intel Over-Clocking watchdog present in
>>> +      Platform Controller Hub (PCH) chipsets.
>>> +
>>> +      To compile this driver as a module, choose M here: the
>>> +      module will be called intel_oc_wdt.
>>> +
>>>   config ITCO_WDT
>>>       tristate "Intel TCO Timer/Watchdog"
>>>       depends on X86 && PCI
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 8411626fa162268e8ccd06349f7193b15a9d281a..3a13f3e80a0f460b99b4f1592fcf17cc6428876b 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -149,6 +149,7 @@ obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
>>>   obj-$(CONFIG_MACHZ_WDT) += machzwd.o
>>>   obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
>>>   obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>>> +obj-$(CONFIG_INTEL_OC_WATCHDOG) += intel_oc_wdt.o
>>>   obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>>   obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>>>   obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>>> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/ intel_oc_wdt.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..0a2df3440024090f7e342fe7da895a7930ac09b2
>>> --- /dev/null
>>> +++ b/drivers/watchdog/intel_oc_wdt.c
>>> @@ -0,0 +1,235 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Intel OC Watchdog driver
>>> + *
>>> + * Copyright (C) 2025, Siemens SA
>>> + * Author: Diogo Ivo <diogo.ivo@siemens.com>
>>> + */
>>> +
>>> +#define DRV_NAME    "intel_oc_wdt"
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/bits.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/moduleparam.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +#define INTEL_OC_WDT_TOV        GENMASK(9, 0)
>>> +#define INTEL_OC_WDT_MIN_TOV        1
>>> +#define INTEL_OC_WDT_MAX_TOV        1024
>>> +
>>> +/*
>>> + * One-time writable lock bit. If set forbids
>>> + * modification of itself, _TOV and _EN until
>>> + * next reboot.
>>> + */
>>> +#define INTEL_OC_WDT_CTL_LCK        BIT(12)
>>> +
>>> +#define INTEL_OC_WDT_EN            BIT(14)
>>> +#define INTEL_OC_WDT_NO_ICCSURV_STS    BIT(24)
>>> +#define INTEL_OC_WDT_ICCSURV_STS    BIT(25)
>>> +#define INTEL_OC_WDT_RLD        BIT(31)
>>> +
>>> +#define INTEL_OC_WDT_STS_BITS (INTEL_OC_WDT_NO_ICCSURV_STS | \
>>> +                   INTEL_OC_WDT_ICCSURV_STS)
>>> +
>>> +#define INTEL_OC_WDT_CTRL_REG(wdt)    ((wdt)->ctrl_res->start)
>>> +
>>> +struct intel_oc_wdt {
>>> +    struct watchdog_device wdd;
>>> +    struct resource *ctrl_res;
>>> +    bool locked;
>>> +};
>>> +
>>> +#define WDT_HEARTBEAT            60
>>> +static int heartbeat = WDT_HEARTBEAT;
>>
>> Normally this is set to 0 and the default timeout is initialized together
>> with min_timeout and max_timeout. This lets the watchdog core override it
>> with devicetree data (if that is available).
> 
> Ok, thank you for the insight. I will address this for v2.
> It is unlikely that this driver will have devicetree data but it's
> better to follow best practice.
> 

I just submitted a patch to have the watchdog core also look into firmware data,
which would include data provided by ACPI.

>>> +module_param(heartbeat, uint, 0);
>>> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. (default="
>>> +         __MODULE_STRING(WDT_HEARTBEAT) ")");
>>> +
>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>> +module_param(nowayout, bool, 0);
>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>>> +         __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>> +
>>> +static int intel_oc_wdt_start(struct watchdog_device *wdd)
>>> +{
>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>> +
>>> +    if (oc_wdt->locked)
>>> +        return 0;
>>> +
>>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_EN,
>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int intel_oc_wdt_stop(struct watchdog_device *wdd)
>>> +{
>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>> +
>>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_EN,
>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int intel_oc_wdt_ping(struct watchdog_device *wdd)
>>> +{
>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>> +
>>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_RLD,
>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int intel_oc_wdt_set_timeout(struct watchdog_device *wdd,
>>> +                    unsigned int t)
>>> +{
>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>> +
>>> +    outl((inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_TOV) | (t - 1),
>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>> +
>>> +    wdd->timeout = t;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct watchdog_info intel_oc_wdt_info = {
>>> +    .options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>>> +    .identity = DRV_NAME,
>>> +};
>>> +
>>> +static const struct watchdog_ops intel_oc_wdt_ops = {
>>> +    .owner = THIS_MODULE,
>>> +    .start = intel_oc_wdt_start,
>>> +    .stop = intel_oc_wdt_stop,
>>> +    .ping = intel_oc_wdt_ping,
>>> +    .set_timeout = intel_oc_wdt_set_timeout,
>>> +};
>>> +
>>> +static int intel_oc_wdt_setup(struct intel_oc_wdt *oc_wdt)
>>> +{
>>> +    struct watchdog_info *info;
>>> +    unsigned long val;
>>> +
>>> +    val = inl(INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>> +
>>> +    if (val & INTEL_OC_WDT_STS_BITS)
>>> +        oc_wdt->wdd.bootstatus |= WDIOF_CARDRESET;
>>> +
>>> +    oc_wdt->locked = !!(val & INTEL_OC_WDT_CTL_LCK);
>>> +
>>> +    if (val & INTEL_OC_WDT_EN) {
>>> +        /*
>>> +         * No need to issue a ping here to "commit" the new timeout
>>> +         * value to hardware as the watchdog core schedules one
>>> +         * immediately when registering the watchdog.
>>> +         */
>>> +        set_bit(WDOG_HW_RUNNING, &oc_wdt->wdd.status);
>>> +
>>> +        if (oc_wdt->locked) {
>>> +            info = (struct watchdog_info *)&intel_oc_wdt_info;
>>> +            /*
>>> +             * Set nowayout unconditionally as we cannot stop
>>> +             * the watchdog and read the current timeout.
>>> +             */
>>
>> But the timeout is read below ? Do you mean "change the current timeout" ?
> 
> In this case where the BIOS both enabled the watchdog and set the LOCK
> bit we cannot change the timeout anymore, meaning that we have to read
> the value currently in the register and pass it to the watchdog core,
> which is what is done below.
> 
Yes, but the comment says " we cannot stop the watchdog and _read_ the
current timeout" (emphasis added), suggesting that the current timeout
can not be _read_ if locked is true.

>>> +            nowayout = true;
>>> +
>>> +            oc_wdt->wdd.timeout = (val & INTEL_OC_WDT_TOV) + 1;

However, this code does read the timeout even if locked is set. That
suggests that it is not possible to _change_ the timeout if locked is set,
but that it is possible to read the current timeout.

Guenter


