Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A976F15ACB0
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgBLQET (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 11:04:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:33086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLQET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 11:04:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76706AF3E;
        Wed, 12 Feb 2020 16:04:17 +0000 (UTC)
Date:   Wed, 12 Feb 2020 17:04:16 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH v2 3/3] ACPI / watchdog: Set default timeout in probe
Message-ID: <20200212170416.3df50e15@endymion>
In-Reply-To: <20200212145941.32914-4-mika.westerberg@linux.intel.com>
References: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
        <20200212145941.32914-4-mika.westerberg@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 12 Feb 2020 17:59:41 +0300, Mika Westerberg wrote:
> If the BIOS default timeout for the watchdog is too small userspace may
> not have enough time to configure new timeout after opening the device
> before the system is already reset. For this reason program default
> timeout of 30 seconds in the driver probe and allow userspace to change
> this from command line or through module parameter (wdat_wdt.timeout).
> 
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/watchdog/wdat_wdt.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index e1b1fcfc02af..3065dd670a18 100644
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
> @@ -438,6 +445,22 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, wdat);
>  
> +	/*
> +	 * Set initial timeout so that userspace has time to configure the
> +	 * watchdog properly after it has opened the device. In some cases
> +	 * the BIOS default is too short and causes immediate reboot.
> +	 */
> +	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
> +	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
> +		dev_warn(dev, "Invalid timeout %d given, using %d\n",
> +			 timeout, WDAT_DEFAULT_TIMEOUT);
> +		timeout = WDAT_DEFAULT_TIMEOUT;
> +	}
> +
> +	ret = wdat_wdt_set_timeout(&wdat->wdd, timeout);
> +	if (ret)
> +		return ret;
> +
>  	watchdog_set_nowayout(&wdat->wdd, nowayout);
>  	return devm_watchdog_register_device(dev, &wdat->wdd);
>  }

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks Mika!

-- 
Jean Delvare
SUSE L3 Support
