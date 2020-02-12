Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570D415A8BF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 13:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgBLMHe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 07:07:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:34028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgBLMHd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 07:07:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B0F3AD2C;
        Wed, 12 Feb 2020 12:07:32 +0000 (UTC)
Date:   Wed, 12 Feb 2020 13:07:01 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH 3/3] ACPI / watchdog: Set default timeout in probe
Message-ID: <20200212130701.1682e406@endymion>
In-Reply-To: <20200212110540.83559-3-mika.westerberg@linux.intel.com>
References: <20200211180331.11dbe525@endymion>
        <20200212110540.83559-1-mika.westerberg@linux.intel.com>
        <20200212110540.83559-3-mika.westerberg@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 12 Feb 2020 14:05:40 +0300, Mika Westerberg wrote:
> If the BIOS default timeout for the watchdog is too small userspace may
> not have enough time to configure new timeout after opening the device
> before the system is already reset. For this reason program default
> timeout of 30 seconds in the driver probe and allow userspace to change
> this from command line or through module parameter (wdat_wdt.timeout).
> 
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/watchdog/wdat_wdt.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 2132018f031d..7b0257163522 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -54,6 +54,13 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +#define WDAT_DEFAULT_TIMEOUT	30
> +
> +static int timeout = WDAT_DEFAULT_TIMEOUT;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +		 __MODULE_STRING(WDAT_DEFAULT_TIMEOUT) ")");
> +
>  static int wdat_wdt_read(struct wdat_wdt *wdat,
>  	 const struct wdat_instruction *instr, u32 *value)
>  {
> @@ -308,6 +315,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	const struct acpi_wdat_entry *entries;
>  	const struct acpi_table_wdat *tbl;
> +	int default_timeout = timeout;
>  	struct wdat_wdt *wdat;
>  	struct resource *res;
>  	void __iomem **regs;
> @@ -438,6 +446,22 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, wdat);
>  
> +	/*
> +	 * Set initial timeout so that userspace has time to configure
> +	 * the watchdog properly after it has opened the device. In some
> +	 * cases the BIOS default is too short and causes immediate reboot.
> +	 */
> +	default_timeout = timeout;

You have already done that at variable declaration time.

> +	if (timeout < wdat->wdd.min_hw_heartbeat_ms ||
> +	    timeout > wdat->wdd.max_hw_heartbeat_ms)

Comparing seconds to milliseconds is unlikely to give the expected
result.

> +		default_timeout = WDAT_DEFAULT_TIMEOUT;
> +	else
> +		default_timeout = timeout;

You have already done that twice ;-)

> +
> +	ret = wdat_wdt_set_timeout(&wdat->wdd, timeout);

You must pass "default_timeout" here, not "timeout", else the check
before serves no purpose. It might be less confusing to not introduce a
separate variable and just tweak timeout in place?

> +	if (ret)
> +		return ret;
> +
>  	watchdog_set_nowayout(&wdat->wdd, nowayout);
>  	return devm_watchdog_register_device(dev, &wdat->wdd);
>  }


-- 
Jean Delvare
SUSE L3 Support
