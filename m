Return-Path: <linux-acpi+bounces-12224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E3A60348
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 22:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2B07A60AA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1D1DE2A6;
	Thu, 13 Mar 2025 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEsCcXsT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99765747F;
	Thu, 13 Mar 2025 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900542; cv=none; b=CQYjW1syoM2ZpWEhMC/EIUB8ejkUE6zDmfH5Ct2hJPeMLvGatOsSmxGGejvBM42iLmcISjGGM69W04jhb0g+FMhQB7Hh+cBUg3RkvbZSu08n7A2PjDAH/TZGRWjXvJ610+NsU+jXAipYmbW0ON3IOIa0Z8jr2PLtU4Uk9Jy84LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900542; c=relaxed/simple;
	bh=9ok4p9hIX5+D6QrDNJyiEFzdT2n+K1YYBhFqPdvqxa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+3VecAbsIED23NoTmoOSOc6Qfwfs62i0cE9RmvtFuVlJfTiFKkzUCKZdWb6Qp575OPcKlLdaL14CCvAlpM7zG6yXwC52vwtS5uTS2gA97oWfUgZirUv7mdIPzBA5gwTolgct8qDyvfSinIIS+sI4TKCoburWRN5NlV8l0ZVImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEsCcXsT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223594b3c6dso29217635ad.2;
        Thu, 13 Mar 2025 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741900540; x=1742505340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=10wOdJ7/MwRRGakrv8MdUF2Kg23ZceZnrBHF3kW3wOg=;
        b=aEsCcXsTe5ThCEg4idAndHSFzgOqOV7J6U6PU37HnL5WbvnjhyF9sSgr0DnkrSd6lg
         Mh7kRj8SNknm7FEFdHfrB6wFsQ26Rkpn/E11nZwMTYe5beNc45o3gfXowKZoh+x5+H+C
         O80EtNas7wlDTslHubtz41PcfapAumlhIu15JVJJyNfirSjLstUp7yW1nGcsdR3Mi0Ob
         tlb2ivte7q3fJlBhOOOEwpwVwAkUvtw7YCQcO1WJ9n4+7edPUm3chcAoCzI7vFR4d5cH
         d4Eg9pQCfY/mWzd1tLMrKAzNx0P5WzkqU3hmHoVO20hIhgvb1ADqaFRblw1eG0dJAKaV
         4TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900540; x=1742505340;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10wOdJ7/MwRRGakrv8MdUF2Kg23ZceZnrBHF3kW3wOg=;
        b=xAG3J3JETG72MzC+SHtig7mjwnbbj99R7q8pnzGeN5VVbz8c8YaBCxaHfRzGNi2tyW
         /ykrNvI8IXrPgc47w+Hb1AJVq6eONG+jirt4jztK0bzujx2L8Efr611+3HgMqXKZN+xD
         fW2qShnUZU4KNv3BA129etQVgxmYUeKYNkTM3P4t0GScr0f8aIppiT5bp7GcC9wGOddT
         p2Y1I/Dvd0gVT7kRnVv2StuexOj5mKNJf5K6UenhrYzQFqickvUyL9dKT38bw3FH8NlW
         8tuXRk06M00LxHmeiBX3NbM+KRUh77gxvg7zC7hKpYBx+u7TG2Agn+N4JAj5yITcIyBT
         5jmw==
X-Forwarded-Encrypted: i=1; AJvYcCW8oK4eMbDIkEeaP/uqzT4PUOjt4fFckcUKuYS4c0CAm5QNYCx1z/nwkJmyYE5DdfK6FU8Py3+FEtGS@vger.kernel.org, AJvYcCWziIRs6KGmlKJFsAoa/9saq//GfsndPTGnbyXwYWn+R0IG8EVytnWiBpUl9KQUmVd7/+C+o63fXrB+8RqLTrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCN2P0ohcTndCcEbHk6P03iQiYhRPMPO7GfgoS6aBTtOmOuK8
	XT3p6pwqEgIbQO68KmbVTPaDBnpbBLv7zm1gvZyuIGcGiEGHZik7
X-Gm-Gg: ASbGnct9xkKqJ1uwiH/LtSQSZGXc88QOxjXZIrJGQ+a47+P0KQIbzfnfdMyV8OVZ/8v
	PnSp4yQBMUr6VwTDD3hZwSHPwHv+xAowoYRQOQMp2mn9SKYIsJiwITo0sbOhTKPHTgFCUE3mG9Z
	a8/W+AkMolsCgMAlJ8p2+dh/ZAqa4wX4MarKoqZUDlZMWuWbUwrzZY6Iil+hHQcs0GSiqkBLuR0
	jBsfTZOBrmJvFch2KDfNxhBbU7nVeBcWGHmhwwW20poJB4if2O/Hs94XPas9JV/98nEBWK3t78X
	kwfSeBx6xGC1kO8RqVsGjda7ndXTP3pVzc+TcbDduKdZQy12c91JGv9VEQyAc2gdOa6+WcAeek+
	An2NflbmO1k9Pzecw1A==
X-Google-Smtp-Source: AGHT+IHi5bKTCrC3nXYr4XIqI6qJhMvB3IZIevoLX+IYtV+cgmu4L7acl1LMt5qdUjY6SuM+hymR6w==
X-Received: by 2002:aa7:88c8:0:b0:736:64b7:f104 with SMTP id d2e1a72fcca58-73722338721mr47340b3a.5.1741900539511;
        Thu, 13 Mar 2025 14:15:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9fe51asm1733927a12.36.2025.03.13.14.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 14:15:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <59f0a8f2-0a66-40df-8fbb-70ca1c228990@roeck-us.net>
Date: Thu, 13 Mar 2025 14:15:37 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] watchdog: Add driver for Intel OC WDT
To: Diogo Ivo <diogo.ivo@siemens.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com,
 benedikt.niedermayr@siemens.com
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
 <20250312-ivo-intel_oc_wdt-v2-1-52d09738cd0b@siemens.com>
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
In-Reply-To: <20250312-ivo-intel_oc_wdt-v2-1-52d09738cd0b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 08:46, Diogo Ivo wrote:
> Add a driver for the Intel Over-Clocking Watchdog found in Intel
> Platform Controller (PCH) chipsets. This watchdog is controlled
> via a simple single-register interface and would otherwise be
> standard except for the presence of a LOCK bit that can only be
> set once per power cycle, needing extra handling around it.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1->v2:
>   - Split v1 into two patches, adding the ACPI IDs in a separate patch
>   - Initialize hearbeat module parameter to zero
>   - Clarify wording around lock handling
>   - Properly print resource with %pR when failing to obtain it
>   - Enable compile testing and add dependency on HAS_IOPORT
>   - Drop unneeded ACPI_PTR() and MODULE_ALIAS()
> ---
> ---
>   drivers/watchdog/Kconfig        |  11 ++
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/intel_oc_wdt.c | 233 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 245 insertions(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f81705f8539aa0b12d156a86aae521aa40b4527d..94d058c6c49a19f8fee97d82ceb653b60d1944cd 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
>   
>   	  To compile this driver as a module, choose M here.
>   
> +config INTEL_OC_WATCHDOG
> +	tristate "Intel OC Watchdog"
> +	depends on (X86 || COMPILE_TEST) && ACPI && HAS_IOPORT
> +	select WATCHDOG_CORE
> +	help
> +	  Hardware driver for Intel Over-Clocking watchdog present in
> +	  Platform Controller Hub (PCH) chipsets.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called intel_oc_wdt.
> +
>   config ITCO_WDT
>   	tristate "Intel TCO Timer/Watchdog"
>   	depends on X86 && PCI
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 8411626fa162268e8ccd06349f7193b15a9d281a..3a13f3e80a0f460b99b4f1592fcf17cc6428876b 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -149,6 +149,7 @@ obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
>   obj-$(CONFIG_MACHZ_WDT) += machzwd.o
>   obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
>   obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
> +obj-$(CONFIG_INTEL_OC_WATCHDOG) += intel_oc_wdt.o
>   obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>   obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>   obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7c0551106981b08f9e1d2eab8f3ddce99a2462aa
> --- /dev/null
> +++ b/drivers/watchdog/intel_oc_wdt.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel OC Watchdog driver
> + *
> + * Copyright (C) 2025, Siemens
> + * Author: Diogo Ivo <diogo.ivo@siemens.com>
> + */
> +
> +#define DRV_NAME	"intel_oc_wdt"
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#define INTEL_OC_WDT_TOV		GENMASK(9, 0)
> +#define INTEL_OC_WDT_MIN_TOV		1
> +#define INTEL_OC_WDT_MAX_TOV		1024
> +#define INTEL_OC_WDT_DEF_TOV		60
> +
> +/*
> + * One-time writable lock bit. If set forbids
> + * modification of itself, _TOV and _EN until
> + * next reboot.
> + */
> +#define INTEL_OC_WDT_CTL_LCK		BIT(12)
> +
> +#define INTEL_OC_WDT_EN			BIT(14)
> +#define INTEL_OC_WDT_NO_ICCSURV_STS	BIT(24)
> +#define INTEL_OC_WDT_ICCSURV_STS	BIT(25)
> +#define INTEL_OC_WDT_RLD		BIT(31)
> +
> +#define INTEL_OC_WDT_STS_BITS (INTEL_OC_WDT_NO_ICCSURV_STS | \
> +			       INTEL_OC_WDT_ICCSURV_STS)
> +
> +#define INTEL_OC_WDT_CTRL_REG(wdt)	((wdt)->ctrl_res->start)
> +
> +struct intel_oc_wdt {
> +	struct watchdog_device wdd;
> +	struct resource *ctrl_res;
> +	bool locked;
> +};
> +
> +static int heartbeat;
> +module_param(heartbeat, uint, 0);
> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. (default="
> +		 __MODULE_STRING(WDT_HEARTBEAT) ")");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int intel_oc_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
> +
> +	if (oc_wdt->locked)
> +		return 0;
> +
> +	outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_EN,
> +	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
> +
> +	return 0;
> +}
> +
> +static int intel_oc_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
> +
> +	outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_EN,
> +	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
> +
> +	return 0;
> +}
> +
> +static int intel_oc_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
> +
> +	outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_RLD,
> +	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
> +
> +	return 0;
> +}
> +
> +static int intel_oc_wdt_set_timeout(struct watchdog_device *wdd,
> +				    unsigned int t)
> +{
> +	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
> +
> +	outl((inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_TOV) | (t - 1),
> +	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
> +
> +	wdd->timeout = t;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info intel_oc_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = DRV_NAME,
> +};
> +
> +static const struct watchdog_ops intel_oc_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = intel_oc_wdt_start,
> +	.stop = intel_oc_wdt_stop,
> +	.ping = intel_oc_wdt_ping,
> +	.set_timeout = intel_oc_wdt_set_timeout,
> +};
> +
> +static int intel_oc_wdt_setup(struct intel_oc_wdt *oc_wdt)
> +{
> +	struct watchdog_info *info;
> +	unsigned long val;
> +
> +	val = inl(INTEL_OC_WDT_CTRL_REG(oc_wdt));
> +
> +	if (val & INTEL_OC_WDT_STS_BITS)
> +		oc_wdt->wdd.bootstatus |= WDIOF_CARDRESET;
> +
> +	oc_wdt->locked = !!(val & INTEL_OC_WDT_CTL_LCK);
> +
> +	if (val & INTEL_OC_WDT_EN) {
> +		/*
> +		 * No need to issue a ping here to "commit" the new timeout
> +		 * value to hardware as the watchdog core schedules one
> +		 * immediately when registering the watchdog.
> +		 */
> +		set_bit(WDOG_HW_RUNNING, &oc_wdt->wdd.status);
> +
> +		if (oc_wdt->locked) {
> +			info = (struct watchdog_info *)&intel_oc_wdt_info;
> +			/*
> +			 * Set nowayout unconditionally as we cannot stop
> +			 * the watchdog.
> +			 */
> +			nowayout = true;
> +			/*
> +			 * If we are locked read the current timeout value
> +			 * and inform the core we can't change it.
> +			 */
> +			oc_wdt->wdd.timeout = (val & INTEL_OC_WDT_TOV) + 1;
> +			info->options &= ~WDIOF_SETTIMEOUT;
> +
> +			dev_info(oc_wdt->wdd.parent,
> +				 "Register access locked, heartbeat fixed at: %u s\n",
> +				 oc_wdt->wdd.timeout);
> +		}
> +	} else if (oc_wdt->locked) {
> +		/*
> +		 * In case the watchdog is disabled and locked there
> +		 * is nothing we can do with it so just fail probing.
> +		 */
> +		return -EACCES;
> +	}
> +
> +	val &= ~INTEL_OC_WDT_TOV;
> +	outl(val | (oc_wdt->wdd.timeout - 1), INTEL_OC_WDT_CTRL_REG(oc_wdt));
> +
> +	return 0;
> +}
> +
> +static int intel_oc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_oc_wdt *oc_wdt;
> +	struct watchdog_device *wdd;
> +	int ret;
> +
> +	oc_wdt = devm_kzalloc(&pdev->dev, sizeof(*oc_wdt), GFP_KERNEL);
> +	if (!oc_wdt)
> +		return -ENOMEM;
> +
> +	oc_wdt->ctrl_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!oc_wdt->ctrl_res) {
> +		dev_err(&pdev->dev, "missing I/O resource\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!devm_request_region(&pdev->dev, oc_wdt->ctrl_res->start,
> +				 resource_size(oc_wdt->ctrl_res), pdev->name)) {
> +		dev_err(dev, "resource %pR already in use, device disabled\n",
> +			oc_wdt->ctrl_res);
> +		return -EBUSY;
> +	}
> +
> +	wdd = &oc_wdt->wdd;
> +	wdd->min_timeout = INTEL_OC_WDT_MIN_TOV;
> +	wdd->max_timeout = INTEL_OC_WDT_MAX_TOV;
> +	wdd->timeout = INTEL_OC_WDT_DEF_TOV;
> +	wdd->info = &intel_oc_wdt_info;
> +	wdd->ops = &intel_oc_wdt_ops;
> +	wdd->parent = dev;
> +
> +	watchdog_init_timeout(wdd, heartbeat, dev);
> +
> +	ret = intel_oc_wdt_setup(oc_wdt);
> +	if (ret)
> +		return ret;
> +
> +	watchdog_set_drvdata(wdd, oc_wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +	watchdog_stop_on_reboot(wdd);
> +	watchdog_stop_on_unregister(wdd);
> +
> +	return devm_watchdog_register_device(dev, wdd);
> +}
> +
> +static const struct acpi_device_id intel_oc_wdt_match[] = {
> +	{ "INT3F0D" },
> +	{ "INTC1099" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);
> +
> +static struct platform_driver intel_oc_wdt_platform_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.acpi_match_table = intel_oc_wdt_match,
> +	},
> +	.probe = intel_oc_wdt_probe,
> +};
> +
> +module_platform_driver(intel_oc_wdt_platform_driver);
> +
> +MODULE_AUTHOR("Diogo Ivo <diogo.ivo@siemens.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Intel OC Watchdog driver");
> 


