Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901F715A8E1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBLMNw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 07:13:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:43990 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgBLMNw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 07:13:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:13:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347504215"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 04:13:48 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 14:13:48 +0200
Date:   Wed, 12 Feb 2020 14:13:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH 3/3] ACPI / watchdog: Set default timeout in probe
Message-ID: <20200212121348.GD2667@lahna.fi.intel.com>
References: <20200211180331.11dbe525@endymion>
 <20200212110540.83559-1-mika.westerberg@linux.intel.com>
 <20200212110540.83559-3-mika.westerberg@linux.intel.com>
 <20200212130701.1682e406@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212130701.1682e406@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 01:07:01PM +0100, Jean Delvare wrote:
> On Wed, 12 Feb 2020 14:05:40 +0300, Mika Westerberg wrote:
> > If the BIOS default timeout for the watchdog is too small userspace may
> > not have enough time to configure new timeout after opening the device
> > before the system is already reset. For this reason program default
> > timeout of 30 seconds in the driver probe and allow userspace to change
> > this from command line or through module parameter (wdat_wdt.timeout).
> > 
> > Reported-by: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/watchdog/wdat_wdt.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> > index 2132018f031d..7b0257163522 100644
> > --- a/drivers/watchdog/wdat_wdt.c
> > +++ b/drivers/watchdog/wdat_wdt.c
> > @@ -54,6 +54,13 @@ module_param(nowayout, bool, 0);
> >  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> >  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> >  
> > +#define WDAT_DEFAULT_TIMEOUT	30
> > +
> > +static int timeout = WDAT_DEFAULT_TIMEOUT;
> > +module_param(timeout, int, 0);
> > +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> > +		 __MODULE_STRING(WDAT_DEFAULT_TIMEOUT) ")");
> > +
> >  static int wdat_wdt_read(struct wdat_wdt *wdat,
> >  	 const struct wdat_instruction *instr, u32 *value)
> >  {
> > @@ -308,6 +315,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	const struct acpi_wdat_entry *entries;
> >  	const struct acpi_table_wdat *tbl;
> > +	int default_timeout = timeout;
> >  	struct wdat_wdt *wdat;
> >  	struct resource *res;
> >  	void __iomem **regs;
> > @@ -438,6 +446,22 @@ static int wdat_wdt_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, wdat);
> >  
> > +	/*
> > +	 * Set initial timeout so that userspace has time to configure
> > +	 * the watchdog properly after it has opened the device. In some
> > +	 * cases the BIOS default is too short and causes immediate reboot.
> > +	 */
> > +	default_timeout = timeout;
> 
> You have already done that at variable declaration time.
> 
> > +	if (timeout < wdat->wdd.min_hw_heartbeat_ms ||
> > +	    timeout > wdat->wdd.max_hw_heartbeat_ms)
> 
> Comparing seconds to milliseconds is unlikely to give the expected
> result.
> 
> > +		default_timeout = WDAT_DEFAULT_TIMEOUT;
> > +	else
> > +		default_timeout = timeout;
> 
> You have already done that twice ;-)
> 
> > +
> > +	ret = wdat_wdt_set_timeout(&wdat->wdd, timeout);
> 
> You must pass "default_timeout" here, not "timeout", else the check
> before serves no purpose. It might be less confusing to not introduce a
> separate variable and just tweak timeout in place?

Heh, looks like this whole patch series is completely broken. Thanks for
taking time to review it and spotting all those errors. I'll fix all
these up in v2.

Sorry about this mess.
