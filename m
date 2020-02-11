Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AA159513
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBKQh5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 11:37:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:38206 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBKQh5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Feb 2020 11:37:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347308112"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 Feb 2020 08:37:53 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 11 Feb 2020 18:37:53 +0200
Date:   Tue, 11 Feb 2020 18:37:53 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200211163753.GK2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
 <20200210112326.GP2667@lahna.fi.intel.com>
 <20200211141147.20bad275@endymion>
 <20200211135944.GF2667@lahna.fi.intel.com>
 <20200211172533.08b27181@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211172533.08b27181@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 11, 2020 at 05:25:33PM +0100, Jean Delvare wrote:
> On Tue, 11 Feb 2020 15:59:44 +0200, Mika Westerberg wrote:
> > If the default timeout is short then that might happen but I think WDAT
> > spec had some "reasonable" lower limit.
> 
> Could you please point me to the WDAT specification? Somehow my web
> search failed to spot it.

You can find it here:

  http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx

Most of the ACPI related documents not part of the spec itself are
listed in the following page:

  https://uefi.org/acpi

> 
> > You may set bigger default timeout during the probe by doing something
> > like below. This should give some 30s time before the system is rebooted
> > after the device is opened.
> > 
> > diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> > index b069349b52f5..24351afe2718 100644
> > --- a/drivers/watchdog/wdat_wdt.c
> > +++ b/drivers/watchdog/wdat_wdt.c
> > @@ -439,6 +439,10 @@ static int wdat_wdt_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, wdat);
> >  
> >  	watchdog_set_nowayout(&wdat->wdd, nowayout);
> > +
> > +	/* Increase default timeout */
> > +	wdat_wdt_set_timeout(&wdat->wdd, 30 * 1000);
> > +
> >  	return devm_watchdog_register_device(dev, &wdat->wdd);
> >  }
> 
> That is a very valid point. We know that the device works fine when
> using the iTCO_wdt driver, and the iTCO_wdt driver *does* set a timeout
> value at probe time, it does not rely on the BIOS having set a sane
> value beforehand. So maybe that's the problem.
> 
> Guenter, what is considered best practice for watchdog drivers in this
> respect? Trust the BIOS or set an arbitrary timeout value?
> 
> Maybe we should read the timeout value before enabling the device, and
> if it is unreasonably low (< 5 seconds), log a warning and reset the
> value to a sane default (30 seconds)?

Yes, that would work.

> Alternatively, or in addition to that, maybe the wdat_wdt driver should
> have a module parameter to set the default timeout value, as the
> iTCO_wdt driver has? Or is this deprecated in favor of the
> WDIOC_SETTIMEOUT ioctl? Problem with the ioctl is that it requires the
> device node to be opened, which starts the count down (I think?)

Indeed it seems to be the case if I understand watchdog core code
correctly.
