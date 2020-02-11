Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFE1594D7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBKQZg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 11:25:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgBKQZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Feb 2020 11:25:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5FCF469BA5;
        Tue, 11 Feb 2020 16:25:34 +0000 (UTC)
Date:   Tue, 11 Feb 2020 17:25:33 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200211172533.08b27181@endymion>
In-Reply-To: <20200211135944.GF2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
        <20200210112326.GP2667@lahna.fi.intel.com>
        <20200211141147.20bad275@endymion>
        <20200211135944.GF2667@lahna.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 11 Feb 2020 15:59:44 +0200, Mika Westerberg wrote:
> If the default timeout is short then that might happen but I think WDAT
> spec had some "reasonable" lower limit.

Could you please point me to the WDAT specification? Somehow my web
search failed to spot it.

> You may set bigger default timeout during the probe by doing something
> like below. This should give some 30s time before the system is rebooted
> after the device is opened.
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index b069349b52f5..24351afe2718 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -439,6 +439,10 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wdat);
>  
>  	watchdog_set_nowayout(&wdat->wdd, nowayout);
> +
> +	/* Increase default timeout */
> +	wdat_wdt_set_timeout(&wdat->wdd, 30 * 1000);
> +
>  	return devm_watchdog_register_device(dev, &wdat->wdd);
>  }

That is a very valid point. We know that the device works fine when
using the iTCO_wdt driver, and the iTCO_wdt driver *does* set a timeout
value at probe time, it does not rely on the BIOS having set a sane
value beforehand. So maybe that's the problem.

Guenter, what is considered best practice for watchdog drivers in this
respect? Trust the BIOS or set an arbitrary timeout value?

Maybe we should read the timeout value before enabling the device, and
if it is unreasonably low (< 5 seconds), log a warning and reset the
value to a sane default (30 seconds)?

Alternatively, or in addition to that, maybe the wdat_wdt driver should
have a module parameter to set the default timeout value, as the
iTCO_wdt driver has? Or is this deprecated in favor of the
WDIOC_SETTIMEOUT ioctl? Problem with the ioctl is that it requires the
device node to be opened, which starts the count down (I think?)

-- 
Jean Delvare
SUSE L3 Support
