Return-Path: <linux-acpi+bounces-12099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11674A5CB1D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A303B3B4586
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3826039F;
	Tue, 11 Mar 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="QVssYB2S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BE19E975
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711762; cv=none; b=LZXflfZj6KmuUVRH92R/zYd9KRDloT7YJDOxSP9Odk4bFBOpiwq+Jmp6BPmbYNSpKKOh49/+xACRNg0UkYVtjxYzOED4YV20VDFdbAW+RaSXsJ4C05Pa+MEoqjL9eQGkyOre6YM7D6ZbgOnI52VqsXEirhppYq61OmRy7Y7Go30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711762; c=relaxed/simple;
	bh=u+F//cZ1UgpTvl9mhVb92LvKNIukphzxazwTjPnXvv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMWQ+2k+9k4/h8kZBG/w+faIlZNvBnIHNEE1Dyo7d/CAZ2pEwJx03YJnzD8LdHLSBL4GYtY2jBfA9w84T/50KVM1k4213XcjYnJyc9MUpEikgJ9jJuACUd0Hzas5RIrRYFM4hzHxU2benjlUJQyJ+sMroiKJO0ZXDW3N9V6CyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=QVssYB2S; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202503111649159ba1e10fc71e759db4
        for <linux-acpi@vger.kernel.org>;
        Tue, 11 Mar 2025 17:49:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LO4Oi66aFoDRbKkoCWm/iGhfrvYWXFfo0k1ZnUAyzgQ=;
 b=QVssYB2Sx1SAXJ8tyYd4ASblVv+4gfHWNnqfZyOp5W6G8ggM/1h7zbYy8iMXKkB0YMyIn4
 Tt8wKFS5iVFfjVDuyGggIs+VuHNi4q+y5Hz6RUskNcB/+JannMR1wpJBMQqN5hHd2S2hbMIm
 Vuxs+WrkQ8/i/iNt+lf3dXB9qd/y2fAuRYbTR3kuu9sChWRcLgWkZ6jOu6rcljE/3F1LEFgC
 tLPDcPsvLwng1n1rWsBpfmSK5CsilVEucadGz3xa708JOnOiYeKppHqonpS4Yv8ekYwpfQRi
 L3bOinjYshe9/Lnn8PjaFehV45CRt5zx0xBxnN9IZzDnA4MSi/uGR6Yg==;
Message-ID: <f6aa7dd8-6ca7-4c79-b915-65ff7869d28c@siemens.com>
Date: Tue, 11 Mar 2025 16:49:14 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: Add driver for Intel OC WDT
To: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com,
 benedikt.niedermayr@siemens.com
References: <20250311-ivo-intel_oc_wdt-v1-1-fd470460d9f5@siemens.com>
 <fea41656-ca80-491f-b84b-d118b35b5f72@roeck-us.net>
 <bc354400-52bf-46ee-8619-479c3fe9b28e@siemens.com>
 <8bdf9a4d-5d25-4b53-947b-0644c00cc999@roeck-us.net>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <8bdf9a4d-5d25-4b53-947b-0644c00cc999@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

On 3/11/25 4:06 PM, Guenter Roeck wrote:
> On 3/11/25 07:59, Diogo Ivo wrote:
>> On 3/11/25 2:10 PM, Guenter Roeck wrote:
>>> On 3/11/25 06:18, Diogo Ivo wrote:
>>>> Add a driver for the Intel Over-Clocking Watchdog found in Intel
>>>> Platform Controller (PCH) chipsets. This watchdog is controlled
>>>> via a simple single-register interface and would otherwise be
>>>> standard except for the presence of a LOCK bit that can only be
>>>> set once per power cycle, needing extra handling around it.
>>>>
>>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>>> ---
>>>>   drivers/acpi/acpi_pnp.c         |   2 +
>>>>   drivers/watchdog/Kconfig        |  11 ++
>>>>   drivers/watchdog/Makefile       |   1 +
>>>>   drivers/watchdog/intel_oc_wdt.c | 235 ++++++++++++++++++++++++++++ 
>>>> ++ ++++++++++
>>>>   4 files changed, 249 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
>>>> index 
>>>> 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
>>>> --- a/drivers/acpi/acpi_pnp.c
>>>> +++ b/drivers/acpi/acpi_pnp.c
>>>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, 
>>>> const struct acpi_device_id **matc
>>>>    * device represented by it.
>>>>    */
>>>>   static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
>>>> +    {"INT3F0D"},
>>>>       {"INTC1080"},
>>>>       {"INTC1081"},
>>>> +    {"INTC1099"},
>>>>       {""},
>>>>   };
>>>
>>> This needs to be a separate patch.
>>
>> I will split it for v2.
>>
>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>> index 
>>>> f81705f8539aa0b12d156a86aae521aa40b4527d..16e6df441bb344c0f91b40bd76b6322ad3016e72 100644
>>>> --- a/drivers/watchdog/Kconfig
>>>> +++ b/drivers/watchdog/Kconfig
>>>> @@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
>>>>         To compile this driver as a module, choose M here.
>>>> +config INTEL_OC_WATCHDOG
>>>> +    tristate "Intel OC Watchdog"
>>>> +    depends on X86 && ACPI
>>>> +    select WATCHDOG_CORE
>>>> +    help
>>>> +      Hardware driver for Intel Over-Clocking watchdog present in
>>>> +      Platform Controller Hub (PCH) chipsets.
>>>> +
>>>> +      To compile this driver as a module, choose M here: the
>>>> +      module will be called intel_oc_wdt.
>>>> +
>>>>   config ITCO_WDT
>>>>       tristate "Intel TCO Timer/Watchdog"
>>>>       depends on X86 && PCI
>>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>>> index 
>>>> 8411626fa162268e8ccd06349f7193b15a9d281a..3a13f3e80a0f460b99b4f1592fcf17cc6428876b 100644
>>>> --- a/drivers/watchdog/Makefile
>>>> +++ b/drivers/watchdog/Makefile
>>>> @@ -149,6 +149,7 @@ obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
>>>>   obj-$(CONFIG_MACHZ_WDT) += machzwd.o
>>>>   obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
>>>>   obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>>>> +obj-$(CONFIG_INTEL_OC_WATCHDOG) += intel_oc_wdt.o
>>>>   obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>>>   obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>>>>   obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>>>> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/ 
>>>> intel_oc_wdt.c
>>>> new file mode 100644
>>>> index 
>>>> 0000000000000000000000000000000000000000..0a2df3440024090f7e342fe7da895a7930ac09b2
>>>> --- /dev/null
>>>> +++ b/drivers/watchdog/intel_oc_wdt.c
>>>> @@ -0,0 +1,235 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Intel OC Watchdog driver
>>>> + *
>>>> + * Copyright (C) 2025, Siemens SA
>>>> + * Author: Diogo Ivo <diogo.ivo@siemens.com>
>>>> + */
>>>> +
>>>> +#define DRV_NAME    "intel_oc_wdt"
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +#include <linux/bits.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/moduleparam.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/watchdog.h>
>>>> +
>>>> +#define INTEL_OC_WDT_TOV        GENMASK(9, 0)
>>>> +#define INTEL_OC_WDT_MIN_TOV        1
>>>> +#define INTEL_OC_WDT_MAX_TOV        1024
>>>> +
>>>> +/*
>>>> + * One-time writable lock bit. If set forbids
>>>> + * modification of itself, _TOV and _EN until
>>>> + * next reboot.
>>>> + */
>>>> +#define INTEL_OC_WDT_CTL_LCK        BIT(12)
>>>> +
>>>> +#define INTEL_OC_WDT_EN            BIT(14)
>>>> +#define INTEL_OC_WDT_NO_ICCSURV_STS    BIT(24)
>>>> +#define INTEL_OC_WDT_ICCSURV_STS    BIT(25)
>>>> +#define INTEL_OC_WDT_RLD        BIT(31)
>>>> +
>>>> +#define INTEL_OC_WDT_STS_BITS (INTEL_OC_WDT_NO_ICCSURV_STS | \
>>>> +                   INTEL_OC_WDT_ICCSURV_STS)
>>>> +
>>>> +#define INTEL_OC_WDT_CTRL_REG(wdt)    ((wdt)->ctrl_res->start)
>>>> +
>>>> +struct intel_oc_wdt {
>>>> +    struct watchdog_device wdd;
>>>> +    struct resource *ctrl_res;
>>>> +    bool locked;
>>>> +};
>>>> +
>>>> +#define WDT_HEARTBEAT            60
>>>> +static int heartbeat = WDT_HEARTBEAT;
>>>
>>> Normally this is set to 0 and the default timeout is initialized 
>>> together
>>> with min_timeout and max_timeout. This lets the watchdog core 
>>> override it
>>> with devicetree data (if that is available).
>>
>> Ok, thank you for the insight. I will address this for v2.
>> It is unlikely that this driver will have devicetree data but it's
>> better to follow best practice.
>>
> 
> I just submitted a patch to have the watchdog core also look into 
> firmware data,
> which would include data provided by ACPI.

Great to know, and all the more reason to apply your suggested change.

>>>> +module_param(heartbeat, uint, 0);
>>>> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. 
>>>> (default="
>>>> +         __MODULE_STRING(WDT_HEARTBEAT) ")");
>>>> +
>>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>>> +module_param(nowayout, bool, 0);
>>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started 
>>>> (default="
>>>> +         __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>>> +
>>>> +static int intel_oc_wdt_start(struct watchdog_device *wdd)
>>>> +{
>>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>>> +
>>>> +    if (oc_wdt->locked)
>>>> +        return 0;
>>>> +
>>>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_EN,
>>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int intel_oc_wdt_stop(struct watchdog_device *wdd)
>>>> +{
>>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>>> +
>>>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_EN,
>>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int intel_oc_wdt_ping(struct watchdog_device *wdd)
>>>> +{
>>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>>> +
>>>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_RLD,
>>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int intel_oc_wdt_set_timeout(struct watchdog_device *wdd,
>>>> +                    unsigned int t)
>>>> +{
>>>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>>>> +
>>>> +    outl((inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_TOV) | 
>>>> (t - 1),
>>>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>>> +
>>>> +    wdd->timeout = t;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct watchdog_info intel_oc_wdt_info = {
>>>> +    .options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | 
>>>> WDIOF_KEEPALIVEPING,
>>>> +    .identity = DRV_NAME,
>>>> +};
>>>> +
>>>> +static const struct watchdog_ops intel_oc_wdt_ops = {
>>>> +    .owner = THIS_MODULE,
>>>> +    .start = intel_oc_wdt_start,
>>>> +    .stop = intel_oc_wdt_stop,
>>>> +    .ping = intel_oc_wdt_ping,
>>>> +    .set_timeout = intel_oc_wdt_set_timeout,
>>>> +};
>>>> +
>>>> +static int intel_oc_wdt_setup(struct intel_oc_wdt *oc_wdt)
>>>> +{
>>>> +    struct watchdog_info *info;
>>>> +    unsigned long val;
>>>> +
>>>> +    val = inl(INTEL_OC_WDT_CTRL_REG(oc_wdt));
>>>> +
>>>> +    if (val & INTEL_OC_WDT_STS_BITS)
>>>> +        oc_wdt->wdd.bootstatus |= WDIOF_CARDRESET;
>>>> +
>>>> +    oc_wdt->locked = !!(val & INTEL_OC_WDT_CTL_LCK);
>>>> +
>>>> +    if (val & INTEL_OC_WDT_EN) {
>>>> +        /*
>>>> +         * No need to issue a ping here to "commit" the new timeout
>>>> +         * value to hardware as the watchdog core schedules one
>>>> +         * immediately when registering the watchdog.
>>>> +         */
>>>> +        set_bit(WDOG_HW_RUNNING, &oc_wdt->wdd.status);
>>>> +
>>>> +        if (oc_wdt->locked) {
>>>> +            info = (struct watchdog_info *)&intel_oc_wdt_info;
>>>> +            /*
>>>> +             * Set nowayout unconditionally as we cannot stop
>>>> +             * the watchdog and read the current timeout.
>>>> +             */
>>>
>>> But the timeout is read below ? Do you mean "change the current 
>>> timeout" ?
>>
>> In this case where the BIOS both enabled the watchdog and set the LOCK
>> bit we cannot change the timeout anymore, meaning that we have to read
>> the value currently in the register and pass it to the watchdog core,
>> which is what is done below.
>>
> Yes, but the comment says " we cannot stop the watchdog and _read_ the
> current timeout" (emphasis added), suggesting that the current timeout
> can not be _read_ if locked is true.
> 
>>>> +            nowayout = true;
>>>> +
>>>> +            oc_wdt->wdd.timeout = (val & INTEL_OC_WDT_TOV) + 1;
> 
> However, this code does read the timeout even if locked is set. That
> suggests that it is not possible to _change_ the timeout if locked is set,
> but that it is possible to read the current timeout.

Sorry for the confusing wording. Yes, according to the documentation [1]
this is exactly the case, we cannot change the timeout but it is possible
to read it. I will word this better in v2 to avoid confusion.

Best regards,
Diogo

[1]: 
https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-ioe-p-registers/over-clocking-wdt-control-oc-wdt-ctl-offset-54/

