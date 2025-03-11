Return-Path: <linux-acpi+bounces-12092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED9A5C352
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3713A84BD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335A25B675;
	Tue, 11 Mar 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYBCztFY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBC1D63E2;
	Tue, 11 Mar 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702251; cv=none; b=Ikt8vK2OM5SoAfaGYvJWCNP0YvytoVvOz9VR+fvBNW7DlC8vtRS9ZIpc4YKZUJic/07O7dHmJ76YN51dIbhjesEf5s3HJXp3d954O4AkeEWFAoJU1nVaGz0vxyGXemZlrETGw1Bg095gmVp6FNGYytXXHJF4hEB0TZmyAh51LKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702251; c=relaxed/simple;
	bh=3hpTS0gQqp6V68QWmsgKSxFAydpLevnwrXU+CfdR8FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMZfQK3VPqB7HsRz7JX4ahJ6kVVxvnUviSqFbWRS3MaGDZMzSZzegRuyMga+2GcLBDrfOD57igAe6uj6KDXRqYOxrMZZL5P/oRYc+/Wb13MdUJU1U5DEFweh9B22U5mF/n+NRtVmzhkynuRmT3jU/Y4O2E/smQnY2KQLw3lno2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYBCztFY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409077c06so12605185ad.1;
        Tue, 11 Mar 2025 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741702249; x=1742307049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EtZ5HAnQy7cvwiwZJeJh9fV+EOdhGMm8Mbppg7sd37M=;
        b=nYBCztFYbYjAE1Wq1Uv4t8+jRp1wcsTOyju7MzxI1AVACCXbmw7iF6YHb70rDrPLm1
         CGPzZr9jh4X4Ujdi91s7en6j33PHo2bTuN8a2ZqsbmXunexc+G1kWZA5wp3fKlvgA5qw
         F5Wv65TMQ/Rksn9Xbj0bD+jIAEp9njggB+NvB5q8XKFgyAHL5LSN+grCcC60t9I2cpcu
         gnUuzRdsEbrXNNvWB8rsoh1yrwP8yWOrG4u4F7OL+sj2LEQxeAxHTaZZg/Wsyog/nz7q
         YCbnLOaT+GLZfDVwlh4/cExTRK5vqpH8pxbolYlVKG4Bgvb1IEp3vunPdn/LZyeFzidc
         oQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702249; x=1742307049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtZ5HAnQy7cvwiwZJeJh9fV+EOdhGMm8Mbppg7sd37M=;
        b=Du8s5tMx0hk8zsVk6VNkjubW0gX0GKk8bqBcPn1Uusxb6t5871h7YhgblkOMatKfwg
         0+ibfqQOa4Z2wtLBSYEadGM1MmUKpD/1y7nM5sy3pcUajFOfmQHnyOFpW5B7ZSGtmoYt
         Y/dGjpEqdwbHSLJmQtrvc7MqxFkcamAloY0cdZ7wtoIbXn6GESMHAbaRVVBk1PAASiCx
         /GMymLVObiKE7G9KPogrCSXTUw50c8vFQl+LtgubqHxJtDmnVx4RIz/UHOBlAByHwohy
         M1MaOfSbW63vKUMuMB7YpdHyVSpDVfeHnD/Qwo91dew5r7/RUgrLdIT5p4m1U99hLhQa
         OdJg==
X-Forwarded-Encrypted: i=1; AJvYcCW3b/1o5mOwQsfgGWdPADL8xCBxwE4zlXSl+EhtRN9a79He/9XdWUqHVlmIVck02fY3YVpY1PTKd112@vger.kernel.org, AJvYcCXpBCOCN8kCNHoq2soNanL1WOKnujTsEWzEej/v96Cl+jBdW7iY2j3KTTw6h4IkHKy07KcC+CYHSPPdh4tDrhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCo4p/SRQy1uFlMGGq22OW2fVNBSl6jKS3wO/znf5vsNGZNezi
	c6pY69jWacofz4BJTBhx/K4ISfAaaa1bRXZvsC/cgPM/sLFrggKr
X-Gm-Gg: ASbGncv7fHBh8ovuH8a3Rv4z/U5/lBtXTsCGVcRc/FcHGaIsmqr3DmRSgv5pi5KKSJt
	8rpQKEQdGvDDYloAyYRiPlesYyrBw2Px5bbo/P1BZWOgRBonHbpxuhJpxYskKxkldHW4BSdMIY+
	ExZa42G5V8JHIjOecVh9VVv6+p6yxnsPq/7Mu0c8Tl6Dd7HgvYzlYjTl7V6pUYLEHGq5oIKtqoG
	PTbImeGILaXnw5WUH3QfVp1LEN0Sl2J/taPvwX/XI9hY69qr6TIbN3L0ZCFSiDI5hfpdSC/q73G
	HAxs2QQnZs5V+vGXbvEUke5r3vnu8/UtR4HzVEVBt0faDnsEtgBKPzgCYnYOH53jb356K/m42n+
	5rGJjV4vP2/n36zPCMg==
X-Google-Smtp-Source: AGHT+IGpylnDzVchZ7zWxXyJPiK44/cpWeq9+72vWiB/U82lFUipENB14vik7LnVFxTzd5tF712w/Q==
X-Received: by 2002:a17:903:1788:b0:220:f87d:9d5b with SMTP id d9443c01a7336-22428a8ca41mr292910025ad.24.1741702248997;
        Tue, 11 Mar 2025 07:10:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109de260sm97970805ad.16.2025.03.11.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:10:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fea41656-ca80-491f-b84b-d118b35b5f72@roeck-us.net>
Date: Tue, 11 Mar 2025 07:10:46 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250311-ivo-intel_oc_wdt-v1-1-fd470460d9f5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 06:18, Diogo Ivo wrote:
> Add a driver for the Intel Over-Clocking Watchdog found in Intel
> Platform Controller (PCH) chipsets. This watchdog is controlled
> via a simple single-register interface and would otherwise be
> standard except for the presence of a LOCK bit that can only be
> set once per power cycle, needing extra handling around it.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>   drivers/acpi/acpi_pnp.c         |   2 +
>   drivers/watchdog/Kconfig        |  11 ++
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/intel_oc_wdt.c | 235 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 249 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
>    * device represented by it.
>    */
>   static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
> +	{"INT3F0D"},
>   	{"INTC1080"},
>   	{"INTC1081"},
> +	{"INTC1099"},
>   	{""},
>   };

This needs to be a separate patch.

>   
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f81705f8539aa0b12d156a86aae521aa40b4527d..16e6df441bb344c0f91b40bd76b6322ad3016e72 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
>   
>   	  To compile this driver as a module, choose M here.
>   
> +config INTEL_OC_WATCHDOG
> +	tristate "Intel OC Watchdog"
> +	depends on X86 && ACPI
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
> index 0000000000000000000000000000000000000000..0a2df3440024090f7e342fe7da895a7930ac09b2
> --- /dev/null
> +++ b/drivers/watchdog/intel_oc_wdt.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel OC Watchdog driver
> + *
> + * Copyright (C) 2025, Siemens SA
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
> +#define WDT_HEARTBEAT			60
> +static int heartbeat = WDT_HEARTBEAT;

Normally this is set to 0 and the default timeout is initialized together
with min_timeout and max_timeout. This lets the watchdog core override it
with devicetree data (if that is available).

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
> +			 * the watchdog and read the current timeout.
> +			 */

But the timeout is read below ? Do you mean "change the current timeout" ?

> +			nowayout = true;
> +
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
> +		dev_err(dev, "I/O address 0x%04llx already in use, device disabled\n",
> +		       (u64)(oc_wdt->ctrl_res->start));

Use %pa or %pR/%pr, and watch out for multi-line alignment.

Guenter


