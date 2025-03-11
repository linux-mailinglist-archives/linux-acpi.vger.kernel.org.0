Return-Path: <linux-acpi+bounces-12093-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A339EA5C450
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 15:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306653A6178
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5525DAE4;
	Tue, 11 Mar 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Dqfu1Z7U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8D25D918
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705187; cv=none; b=mesutcQbJtrTbL9C8RlP48vJ1e2YGBXZZCJnVO815OEKKhkk3HsN3xp0q0+ECM0U/1gSNvyhEf34Sy63XA5QzW4J+yDdXtetgVW6mbyVjOTHI/ACGxFHp6AtJ9sFSKkmki6Izct6oZ5q83JNkp0XCusviJWLN6trjbdr4PK/9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705187; c=relaxed/simple;
	bh=Yp1Z/Gwbv8eY4ug0JJTiAEgZ4Lj6fi/6L+m/LUPk2lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVmQBFlWW0nPDhTTwKA9fhBnoa6ndI6T+wBlSw7VlPgUwm9iahuDHj8PX1rmnu9uvhTvx4dAEweIvSXrS3vhVIiCUdrmoQ+jOQ206us0Lt5Y84h2uNODxbI1aSuocye7NfnN2HJ07ka1yxf8AxftlkJ87SNHUcGlfrrPhdo//d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Dqfu1Z7U; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025031114594076ff691caaa4d3f145
        for <linux-acpi@vger.kernel.org>;
        Tue, 11 Mar 2025 15:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+fym8S2bwboe7czSnu1vwF7z1uIsXJoLAxCTpQ1dfAI=;
 b=Dqfu1Z7Uik9kjSVMIARAubAlJWh2ooGS0D1teBolQA7bjwQDg7AJtDV3fzLJD2G+PU66s2
 MX+Wfm0fpuwkBhKg2W+kvZ26tFqjFu5qUfiVsZHk45sO3we6EGyO0txKhW7vRSX7PeHI8mKn
 fttOesaKf670r9xhg3GPidUBOJS7k3XYaYTxqsUWmcz9tTaFKPeKnXsMtR1F0WKwsXicnNj6
 BtwDbnSvU/6zvZPUUruY7sVHSeEaTnPlZ0AO/XLIuPKcdGvuxzCr0s/hs727rRRoFUA1WClq
 +TRg8CeSl1kFYAP4B3Gc1F4QLbvb26z7R2TFeWkTTL2kMqyYSQGHWDBw==;
Message-ID: <bc354400-52bf-46ee-8619-479c3fe9b28e@siemens.com>
Date: Tue, 11 Mar 2025 14:59:39 +0000
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
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <fea41656-ca80-491f-b84b-d118b35b5f72@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi Guenter, thanks for the quick review!

On 3/11/25 2:10 PM, Guenter Roeck wrote:
> On 3/11/25 06:18, Diogo Ivo wrote:
>> Add a driver for the Intel Over-Clocking Watchdog found in Intel
>> Platform Controller (PCH) chipsets. This watchdog is controlled
>> via a simple single-register interface and would otherwise be
>> standard except for the presence of a LOCK bit that can only be
>> set once per power cycle, needing extra handling around it.
>>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> ---
>>   drivers/acpi/acpi_pnp.c         |   2 +
>>   drivers/watchdog/Kconfig        |  11 ++
>>   drivers/watchdog/Makefile       |   1 +
>>   drivers/watchdog/intel_oc_wdt.c | 235 ++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   4 files changed, 249 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
>> index 
>> 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
>> --- a/drivers/acpi/acpi_pnp.c
>> +++ b/drivers/acpi/acpi_pnp.c
>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, 
>> const struct acpi_device_id **matc
>>    * device represented by it.
>>    */
>>   static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
>> +    {"INT3F0D"},
>>       {"INTC1080"},
>>       {"INTC1081"},
>> +    {"INTC1099"},
>>       {""},
>>   };
> 
> This needs to be a separate patch.

I will split it for v2.

>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 
>> f81705f8539aa0b12d156a86aae521aa40b4527d..16e6df441bb344c0f91b40bd76b6322ad3016e72 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
>>         To compile this driver as a module, choose M here.
>> +config INTEL_OC_WATCHDOG
>> +    tristate "Intel OC Watchdog"
>> +    depends on X86 && ACPI
>> +    select WATCHDOG_CORE
>> +    help
>> +      Hardware driver for Intel Over-Clocking watchdog present in
>> +      Platform Controller Hub (PCH) chipsets.
>> +
>> +      To compile this driver as a module, choose M here: the
>> +      module will be called intel_oc_wdt.
>> +
>>   config ITCO_WDT
>>       tristate "Intel TCO Timer/Watchdog"
>>       depends on X86 && PCI
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 
>> 8411626fa162268e8ccd06349f7193b15a9d281a..3a13f3e80a0f460b99b4f1592fcf17cc6428876b 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -149,6 +149,7 @@ obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
>>   obj-$(CONFIG_MACHZ_WDT) += machzwd.o
>>   obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
>>   obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>> +obj-$(CONFIG_INTEL_OC_WATCHDOG) += intel_oc_wdt.o
>>   obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>   obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>>   obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/ 
>> intel_oc_wdt.c
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..0a2df3440024090f7e342fe7da895a7930ac09b2
>> --- /dev/null
>> +++ b/drivers/watchdog/intel_oc_wdt.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel OC Watchdog driver
>> + *
>> + * Copyright (C) 2025, Siemens SA
>> + * Author: Diogo Ivo <diogo.ivo@siemens.com>
>> + */
>> +
>> +#define DRV_NAME    "intel_oc_wdt"
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bits.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/watchdog.h>
>> +
>> +#define INTEL_OC_WDT_TOV        GENMASK(9, 0)
>> +#define INTEL_OC_WDT_MIN_TOV        1
>> +#define INTEL_OC_WDT_MAX_TOV        1024
>> +
>> +/*
>> + * One-time writable lock bit. If set forbids
>> + * modification of itself, _TOV and _EN until
>> + * next reboot.
>> + */
>> +#define INTEL_OC_WDT_CTL_LCK        BIT(12)
>> +
>> +#define INTEL_OC_WDT_EN            BIT(14)
>> +#define INTEL_OC_WDT_NO_ICCSURV_STS    BIT(24)
>> +#define INTEL_OC_WDT_ICCSURV_STS    BIT(25)
>> +#define INTEL_OC_WDT_RLD        BIT(31)
>> +
>> +#define INTEL_OC_WDT_STS_BITS (INTEL_OC_WDT_NO_ICCSURV_STS | \
>> +                   INTEL_OC_WDT_ICCSURV_STS)
>> +
>> +#define INTEL_OC_WDT_CTRL_REG(wdt)    ((wdt)->ctrl_res->start)
>> +
>> +struct intel_oc_wdt {
>> +    struct watchdog_device wdd;
>> +    struct resource *ctrl_res;
>> +    bool locked;
>> +};
>> +
>> +#define WDT_HEARTBEAT            60
>> +static int heartbeat = WDT_HEARTBEAT;
> 
> Normally this is set to 0 and the default timeout is initialized together
> with min_timeout and max_timeout. This lets the watchdog core override it
> with devicetree data (if that is available).

Ok, thank you for the insight. I will address this for v2.
It is unlikely that this driver will have devicetree data but it's
better to follow best practice.

>> +module_param(heartbeat, uint, 0);
>> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. (default="
>> +         __MODULE_STRING(WDT_HEARTBEAT) ")");
>> +
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started 
>> (default="
>> +         __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +static int intel_oc_wdt_start(struct watchdog_device *wdd)
>> +{
>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>> +
>> +    if (oc_wdt->locked)
>> +        return 0;
>> +
>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_EN,
>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>> +
>> +    return 0;
>> +}
>> +
>> +static int intel_oc_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>> +
>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_EN,
>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>> +
>> +    return 0;
>> +}
>> +
>> +static int intel_oc_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>> +
>> +    outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_RLD,
>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>> +
>> +    return 0;
>> +}
>> +
>> +static int intel_oc_wdt_set_timeout(struct watchdog_device *wdd,
>> +                    unsigned int t)
>> +{
>> +    struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
>> +
>> +    outl((inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_TOV) | 
>> (t - 1),
>> +         INTEL_OC_WDT_CTRL_REG(oc_wdt));
>> +
>> +    wdd->timeout = t;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct watchdog_info intel_oc_wdt_info = {
>> +    .options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | 
>> WDIOF_KEEPALIVEPING,
>> +    .identity = DRV_NAME,
>> +};
>> +
>> +static const struct watchdog_ops intel_oc_wdt_ops = {
>> +    .owner = THIS_MODULE,
>> +    .start = intel_oc_wdt_start,
>> +    .stop = intel_oc_wdt_stop,
>> +    .ping = intel_oc_wdt_ping,
>> +    .set_timeout = intel_oc_wdt_set_timeout,
>> +};
>> +
>> +static int intel_oc_wdt_setup(struct intel_oc_wdt *oc_wdt)
>> +{
>> +    struct watchdog_info *info;
>> +    unsigned long val;
>> +
>> +    val = inl(INTEL_OC_WDT_CTRL_REG(oc_wdt));
>> +
>> +    if (val & INTEL_OC_WDT_STS_BITS)
>> +        oc_wdt->wdd.bootstatus |= WDIOF_CARDRESET;
>> +
>> +    oc_wdt->locked = !!(val & INTEL_OC_WDT_CTL_LCK);
>> +
>> +    if (val & INTEL_OC_WDT_EN) {
>> +        /*
>> +         * No need to issue a ping here to "commit" the new timeout
>> +         * value to hardware as the watchdog core schedules one
>> +         * immediately when registering the watchdog.
>> +         */
>> +        set_bit(WDOG_HW_RUNNING, &oc_wdt->wdd.status);
>> +
>> +        if (oc_wdt->locked) {
>> +            info = (struct watchdog_info *)&intel_oc_wdt_info;
>> +            /*
>> +             * Set nowayout unconditionally as we cannot stop
>> +             * the watchdog and read the current timeout.
>> +             */
> 
> But the timeout is read below ? Do you mean "change the current timeout" ?

In this case where the BIOS both enabled the watchdog and set the LOCK
bit we cannot change the timeout anymore, meaning that we have to read
the value currently in the register and pass it to the watchdog core,
which is what is done below.

>> +            nowayout = true;
>> +
>> +            oc_wdt->wdd.timeout = (val & INTEL_OC_WDT_TOV) + 1;
>> +            info->options &= ~WDIOF_SETTIMEOUT;
>> +
>> +            dev_info(oc_wdt->wdd.parent,
>> +                 "Register access locked, heartbeat fixed at: %u s\n",
>> +                 oc_wdt->wdd.timeout);
>> +        }
>> +    } else if (oc_wdt->locked) {
>> +        /*
>> +         * In case the watchdog is disabled and locked there
>> +         * is nothing we can do with it so just fail probing.
>> +         */
>> +        return -EACCES;
>> +    }
>> +
>> +    val &= ~INTEL_OC_WDT_TOV;
>> +    outl(val | (oc_wdt->wdd.timeout - 1), 
>> INTEL_OC_WDT_CTRL_REG(oc_wdt));
>> +
>> +    return 0;
>> +}
>> +
>> +static int intel_oc_wdt_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct intel_oc_wdt *oc_wdt;
>> +    struct watchdog_device *wdd;
>> +    int ret;
>> +
>> +    oc_wdt = devm_kzalloc(&pdev->dev, sizeof(*oc_wdt), GFP_KERNEL);
>> +    if (!oc_wdt)
>> +        return -ENOMEM;
>> +
>> +    oc_wdt->ctrl_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> +    if (!oc_wdt->ctrl_res) {
>> +        dev_err(&pdev->dev, "missing I/O resource\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    if (!devm_request_region(&pdev->dev, oc_wdt->ctrl_res->start,
>> +                 resource_size(oc_wdt->ctrl_res), pdev->name)) {
>> +        dev_err(dev, "I/O address 0x%04llx already in use, device 
>> disabled\n",
>> +               (u64)(oc_wdt->ctrl_res->start));
> 
> Use %pa or %pR/%pr, and watch out for multi-line alignment.

I will address this for v2.

> 
> Guenter
> 

Best regards,
Diogo

